import 'dart:convert' as convert;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading;

  var lastItemId = 'Q14J2k8VE3U';

  @override
  void initState() {
    super.initState();

    getJSONData();
  }

  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pagination demo'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            getJSONData();
            // start loading data
            setState(() {
              isLoading = true;
            });
          }
        },
        child: _buildListView(),
      ),
    );
  }

  // Function to get the JSON data
  Future<String> getJSONData() async {
    try {
      var response = await http.get(
          // Encode the url
          Uri.encodeFull(
              "https://unsplash.com/napi/photos/$lastItemId/related"),
          // Only accept JSON response
          headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        setState(() {
          List newItems = jsonResponse['results'];
          if (data == null) {
            data = newItems;
          } else {
            data.addAll(newItems);
          }

          lastItemId = data.last['id'];
          isLoading = false;
        });

        print(data.toString());
        print(lastItemId);
        return "successful";
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return 'failed';
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _buildImageColumn(data[index]);
        });
  }

  Widget _buildImageColumn(dynamic item) => Container(
        decoration: BoxDecoration(color: Colors.white54),
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            new CachedNetworkImage(
              imageUrl: item['urls']['small'],
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              fadeOutDuration: new Duration(seconds: 1),
              fadeInDuration: new Duration(seconds: 3),
            ),
            _buildRow(item)
          ],
        ),
      );

  Widget _buildRow(dynamic item) {
    return ListTile(
      title: Text(
        item['description'] == null ? '' : item['description'],
      ),
      subtitle: Text("Likes: " + item['likes'].toString()),
    );
  }
}
