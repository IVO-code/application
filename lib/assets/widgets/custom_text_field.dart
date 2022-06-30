import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTextField extends StatefulWidget {
  final String? label, hint;
  final Color background, color;
  final ValueChanged<String>? onChanged;
  final bool password;
  final TextEditingController text_controller;

  CustomTextField(
      {this.label,
      required this.hint,
      this.background = Colors.white,
      this.color = Colors.black,
      this.onChanged,
      required this.text_controller,
      this.password = false});

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(controller: text_controller);
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  bool hidePassword = true;

  _CustomTextFieldState({required this.controller});
  @override
  void initState() {
    super.initState();
    hidePassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          child: widget.label != null
              ? Text(
                  widget.label!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                )
              : null,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            color: widget.background,
            depth: 2,
            shadowLightColor: widget.color,
            boxShape: const NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(
              vertical: widget.password ? 1 : 16, horizontal: 16),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChanged,
            obscureText: hidePassword,
            controller: controller,
            cursorColor: widget.color,
            decoration: InputDecoration(
                focusColor: widget.color,
                hoverColor: widget.color,
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hint,
                fillColor: widget.color,
                isDense: true,
                suffixIcon: widget.password
                    ? IconButton(
                        icon: hidePassword
                            ? Icon(
                                Icons.visibility_off,
                                color: widget.color,
                              )
                            : Icon(Icons.visibility, color: widget.color),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      )
                    : null),
          ),
        )
      ],
    );
  }
}
