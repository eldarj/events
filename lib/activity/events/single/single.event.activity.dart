import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dubai_events/activity/events/partial/event.details.partial.dart';
import 'package:dubai_events/main.dart';
import 'package:dubai_events/service/data/events.api.service.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/util/datetime/human.times.util.dart';
import 'package:flutter/material.dart';

class SingleEventActivity extends StatefulWidget {
  final EventModel event;

  final Widget prebuiltImageWidget;

  const SingleEventActivity(
      {super.key, required this.event, required this.prebuiltImageWidget});

  @override
  State<StatefulWidget> createState() => SingleEventActivityState();
}

class SingleEventActivityState extends BaseState<SingleEventActivity> {
  int galleryIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const CloseButton(),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Builder(builder: (context) {
          scaffold = Scaffold.of(context);
          return render();
        }));
  }

  @override
  Widget render() {
    var galleryLength = widget.event.galleryImagePaths.length;

    return ListView(padding: EdgeInsets.zero, children: [
      Container(
          height: 400,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    initialPage: 0,
                    height: 400.0,
                    pageSnapping: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        galleryIndex = index + 1;
                      });
                    }),
                items: widget.event.galleryImagePaths.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: deviceMediaSize.width,
                          decoration:
                              const BoxDecoration(color: Colors.black12),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            imageUrl: imageUrl,
                            placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 25,
                                child: const CircularProgressIndicator(
                                    color: Colors.redAccent)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ));
                    },
                  );
                }).toList(),
              ),
              galleryLength > 0
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.5, horizontal: 7.5),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('$galleryIndex/$galleryLength',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)))
                  : Container(),
            ],
          )),
      Container(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: EventDetailsPartial(event: widget.event, setState: setState)),
      Container(height: 5, color: Colors.grey.shade100),
      Container(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("${widget.event.ticketPrice} AED",
              style: const TextStyle(color: Colors.grey)),
          Row(children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child:
                  const Icon(Icons.location_on, color: Colors.grey, size: 10),
            ),
            Row(children: [
              Text("${widget.event.location}, ",
                  style: const TextStyle(color: Colors.grey)),
              Text(HumanTimes.getDate(widget.event.timestamp),
                  style: const TextStyle(color: Colors.grey)),
            ])
          ]),
        ]),
      ),
      Container(height: 5, color: Colors.grey.shade100),
      Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
        child: Text(widget.event.description),
      ),
      Container(height: 500),
    ]);
  }
}
