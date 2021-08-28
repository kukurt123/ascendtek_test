import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

nav(String str, {dynamic arg}) {
  if (kIsWeb) {
    print('isweb');
    Modular.to.navigate(str);
    return;
  } else {
    print('isNotWeb');
    Modular.to.pushNamed(str);
    if (arg == null) {
      return;
    }
    Modular.to.pushNamed(str, arguments: arg);
  }
}

// navNoModular(Widget widget, BuildContext context) {
//   Navigator.of(context).push(
//     PageRouteBuilder(
//       pageBuilder: (c, a1, a2) => widget,
//       transitionsBuilder: (c, anim, a2, child) =>
//           FadeTransition(opacity: anim, child: child),
//       transitionDuration: Duration(milliseconds: 0),
//     ),
//   );
// }
navNoModular(Widget widget, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
