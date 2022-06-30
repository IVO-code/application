import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "Lorem ipsum dolor",
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
