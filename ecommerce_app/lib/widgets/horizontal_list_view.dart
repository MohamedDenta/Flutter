import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  List<Category> listCategories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCtegories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection:Axis.horizontal,
        itemCount: listCategories.length,
        itemBuilder:(BuildContext context,int index){
          return listCategories[index];
        },
      ),
      // child: ListView(
      //   scrollDirection: Axis.horizontal,
      //   children: listCategories,
      //<Widget>[

      // Category(
      //   image_location: 'assets/images/cats/tshirt.png',
      //   image_caption: 'shirt',
      // ),
      // Category(
      //   image_location: 'assets/images/cats/dress.png',
      //   image_caption: 'dress',
      // ),
      // Category(
      //   image_location: 'assets/images/cats/jeans.png',
      //   image_caption: 'jeans',
      // ),
      // Category(
      //   image_location: 'assets/images/cats/formal.png',
      //   image_caption: 'formal',
      // ),
      // Category(
      //   image_location: 'assets/images/cats/informal.png',
      //   image_caption: 'informal',
      // ),
      // ],
      // ),
    );
  }

  Future<void> fetchCtegories() async {
    var categoRef = Firestore.instance.collection('categories').reference();
    var allDocs = await categoRef.getDocuments();
    print("FFFFF    ${allDocs.documents.length}");
    for (var item in allDocs.documents) {
      setState(() {
        listCategories.add(Category(
          image_caption: item['category_title'],
          image_location: item['icon_url'],
        ));
      });
    }
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Category({this.image_location, this.image_caption});
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width*0.25,
          child: ListTile(
            
            title: Image.network(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                image_caption,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ),
        ),
      ),
      padding: const EdgeInsets.all(2.0),
    );
  }
}
