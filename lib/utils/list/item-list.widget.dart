import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder(
      {Key? key,
      required this.snapshot,
      required this.itemBuilder,
      this.divided})
      : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T>? itemBuilder;
  final bool? divided;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data ?? [];
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return Center(
          child: Text('No item'),
        );
      }
    } else if (snapshot.hasError) {
      return Center(
        child: Text('Something went wrong'),
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => divided ?? false
          ? Divider(height: 0.5)
          : SizedBox(
              height: 0,
            ),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder!(context, items[index - 1]);
      },
    );
  }
}
