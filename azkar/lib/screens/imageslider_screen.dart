import 'package:azkar/models/args.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts_arabic/fonts.dart';

class ImageSlider extends StatefulWidget {
  ImageSlider({Key key}) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  var images = [];

  @override
  Widget build(BuildContext context) {
    Args arguments = ModalRoute.of(context).settings.arguments;
    fillList(arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مختصر النصيحة',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontFamily: ArabicFonts.Tajawal,
            package: 'google_fonts_arabic',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: 
      GFCarousel(
        enlargeMainPage: true,
        aspectRatio: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        height: 1000,
        viewportFraction: 0.98,
        
        items: images.map(
          (url) {
            return Container(
              alignment: Alignment.center,
              child: Card(
                child: Image.asset(
                  url,
                  fit: BoxFit.contain,
                  width: 1000.0,
                  height: 1000,
                ),
              ),
            );
          },
        ).toList(),
        onPageChanged: (index) {
          setState(() {
            index;
          });
        },
      ),
    );
  }

  Future<Widget> buildImage(String imag) async {
    return Card(
      child: Image.asset(
        imag,
        fit: BoxFit.fill,
      ),
    );
  }

  void fillList(Args arguments) {
    for (var i = arguments.start; i <= arguments.end; i++) {
      var path = "assets/images/$i.png";
      setState(() {
        images.add(path);
      });
    }
  }
}
