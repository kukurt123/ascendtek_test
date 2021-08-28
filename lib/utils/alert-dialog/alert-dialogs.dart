import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:flutter/flutter_platform_widgets'


Future<void> confirmDialogUtil(
    BuildContext context, List<String> array, VoidCallback callback) async {
  showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: Text(array[0]),
      content: Text(array[1]),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: PlatformText('Yes'),
          onPressed: () {
            callback();
            // print('closed...');
            print('closed...');
            // Navigator.of(context).pop();
          },
        ),
      ],
      cupertino: (context, __) => CupertinoAlertDialogData(),
      material: (context, __) => MaterialAlertDialogData(),
    ),
  );
}

Future<void> infoDialogUtil(BuildContext context, List<String> array) async {
  showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: Text(array[0]),
      content: Text(array[1]),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      cupertino: (context, __) => CupertinoAlertDialogData(),
      material: (context, __) => MaterialAlertDialogData(),
    ),
  );
}
