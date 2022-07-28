import 'package:application/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final bool filled, selected, detailed;
  final VoidCallback press;
  final Color color;
  final IconData? icon;

  const CustomTextButton({
    Key? key,
    this.title = "",
    required this.press,
    this.filled = false,
    this.color = Constants.background,
    this.icon,
    required this.detailed,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: filled
          ? EdgeInsets.symmetric(horizontal: 12)
          : EdgeInsets.symmetric(horizontal: 0),
      child: !detailed && !selected
          ? IconButton(
              onPressed: press,
              icon: Icon(
                icon,
                color: color,
              ))
          : icon == null || !selected
              ? TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: filled ? Color(0xFFFFFFFF) : null,
                    side: selected
                        ? BorderSide(color: Color(0xFFFFFFFF), width: 2)
                        : null,
                    padding: EdgeInsets.all(16),
                    primary: Colors.white70,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                  onPressed: press,
                  child: Text(
                    title,
                    style: GoogleFonts.raleway(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: filled ? Color(0xFFFFFFFF) : null,
                    side: selected
                        ? BorderSide(color: Color(0xFFFFFFFF), width: 2)
                        : null,
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                    primary: Colors.white70,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                  onPressed: press,
                  icon: Icon(
                    icon,
                    color: color,
                  ),
                  label: Text(
                    title,
                    style: GoogleFonts.raleway(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
    );
  }
}
