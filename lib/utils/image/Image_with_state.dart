import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ImageWithState extends StatelessWidget {
  final Future<String>? futureUrl;
  final double? height;
  final double? width;
  final BoxShape? boxShape;
  final String? heroTag;

  const ImageWithState(
      {Key? key,
      this.futureUrl,
      this.height,
      this.width,
      this.boxShape,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (futureUrl == null) {
      return dummyShimmer();
    }

    return FutureBuilder<String>(
        future: futureUrl,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ExtendedImage.network(
              snapshot.data ?? '',
              width: width,
              height: height,
              fit: BoxFit.cover,
              enableMemoryCache: true,
              shape: boxShape,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                // print('url    $url');
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    // _controller.reset();
                    return _loadShimmer();
                  case LoadState.completed:
                    // _controller.forward();
                    return ExtendedRawImage(
                      fit: BoxFit.cover,
                      image: state.extendedImageInfo?.image,
                      width: width,
                      height: height,
                    );
                  case LoadState.failed:
                    // _controller.reset();
                    return GestureDetector(
                      child: Center(
                        child: Text(
                          "failed, click to reload",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        state.reLoadImage();
                      },
                    );
                }
              },
            );
          }
          return Center(child: dummyShimmer());
        });
  }

  Widget _loadShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade300,
        child: Container());
  }

  Widget dummyShimmer() {
    return Row(
      children: [
        _loadShimmer(),
        _loadShimmer(),
        _loadShimmer(),
      ],
    );
  }
}

Future<String> imageUrlAsFuture(String url) {
  var complete = new Completer();
  complete.complete(url);
  return complete.future.then((t) => t.toString());
}
