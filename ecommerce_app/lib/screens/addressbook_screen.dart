import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  var addressList = [
    Text('Giza , monib'),
    Text('Luxor , esna'),
    Text('Luxor , arment'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MyAppBar.getAppBar(context, AppBarStatus.AdressBook, 'Address book'),
      body: Container(
        child: ListView.builder(
          itemCount: addressList.length,
          itemBuilder: (context, int index) {
            return Container(
              height: 80,
              child: ListTile(
                //contentPadding: EdgeInsets.only(bottom: 5,left: 10,right: 10),
                onTap: () {},
                title: addressList[index],
                subtitle: Text('full address ${(index + 1).toString()}'
                    '\nfull address ${(index + 1).toString()}'),
                trailing: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.star_border),
                        onPressed: () {},
                      ),
                    ),
                    // Container(),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.delete_sweep),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
