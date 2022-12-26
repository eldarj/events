import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_events/activity/events/partial/event.actions.partial.dart';
import 'package:dubai_events/activity/events/partial/event.details.partial.dart';
import 'package:dubai_events/activity/events/single/single.event.activity.dart';
import 'package:dubai_events/activity/settings/overview/settings.overview.activity.dart';
import 'package:dubai_events/event-bus/menu-events.publisher.dart';
import 'package:dubai_events/main.dart';
import 'package:dubai_events/service/client/http.client.dart';
import 'package:dubai_events/service/client/http.response.extension.dart';
import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/shared/activity-title/activity.title.component.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/shared/drawer/navigation-drawer.component.dart';
import 'package:dubai_events/shared/global/shadows.values.dart';
import 'package:dubai_events/shared/info/info.component.dart';
import 'package:dubai_events/shared/layout/horizontal.line.component.dart';
import 'package:dubai_events/shared/loader/spinner.component.dart';
import 'package:dubai_events/util/navigation/navigator.util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FilterItem {
  String text = '';
  bool selected = false;

  FilterItem(this.text);
}

class EventsOverviewActivity extends StatefulWidget {
  const EventsOverviewActivity({super.key});

  @override
  State<StatefulWidget> createState() => EventsOverviewActivityState();
}

class EventsOverviewActivityState extends BaseState<EventsOverviewActivity> {
  // ignore: constant_identifier_names
  static const String STREAMS_LISTENER_ID = "EventsOverviewActivityState";

  List<EventModel> events = [];

  // Filtering
  bool displaySearchBar = false;
  bool searchOpacityVisible = false;
  bool searchLoading = false;

  TextEditingController searchController = TextEditingController();

  List<FilterItem> categories = [];
  List<FilterItem> dateFilters = [
    FilterItem('Today'),
    FilterItem('Tomorrow'),
    FilterItem('This Week'),
    FilterItem('Next Week'),
    FilterItem('This Month'),
    FilterItem('Next Month'),
  ];

  // Loading on scroll
  int totalItemsLoaded = 0;
  bool isLoadingOnScroll = false;
  bool noMoreItemsToLoad = false;
  int pageNumber = 0;

  handleMenuItemPressedEvent(MenuItemType type) {
    if (type == MenuItemType.SETTINGS) {
      NavigatorUtil.push(context, const SettingsOverviewActivity());
    } else if (type == MenuItemType.SEARCH) {
      showSearchBar();
    }
  }


  initialize() async {
    setState(() {
      displayLoader = true;
    });

    menuEventsPublisher.onMenuItemPressed(STREAMS_LISTENER_ID, handleMenuItemPressedEvent);

    doGetCategories().then(onGetCategoriesSuccess, onError: onGetCategoriesError);

    doGetEvents(page: pageNumber)
        .then(onGetEventsSuccess, onError: onGetEventsError);
  }

  @override
  initState() {
    super.initState();
    initialize();
  }

  @override
  deactivate() {
    super.deactivate();

    if (menuEventsPublisher != null) {
      menuEventsPublisher.removeListener(STREAMS_LISTENER_ID);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerComponent(),
        body: Builder(builder: (context) {
          scaffold = Scaffold.of(context);
          return render();
        })
    );
  }

