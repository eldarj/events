import 'package:dubai_events/shared/base/base.state.dart';
import 'package:flutter/material.dart';

class SettingsOverviewActivity extends StatefulWidget {
  const SettingsOverviewActivity({super.key});

  @override
  State<StatefulWidget> createState() => SettingsOverviewActivityState();
}

class SettingsOverviewActivityState
    extends BaseState<SettingsOverviewActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.1,
          titleSpacing: 5,
          title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.normal)),
        ),
        body: Builder(builder: (context) {
          scaffold = Scaffold.of(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(height: 5, color: Colors.grey.shade100),
                  Container(
                    color: Colors.white,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          contactTile(Icons.person, "Profile", () {
                          }),
                          contactTile(Icons.map_outlined, "Addresses", () {
                          }),
                          contactTile(Icons.payment, "Payment Methods", () {
                          }),
                          contactTile(Icons.card_giftcard, "Referral Codes", () {
                          }),
                          contactTile(Icons.help_outline, "Get Help", () {
                          }),
                        ]),
                      ),
                    ]),
                  )
                ],
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.all(15),
                    alignment: Alignment.bottomCenter,
                    child: Text("v1.0.0", style: TextStyle(fontSize: 11, color: Colors.grey.shade400))
                ),
              )
            ],
          );
        })
    );
  }

  Widget contactTile(icon, text, onTap, {bool showBottomBorder = true, bool showRightArrow = true}) {
    return text != null && text.length > 0 ? Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: showBottomBorder ? Colors.grey.shade200 : Colors.transparent)
              )
          ),
          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Row(children: [
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(icon, color: Colors.grey.shade700, size: 18)),
              Text(text ?? "", style: TextStyle(color: Colors.grey.shade700)),
            ]),
            showRightArrow ? Icon(Icons.arrow_forward,  color: Colors.grey.shade700, size: 18) : Container()
          ]),
        ),
      ),
    ) : Container();
  }
}