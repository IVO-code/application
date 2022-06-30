import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsPage extends StatefulWidget {
  CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        "CARDS PAGE",
        style: GoogleFonts.raleway(fontSize: 36, fontWeight: FontWeight.bold),
      ),
      Text(
        "sit amet lorem ipsum dolor sit amet",
        style: GoogleFonts.raleway(
            fontSize: 16, fontWeight: FontWeight.normal, height: 2),
      ),
    ]);
  }
}
