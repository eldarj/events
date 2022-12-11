import 'package:dubai_events/activity/settings/overview/settings.overview.activity.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/shared/drawer/partial/drawer-items.dart';
import 'package:flutter/material.dart';

class NavigationDrawerComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationDrawerComponentState();
}

class NavigationDrawerComponentState
    extends BaseState<NavigationDrawerComponent> {
  init() async {
  }

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
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // BaseAppBar.getCloseAppBar(() => scaffold.context, titleText: 'Me'),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Material(
                          color: Colors.white,
                          elevation: 1.0,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(top: 5, bottom: 20),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    displayLoader ? Container(
                                        margin: EdgeInsets.all(20),
                                        height: 80,
                                        width: 80,
                                        child: CircularProgressIndicator())
                                        : Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Text("Hello")),
                                    displayLoader ? Column(children: [
                                      Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          color: Colors.red,
                                          height: 20,
                                          width: 120),
                                      Container(color: Colors.grey,
                                          height: 20,
                                          width: 50),
                                    ]) : Column(children: [
                                      Text("Dubai Events", style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text("Phone number",
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .w400)),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: !displayLoader ? SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  buildSectionTitle("Me"),
                                  buildDrawerItem(context, 'My profile',
                                      buildIcon(icon: Icons.alternate_email,
                                          backgroundColor: Colors.red)),
                                  buildDrawerItem(context, 'Active status',
                                    buildIcon(icon: Icons.check,
                                        backgroundColor: Colors.green),
                                    labelDescription: "On",
                                    onTapFunction: () {
                                      showModalBottomSheet(context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                                child: Wrap(children: [
                                                  ListTile(leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                      title: Text(
                                                          'Display my status'),
                                                      onTap: () {}),
                                                  ListTile(leading: Icon(
                                                      Icons.visibility_off),
                                                      title: Text(
                                                          'Appear offline'),
                                                      onTap: () {}),
                                                ])
                                            );
                                          });
                                    },
                                  ),
                                  buildSectionTitle("Chats"),
                                  buildDrawerItem(context, 'Chats',
                                      buildIcon(icon: Icons.chat,
                                          backgroundColor: Colors.blue),
                                      activity: SettingsOverviewActivity()),
                                  buildDrawerItem(context, 'My contacts',
                                      buildIcon(icon: Icons.people,
                                          backgroundColor: Colors.orangeAccent
                                              .shade700),
                                      activity: SettingsOverviewActivity()),
                                  buildSectionTitle("Data Space"),
                                  buildDrawerItem(context, 'My dataspace',
                                      buildIcon(icon: Icons.image,
                                          backgroundColor: Colors.redAccent),
                                      activity: SettingsOverviewActivity(),
                                      labelDescription: 'Your stored data and shared media'),
                                  buildSectionTitle("Help & FAQ"),
                                  buildDrawerItem(context,
                                      'Terms of Services and Privacy Policy',
                                      buildIcon(icon: Icons.copyright,
                                          backgroundColor: Colors.blueGrey
                                              .shade800),
                                      activity: SettingsOverviewActivity()
                                  ),
                                  Container(
                                    color: Colors.red,
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: buildDrawerItem(context, 'Logout',
                                        buildIcon(icon: Icons.exit_to_app,
                                            backgroundColor: Colors.red
                                                .shade300),
                                        onTapFunction: () =>
                                            showDialog(context: context,
                                                builder: (
                                                    BuildContext context) {
                                                  return SettingsOverviewActivity();
                                                })),
                                  ),
                                ]),
                          ) : Container(margin: EdgeInsets.all(20),
                              color: Colors.grey,
                              height: 300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}
