import 'package:dubai_events/activity/settings/overview/settings.overview.activity.dart';
import 'package:dubai_events/main.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/shared/drawer/partial/drawer-items.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NavigationDrawerComponent extends StatefulWidget {
  const NavigationDrawerComponent({super.key});

  @override
  State<StatefulWidget> createState() => NavigationDrawerComponentState();
}

class NavigationDrawerComponentState
    extends BaseState<NavigationDrawerComponent> {
  init() async {}

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget render() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: deviceMediaPadding.top),
                          padding: const EdgeInsets.only(left: 2.5),
                          child: SizedBox(
                            height: 55,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(LineIcons.times),
                                    color: Colors.grey.shade600,
                                    tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                                    onPressed: () {
                                      Navigator.maybePop(context);
                                    },
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionTitle("Events", topMargin: 0),
                            buildDrawerItem(
                                context,
                                'All Events',
                                buildIcon(
                                    icon: LineIcons.calendar,
                                    backgroundColor: Colors.green.shade600),
                                onTapFunction: () {
                                  Navigator.pop(context);
                                }),
                            // buildDrawerItem(
                            //     context,
                            //     'Register',
                            //     buildIcon(
                            //         icon: LineIcons.user,
                            //         backgroundColor: Colors.amber),
                            //     onTapFunction: () {
                            //       Navigator.pop(context);
                            //     }),
                            buildDrawerItem(
                                context,
                                'My Saved Events',
                                buildIcon(
                                    icon: LineIcons.heartAlt,
                                    backgroundColor: Colors.redAccent),
                                activity: const SettingsOverviewActivity()),
                            buildSectionTitle("Help & FAQ"),
                            buildDrawerItem(
                                context,
                                'About',
                                buildIcon(
                                    icon: Icons.info,
                                    backgroundColor: Colors.deepPurple.shade800),
                                activity: const SettingsOverviewActivity()),
                            buildDrawerItem(
                                context,
                                'Terms and Privacy Policy',
                                buildIcon(
                                    icon: LineIcons.copyright,
                                    backgroundColor: Colors.pink.shade600),
                                activity: const SettingsOverviewActivity()),
                            buildDrawerItem(
                                context,
                                'Settings',
                                buildIcon(
                                    icon: LineIcons.cog,
                                    backgroundColor: Colors.blueGrey.shade800),
                                activity: const SettingsOverviewActivity()),
                            buildSectionTitle("Publishing"),
                            buildDrawerItem(
                                context,
                                'Start Publishing',
                                buildIcon(
                                      icon: LineIcons.rocket,
                                    backgroundColor: Colors.amber.shade800),
                                activity: const SettingsOverviewActivity()),
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              color: Colors.grey.shade200,
                              height: 1,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.7,
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 75, width: 75,
                                          margin: const EdgeInsets.only(top: 35),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    blurRadius: 30,
                                                    spreadRadius: 0,
                                                    offset: Offset.fromDirection(0.1, 0.1))
                                              ]
                                          ),
                                          child: Image.asset('static/image/company/events-logo.png')),
                                    ),
                                  ],
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text('Dubai Events', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400, fontSize: 13)),
                                  Text(' · v1.0.0', style: TextStyle(
                                      color: Colors.grey.shade400, fontSize: 11)),
                                ]),
                                Text('For more Events visit www.enganger-cloud.com',
                                    style: TextStyle(
                                        color: Colors.grey.shade400, fontSize: 11)),
                              ],
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
