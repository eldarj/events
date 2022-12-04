import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_events/activity/events/partial/event.actions.partial.dart';
import 'package:dubai_events/activity/events/partial/event.details.partial.dart';
import 'package:dubai_events/activity/events/single/single.event.activity.dart';
import 'package:dubai_events/event-bus/menu-events.publisher.dart';
import 'package:dubai_events/service/client/http.client.dart';
import 'package:dubai_events/service/client/http.response.extension.dart';
import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/shared/activity-title/activity.title.component.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/shared/info/info.component.dart';
import 'package:dubai_events/shared/layout/horizontal.line.component.dart';
import 'package:dubai_events/shared/loader/spinner.component.dart';
import 'package:dubai_events/util/navigation/navigator.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CategoryFilter {
  String text = '';
  bool selected = false;

  CategoryFilter(this.text);
}

class EventsOverviewActivity extends StatefulWidget {
  const EventsOverviewActivity({super.key});

  @override
  State<StatefulWidget> createState() => EventsOverviewActivityState();
}

class EventsOverviewActivityState extends BaseState<EventsOverviewActivity> {
  static const String STREAMS_LISTENER_ID = "EventsOverviewActivityState";

  List<EventModel> events = [];

  List<CategoryFilter> categories = [];

  int totalItemsLoaded = 0;
  bool isLoadingOnScroll = false;
  bool noMoreItemsToLoad = false;
  int pageNumber = 0;

  TextEditingController searchController = TextEditingController();

  void onSearch() {

  }

  onMenuItemPressedEvent(MenuItemType type) {
    if (type == MenuItemType.SEARCH) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 100,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                      height: 50,
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onSubmitted: (_) => onSearch(),
                        decoration: InputDecoration(
                            hintText: '',
                            prefixIcon: Icon(Icons.search),
                            labelText: 'Search by name',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 0.25, color: Colors.grey.shade800),
                            ),
                            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15)),
                      ))
                  ,
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        ...buildCategoryFilterWidget()
                      ],
                    )
                  )
                ],
              ),
            );
          }
      );
    }
  }

  List<Widget> buildCategoryFilterWidget() {
    List<Widget> widgets = [];

    for (var category in categories) {
      widgets.add(Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: category.selected ? Colors.red.shade400 : Colors.transparent,
              border: Border.all(color: category.selected ? Colors.red.shade400 : Colors.grey.shade400)
          ),
          child: Text(category.text, style: TextStyle(color: category.selected ? Colors.white : Colors.grey.shade400))
      ));
    }

    return widgets;
  }

  initialize() async {
    setState(() {
      displayLoader = true;
    });

    menuEventsPublisher.onMenuItemPressed(STREAMS_LISTENER_ID, onMenuItemPressedEvent);

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
  Widget render() {
    Widget widget = const SpinnerComponent();

    if (!displayLoader) {
      if (!isError) {
        widget = Container(
          color: Colors.white,
          child: Column(
            children: [
              events.isNotEmpty
                  ? buildListView()
                  : Container(
                      margin: const EdgeInsets.all(25),
                      child: const Text('No events to display',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey)),
                    )
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
              return ActivityTitleComponent(
                  title: "Upcoming Events",
                  actionWidget: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade400, width: 1),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 2.5),
                      child: const Text("@",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ));
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
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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

    print(response);
    print(response?.statusCode);

    return response?.decode();
  }

  void onGetCategoriesSuccess(result) async {
    print('GOT CATS');
    print(result);
    for (var element in result) {
      categories.add(CategoryFilter(element));
    }
  }

  void onGetCategoriesError(Object error) async {
    print('Error fetching categories');
  }

  // Data calls - Get Events
  Future doGetEvents({page = 0, clearItems = false}) async {
    if (clearItems) {
      events.clear();
      pageNumber = 0;
    }

    String url = "/api/events/upcoming?page=$page";
    http.Response? response = await HttpClient.get(url);

    await Future.delayed(const Duration(milliseconds: 500));

    if (response != null && response.statusCode != 200) {
      throw Exception();
    }

    dynamic result = response?.decode();

    return result;
  }

  void onGetEventsSuccess(result) async {
    totalItemsLoaded += (result['totalElements'] as int);

    if (result['totalElements'] == 0) {
      noMoreItemsToLoad = true;
    }

    events.addAll(EventModel.fromJsonList(result['content']));

    setState(() {
      displayLoader = false;
      isLoadingOnScroll = false;
      isError = false;
    });
  }

  void onGetEventsError(Object error) async {
    setState(() {
      displayLoader = false;
      isLoadingOnScroll = false;
      isError = true;
    });
  }
}
