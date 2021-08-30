import 'package:ascendtek_test/bloc/main_bloc.dart';
import 'package:ascendtek_test/model/image_model.dart';
import 'package:ascendtek_test/screen/shimmer_list.dart';
import 'package:ascendtek_test/utils/image/Image_with_state.dart';
import 'package:ascendtek_test/utils/list/item-list.widget.dart';
import 'package:ascendtek_test/utils/media-query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';

import 'details_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  final mainBloc = Modular.get<MainBloc>();
  final _multiSelectKey2 = GlobalKey<FormFieldState>();

  @override
  initState() {
    super.initState();
    mainBloc.getImages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: true,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 30),
                  height: mqHeight(context),
                  child: _buildContents(context)),
            ),
            _chipList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Modular.to.pushNamed('/add');
            }),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<ImageModel>>(
        stream: mainBloc.filteredImages$,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerList();
          }

          return ListItemsBuilder<ImageModel>(
              snapshot: snapshot,
              itemBuilder: (context, item) => Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => DetailsPage(
                                    img: item,
                                  ));
                        },
                        child: Card(
                          child: SizedBox(
                            child: Stack(
                              // alignment: Alignment.center,
                              children: [
                                ImageWithState(
                                  height: mqHeight(context) / 3.2,
                                  width: mqHeight(context) / 3.2,
                                  futureUrl: mainBloc.downloadImage(
                                      item.url, 'ascendtek_image'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  height: 50,
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Chip(
                                        elevation: 5,
                                        avatar: Icon(Icons.remove_red_eye),
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          item.views.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
        });
  }

  _chipList() {
    return MultiSelectChipField(
        key: _multiSelectKey2,
        items: mainBloc.tags,
        scroll: true,
        initialValue: const [],
        // showHeader: false,
        searchable: true,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        title: const Text("Search tag"),
        selectedTextStyle: TextStyle(color: Colors.blue[800]),
        onSaved: (values) {
          // _newItems = values!;
        },
        onTap: (values) {
          mainBloc.selectedTagFilters = values;
          mainBloc.filterImages();
          print(values);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
 