  @override
  Widget render() {
    Widget widget = const Center(child: SpinnerComponent());

    if (!displayLoader) {
      if (!isError) {
          widget = Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Column(
                  children: [
                    buildListView(),
                  ],
                ),
                displaySearchBar ? buildTitleSearch() : Container(),
                searchLoading ? buildSearchLoadingWidget() : Container(),
                isLoadingOnScroll ? buildScrollLoadingWidget() : Container(),
                isFilteringActive() ? buildClearFilterWidget() : Container()
              ],
            ),
          );
      } else {
        widget = InfoComponent.errorPanda(onButtonPressed: () async {
          setState(() {
            displayLoader = true;
            isError = false;
          });

          doGetEvents().then(onGetEventsSuccess, onError: onGetEventsError);
        });
      }
    }

    return widget;
  }

  // Content
  Widget buildListView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!displayLoader &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          getNextPageOnScroll();
        }

        return true;
      },
      child: Expanded(
        child: ListView.builder(
          itemCount: events.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildActivityTitle();
            }

            if (index == events.length + 1) {
              return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 15, bottom: 25),
                  child: Text('For more Events visit www.enganger-cloud.com',
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 11)));
            }

            return buildSingleEventRow(events[index - 1]);
          },
        ),
      ),
    );
  }

  void onDoSearch() {
    var filterCategories = categories.where((element) => element.selected)
        .map((cat) => cat.text)
        .toList();

    setState(() {
      searchLoading = true;
    });

    doGetEvents(clearItems: true, search: searchController.text, categories: filterCategories)
        .then(onGetEventsSuccess, onError: onGetEventsError);
  }

  Widget buildSearchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.only(top: deviceMediaPadding.top),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => onDoSearch(),
                  decoration: const InputDecoration(
                      hintText: 'Search by name',
                      labelText: 'Search by name',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 0)),
                )),
            InkWell(
                onTap: hideSearchBar,
                child: SizedBox(
                    height: 35, width: 35,
                    child: Icon(Icons.close_rounded, color: Colors.grey.shade600))),
          ]
      ),
    );
  }

  bool isFilteringActive() {
    return searchController.text.isNotEmpty
      || hasCategoryFilter()
      || hasDateFilter();
  }

  bool hasCategoryFilter() {
    return categories.any((e) => e.selected);
  }

  bool hasDateFilter() {
    return dateFilters.any((e) => e.selected);
  }


  clearAllFilters() {
    setState(() {
      searchController.text = '';
      for (var item in categories) {
        item.selected = false;
      }
      for (var item in dateFilters) {
        item.selected = false;
      }
      searchLoading = true;
    });

    doGetEvents(clearItems: true)
        .then(onGetEventsSuccess, onError: onGetEventsError);
  }

  Widget buildClearFilterWidget() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 25),
        child: OutlinedButton(
          onPressed: clearAllFilters,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Colors.white,
            foregroundColor: Colors.redAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(Icons.close_rounded, size: 16)
              ),
              const Text('Remove All Filters'),
            ],
          ),
        )    );
  }

  Widget buildScrollLoadingWidget() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 25),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: SpinnerComponent(
              strokeWidth: 4,
              size: 30,
              color: Colors.grey.shade400),
        )
    );
  }

  Widget buildSearchLoadingWidget() {
    return Container(
        color: Colors.white70,
        child: Container());
  }

  Widget buildTitleSearch() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: searchOpacityVisible ? 1.0 : 0.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [Shadows.bottomShadow(color: Colors.black26, blurRadius: 5, topDistance: 2)]
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchField(),
            Container(height: 1, color: Colors.grey.shade100),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10, left: 2.5),
              child: const Text("Filter by categories", style: TextStyle(color: Colors.grey))
            ),
            SizedBox(
                width: deviceMediaSize.width,
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...buildCategoryFilterWidgets(),
                    hasCategoryFilter() ? TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(80, 35),
                            foregroundColor: Colors.grey,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap
                        ),
                        onPressed: () {
                          setState(() {
                            for (var cat in categories) {cat.selected = false; }
                          });
                          onDoSearch();
                        },
                        child: const Text("Clear Filter")) : Container()
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.only(top: 15, bottom: 10, left: 2.5),
                child: const Text("Filter by date", style: TextStyle(color: Colors.grey))
            ),
            SizedBox(
              width: deviceMediaSize.width,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  ...buildDateFilterWidgets(),
                  hasDateFilter() ? TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(80, 35),
                          foregroundColor: Colors.grey,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      onPressed: () {
                        setState(() {
                          for (var date in dateFilters) {date.selected = false; }
                        });
                      },
                      child: const Text("Clear Filter")) : Container()
                ],
              )
            ),
            Container(
                margin: const EdgeInsets.only(top: 15, bottom: 10),
                height: 1, color: Colors.grey.shade100),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: onDoSearch,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(250, 35)),
                    backgroundColor: MaterialStateProperty.all(Colors.red.shade400),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(width: 1.0, color: Colors.red)),
                  )),
                  child: searchLoading ? const SpinnerComponent(size: 20, strokeWidth: 2, color: Colors.white) : const Text("Search"))
            ),
          ],
        )
      ),
    );
  }

  Widget buildActivityTitle() {
    return ActivityTitleComponent(
        leading: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              scaffold?.openDrawer();
            },
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Icon(Icons.grid_view,
                  color: Colors.grey.shade600),
            ),
          ),
        ),
        title: "Upcoming Events",
        actionWidget: Material(
          color: Colors.white,
          child: InkWell(
              onTap: showSearchBar,
              customBorder: const CircleBorder(),
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Center(
                        child: Icon(Icons.search,
                            color: isFilteringActive() ? Colors.red : Colors.grey.shade600),
                      ),
                      isFilteringActive() ? const SizedBox(
                        height: 30, width: 10,
                        child: Icon(Icons.add, size: 12, color: Colors.red),
                      ) : Container(),
                    ],
                  ))),
        ));
  }

  void showSearchBar() async {
    setState(() {
      displaySearchBar = true;
    });
    await Future.delayed(const Duration(milliseconds: 1));
    setState(() {
      searchOpacityVisible = true;
    });
  }

  void hideSearchBar() {
    setState(() {
      displaySearchBar = false;
      searchLoading = false;
      searchOpacityVisible = false;
    });
  }

  Widget buildSingleEventRow(EventModel event) {
    var eventImageWidget = CachedNetworkImage(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      imageUrl: event.coverImageUrl,
      placeholder: (context, url) => Container(
          alignment: Alignment.center,
          height: 25, width: 25,
          child: const CircularProgressIndicator(color: Colors.redAccent)),
      errorWidget: (context, url, error) =>
          const Icon(Icons.broken_image_outlined, color: Colors.grey),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          NavigatorUtil.push(
              context,
              SingleEventActivity(
                  event: event, prebuiltImageWidget: eventImageWidget));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: SizedBox(height: 200, child: eventImageWidget)),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    border:
                        Border.all(color: Colors.grey.shade400, width: 0.5)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      EventDetailsPartial(event: event),
                      const HorizontalLine(),
                      Text(
                          event.shortDescription.length > 200
                              ? "${event.shortDescription.substring(0, 200)}..."
                              : event.shortDescription,
                          style: TextStyle(color: Colors.grey.shade700)),
                      EventActionsPartial(event: event, setState: setState)
                    ]))
          ]),
        ),
      ),
    );
  }

  Widget buildFilterItemWidget(item) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150)),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150)),
        splashColor: Colors.grey,
        focusColor: Colors.grey,
        onTap: () {
          setState(() {
            item.selected = !item.selected;
          });
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: item.selected ? Colors.white : Colors.transparent,
                border: Border.all(color: item.selected ? Colors.red.shade400 : Colors.grey.shade400)
            ),
            child: Text(item.text, style: TextStyle(color: item.selected ? Colors.red.shade400 : Colors.grey.shade400))
        ),
      ),
    );
  }

  List<Widget> buildDateFilterWidgets() {
    List<Widget> widgets = [];

    for (var filter in dateFilters) {
      widgets.add(buildFilterItemWidget(filter));
    }

    return widgets;
  }

  List<Widget> buildCategoryFilterWidgets() {
    List<Widget> widgets = [];

    for (var category in categories) {
      widgets.add(buildFilterItemWidget(category));
    }

    return widgets;
  }

  // Data calls
  void getNextPageOnScroll() async {
    if (!isLoadingOnScroll && !noMoreItemsToLoad) {
      setState(() {
        isLoadingOnScroll = true;
      });
      pageNumber++;
      doGetEvents(page: pageNumber)
          .then(onGetEventsSuccess, onError: onGetEventsError);
    }
  }

  // Data calls - Get category filters
  Future doGetCategories() async {
    String url = "/api/categories";
    http.Response? response = await HttpClient.get(url);

    await Future.delayed(const Duration(milliseconds: 500));

    if (response != null && response.statusCode != 200) {
      throw Exception();
    }

    return response?.decode();
  }

  void onGetCategoriesSuccess(result) async {
    for (var element in result) {
      categories.add(FilterItem(element['name']));
    }
  }

  void onGetCategoriesError(Object error) async {
    print('Error fetching categories');
  }

  // Data calls - Get Events
  Future doGetEvents({page = 0, clearItems = false, String? search, List<String>? categories}) async {
    if (clearItems) {
      pageNumber = 0;
    }

    String url = "/api/events/upcoming?page=$page";

    if (search != null) {
      url = "$url&search=$search";
    }

    if (categories != null) {
      url = "$url&categories=${categories.join(",")}";
    }

    http.Response? response = await HttpClient.get(url);

    await Future.delayed(const Duration(milliseconds: 500));

    if (response != null && response.statusCode != 200) {
      throw Exception();
    }

    dynamic result = response?.decode();

    return {'result': result, 'clearItems': clearItems};
  }

  void onGetEventsSuccess(obj) async {
    if (obj['clearItems']) {
      events.clear();
      totalItemsLoaded = 0;
    }

    totalItemsLoaded += (obj['result']['totalElements'] as int);

    if (obj['result']['totalElements'] == 0) {
      noMoreItemsToLoad = true;
    }

    events.addAll(EventModel.fromJsonList(obj['result']['content']));

    hideSearchBar();
    setState(() {
      displayLoader = false;
      isLoadingOnScroll = false;
      isError = false;
    });
  }

  void onGetEventsError(Object error) async {
    hideSearchBar();
    setState(() {
      displayLoader = false;
      isLoadingOnScroll = false;
      isError = true;
    });
  }
}
