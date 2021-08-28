import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton(
      {Key? key,
      this.color,
      this.borderRadius: 2.0,
      this.height: 50.0,
      this.onPressed,
      this.child});

  final Widget? child;
  final Color? color;
  final double borderRadius;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
          child: child,
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          onPressed: onPressed),
    );
  }
}

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String? text,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          child: Text(
            text ?? '',
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          borderRadius: 5.0,
          onPressed: onPressed,
        );
}

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    String? text,
    @required String? assetName,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetName ?? ''),
              Text(
                text ?? '',
                style: TextStyle(color: textColor, fontSize: 15.0),
              ),
              Opacity(opacity: 0.0, child: Image.asset(assetName ?? ''))
            ],
          ),
          color: color,
          borderRadius: 5.0,
          onPressed: onPressed,
        );
}


class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
     String text = '',
    @required VoidCallback? onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    height: 44.0,
    color: Colors.indigo,
    borderRadius: 4.0,
    onPressed: onPressed,
  );
}
