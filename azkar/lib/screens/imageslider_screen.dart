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
  var current_selected = 0;

  int current_page = 0;

  int counter = 0;
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
      body: GFCarousel(
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
                  height: 1000.0,
                  
                ),
              ),
            );
          },
        ).toList(),
        onPageChanged: (index) {
          current_page = index;
        },
      ),
      bottomNavigationBar: getBottomNavBar(),
      floatingActionButton: current_selected == 0
          ? FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              tooltip: 'المسبحة',
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: Text(
                '$counter',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
            )
          : null,
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

  getBottomNavBar() {
    return BottomNavigationBar(
      fixedColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: current_selected,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.remove_red_eye),
          title: Text('إظهار المسبحة'),
          activeIcon: Icon(
            Icons.remove_red_eye,
            color: Colors.deepOrange,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.panorama_fish_eye),
          title: Text('إخفاءالمسبحة'),
          activeIcon: Icon(
            Icons.panorama_fish_eye,
            color: Colors.deepOrange,
          ),
        ),
      ],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      current_selected = index;
      if (index == 1) {
        counter = 0;
      }
    });
  }
}
