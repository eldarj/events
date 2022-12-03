import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dubai_events/activity/events/partial/event.actions.partial.dart';
import 'package:dubai_events/activity/events/partial/event.details.partial.dart';
import 'package:dubai_events/main.dart';
import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var galleryLength = widget.event.galleryImageUrls.length + 1; // +1 for cover image

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
                items: [widget.event.coverImageUrl, ...widget.event.galleryImageUrls].map((imageUrl) {
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
          padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          child: EventDetailsPartial(event: widget.event)),
      Container(
          color: Colors.white,
          padding:
          const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        child: Text("Description", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500))
      ),
      Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 10, right: 10),
        child: Text(widget.event.shortDescription, style: TextStyle(color: Colors.grey.shade500)),
      ),
      Container(
        color: Colors.white,
        padding:
        const EdgeInsets.only(top: 5, bottom: 15, left: 10, right: 10),
        child: Text(widget.event.description, style: TextStyle(color: Colors.grey.shade500)),
      )
      ,
      Container(
          color: Colors.white,
          padding:
          const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          child: Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500))
      ),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            ...widget.event.categories.map((category) => Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Text(category, style: TextStyle(color: Colors.red.shade400, fontSize: 12)),
            )),
          ]),
        ),
      )
      ,
      Container(height: 5, color: Colors.grey.shade100),
      Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(widget.event.reservationUrl));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Reservations", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Text("Navigate to URL", style: TextStyle(color: Colors.grey.shade400)),
              ),
            ]),
          ),
        )
      )
      ,
      Container(height: 5, color: Colors.grey.shade100),
      Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text("Contact", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500))
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              contactTile(Icons.phone, widget.event.eventContact?.phoneNumber, () {
                launchUrl(Uri(scheme: "tel", path: widget.event.eventContact?.phoneNumber ?? ""));
              }),
              contactTile(Icons.whatsapp, widget.event.eventContact?.whatsappNumber, () {
                launchUrl(Uri.parse("whatsapp://send?phone=${widget.event.eventContact?.whatsappNumber}" ?? ""));
              }),
              contactTile(Icons.phone, widget.event.eventContact?.email, () {
                launchUrl(Uri.parse("mailto:${widget.event.eventContact?.whatsappNumber}" ?? ""));
              }),
              contactTile(Icons.facebook_rounded, widget.event.eventContact?.facebookUrl, () {
                launchUrl(Uri.parse(widget.event.eventContact?.facebookUrl ?? ""));
              }),
              contactTile(Icons.info_outline, widget.event.eventContact?.twitterUrl, () {
                launchUrl(Uri.parse(widget.event.eventContact?.twitterUrl ?? ""));
              }),
              contactTile(Icons.info_outline, widget.event.eventContact?.instagramUrl, () {
                launchUrl(Uri.parse(widget.event.eventContact?.instagramUrl ?? ""));
              }),
            ]),
          ),
        ]),
      )
      ,
      Container(height: 5, color: Colors.grey.shade100),
      widget.event.eventLocation?.mapImageUrl != null && widget.event.eventLocation?.displayLocationMap == true ? Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            MapsLauncher.launchCoordinates(widget.event.eventLocation?.latitude ?? 0,
                widget.event.eventLocation?.longitude ?? 0, widget.event.eventLocation?.name);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 0, left: 10, right: 10),
                  child: Text("Location", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500))
              ),
              widget.event.eventLocation?.name == null ? Container() : Container(
                padding: const EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
                child: Text(widget.event.eventLocation?.name ?? "", style: TextStyle(color: Colors.grey.shade500)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: deviceMediaSize.width - 5,
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
            ],
          ),
        ),
      ) : Container(),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text("For more info visit www.engager-cloud.com", style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
      ),
    ]);
  }


  Widget contactTile(icon, text, onTap) {
    return text != null && text.length > 0 ? Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
          child: Row(children: [
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(icon, color: Colors.grey, size: 18)),
            Text(text ?? "", style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ]),
        ),
      ),
    ) : Container();
  }
}
