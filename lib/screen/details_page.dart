import 'package:ascendtek_test/bloc/main_bloc.dart';
import 'package:ascendtek_test/model/image_model.dart';
import 'package:ascendtek_test/utils/image/Image_with_state.dart';
import 'package:ascendtek_test/utils/media-query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.img}) : super(key: key);
  final ImageModel img;

  @override
  Widget build(BuildContext context) {
    const Color dark = Color.fromARGB(180, 0, 0, 0);
    const Color darker = Color.fromARGB(0, 0, 0, 0);
    final mainBloc = Modular.get<MainBloc>();
    return FutureBuilder<void>(
        future: mainBloc.setImage(img.copyWith(views: img.views + 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            child: _projectContainer(mqWidth(context), [darker, dark].toList(),
                image: img,
                context: context,
                widgetImage: ImageWithState(
                  futureUrl: mainBloc.downloadImage(img.url, 'ascendtek_image'),
                )),
          );
        });
  }

  Widget _projectContainer(
    double width,
    List<Color> list, {
    required ImageModel image,
    required BuildContext context,
    required Widget widgetImage,
  }) {
    return GestureDetector(
      child: Center(
        child: Stack(children: [
          Card(
              margin: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  widgetImage,
                  Positioned(
                      width: width,
                      height: width * .50,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          runAlignment: WrapAlignment.end,
                          children: [
                            ...image.stringTags
                                .map((x) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Chip(
                                        label: Text(x),
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: list,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      )),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: FloatingActionButton.small(
                        key: const Key('yes'),
                        backgroundColor: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.clear),
                      )),
                  Positioned(
                    left: 5,
                    top: 0,
                    child: Chip(
                      elevation: 5,
                      avatar: const Icon(Icons.remove_red_eye),
                      backgroundColor: Colors.white,
                      label: Text(
                        (image.views + 1).toString(),
                      ),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
