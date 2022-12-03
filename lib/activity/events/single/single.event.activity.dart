import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dubai_events/activity/events/partial/event.actions.partial.dart';
import 'package:dubai_events/activity/events/partial/event.details.partial.dart';
import 'package:dubai_events/main.dart';
import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/shared/maps/map.component.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
    var galleryLength = widget.event.galleryImageUrls.length;

    return ListView(padding: EdgeInsets.zero, children: [
      Container(
          height: 400,
          color: Colors.white,
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
                items: widget.event.galleryImageUrls.map((imageUrl) {
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
                                const Icon(Icons.broken_image_outlined, color: Colors.grey),
                          ));
                    },
                  );
                }).toList(),
              ),
              galleryLength > 0
                  ? Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 2.5, horizontal: 7.5),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('$galleryIndex/$galleryLength',
                          style:
                              const TextStyle(color: Colors.white70, fontSize: 14)))
                  : Container(),
            ],
          )),
      Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: EventActionsPartial(event: widget.event, setState: setState)),
      Container(height: 5, color: Colors.grey.shade100),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Text(widget.event.name,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
      ),
      Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: EventDetailsPartial(event: widget.event)),
      Container(height: 5, color: Colors.grey.shade100),
      Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Text(widget.event.shortDescription, style: TextStyle(color: Colors.grey.shade500)),
      ),
      Container(height: 5, color: Colors.grey.shade100),
      Container(
        color: Colors.white,
        padding:
        const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Text(widget.event.description, style: TextStyle(color: Colors.grey.shade500)),
      ),
      Container(height: 5, color: Colors.grey.shade100),

      widget.event.eventLocation?.mapImageUrl != null ? GestureDetector(
        onTap: () {
          MapsLauncher.launchCoordinates(widget.event.eventLocation?.latitude ?? 0,
              widget.event.eventLocation?.longitude ?? 0, widget.event.eventLocation?.name);
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            imageUrl: widget.event.eventLocation?.mapImageUrl ?? "",
            placeholder: (context, url) => Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
                child: const CircularProgressIndicator(
                    color: Colors.redAccent)),
            errorWidget: (context, url, error) =>
            const Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        ),
      ) : Container(),
    ]);
  }
}
