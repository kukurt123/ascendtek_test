import 'dart:io';
import 'package:ascendtek_test/bloc/main_bloc.dart';
import 'package:ascendtek_test/model/image_model.dart';
import 'package:ascendtek_test/utils/button/custom-button.dart';
import 'package:ascendtek_test/utils/media-query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AdditionPage extends StatefulWidget {
  const AdditionPage({Key? key}) : super(key: key);

  @override
  _AdditionPageState createState() => _AdditionPageState();
}

class _AdditionPageState extends State<AdditionPage> {
  List<String> _newItems = [];
  final mainBloc = Modular.get<MainBloc>();
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(children: [
                Container(
                    alignment: Alignment.center,
                    color: Colors.grey.shade50,
                    height: 100,
                    child: const Text('Upload an image',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))),
                Center(
                  child: StreamBuilder<File>(
                      stream: mainBloc.file.stream,
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        return data == null || data.path == ''
                            ? SizedBox(
                                height: mqHeight(context) / 1.3,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () async {
                                    await mainBloc.pickImage(isCamera: false);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.file_upload),
                                      SizedBox(width: 10),
                                      Text('Select image from File')
                                    ],
                                  ),
                                )),
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(snapshot.data!)),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          child: FloatingActionButton.small(
                                            backgroundColor: Colors.red,
                                            onPressed: () {
                                              mainBloc.file.add(File(''));
                                            },
                                            child: Icon(Icons.clear),
                                          )),
                                    ],
                                  ),
                                  // const SizedBox(

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: _chipList3(),
                                  ),
                                  Divider(
                                    height: 30,
                                  ),
                                  CustomRaisedButton(
                                    child: Text('Save'),
                                    borderRadius: 10,
                                    onPressed: () async {
                                      print(
                                          'save ${_multiSelectKey.currentState!.value}');
                                      // _multiSelectKey.currentState!.value
                                      //     .forEach((x) => Tag.fromJson(x));
                                      final img = ImageModel(
                                          stringTags: _multiSelectKey
                                              .currentState!.value,
                                          url: '',
                                          views: 0);
                                      await mainBloc.saveImage(img);
                                    },
                                  ),
                                ],
                              );
                      }),
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }

  _chipList3() {
    return MultiSelectChipField(
        key: _multiSelectKey,
        items: mainBloc.tags,
        scroll: false,
        initialValue: const [],
        title: const Text("Tags"),
        selectedTextStyle: TextStyle(color: Colors.blue[800]),
        onSaved: (values) {
          // _newItems = values!;
        },
        onTap: (values) {
          print(values);
        });
  }
}
