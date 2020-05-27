import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_adminside/db/brand.dart';
import 'package:ecommerce_adminside/db/category.dart';
import 'package:ecommerce_adminside/db/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  List<String> selectedSizes = <String>[];

  File image1;
  File image2;
  File image3;

  bool isLoading = false;
  @override
  void initState() {
    _getCategories();
    categoriesDropDown = getCategoriesDropDown();
    _getBrands();
    //  _currentCategory = categoriesDropDown[0].value;
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
          0,
          DropdownMenuItem(
            child: Text(categories[i].data['category']),
            value: categories[i].data['category'],
          ),
        );
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          'add product',
          style: TextStyle(
            color: black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Container(

                child: Center(
                  
                    child: CircularProgressIndicator(

                    ),
                  ),
              )
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              onPressed: () {
                                _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    1);
                              },
                              child: _displayChild1(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              onPressed: () {
                                _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    2);
                              },
                              child: _displayChild2(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              onPressed: () {
                                _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    3);
                              },
                              child: _displayChild3(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'enter a product name with 10 characters at maximum',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: red, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Product name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product name';
                          } else if (value.length > 10) {
                            return 'Product name cant have more than 10 letters';
                          }
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Category: ',
                              style: TextStyle(color: red),
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButton(
                            items: categoriesDropDown,
                            onChanged: changeSelectedCategory,
                            value: _currentCategory,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Brand: ',
                              style: TextStyle(color: red),
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButton(
                            items: brandsDropDown,
                            onChanged: changeSelectedBrand,
                            value: _currentBrand,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product name';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product price';
                          }
                        },
                      ),
                    ),
                    Text('Available Sizes'),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Checkbox(
                            value: selectedSizes.contains('XS'),
                            onChanged: (value) {
                              changeSelectedSize(value, 'XS');
                            },
                          ),
                        ),
                        Expanded(
                          child: Text('XS'),
                        ),
                        Expanded(
                          child: Checkbox(
                            value: selectedSizes.contains('S'),
                            onChanged: (value) {
                              changeSelectedSize(value, 'S');
                            },
                          ),
                        ),
                        Expanded(
                          child: Text('S'),
                        ),
                        Expanded(
                          child: Checkbox(
                            value: selectedSizes.contains('M'),
                            onChanged: (value) {
                              changeSelectedSize(value, 'M');
                            },
                          ),
                        ),
                        Expanded(
                          child: Text('M'),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Checkbox(
                            value: selectedSizes.contains('L'),
                            onChanged: (value) {
                              changeSelectedSize(value, 'L');
                            },
                          ),
                        ),
                        Expanded(
                          child: Text('L'),
                        ),
                        Expanded(
                          child: Checkbox(
                            value: selectedSizes.contains('XL'),
                            onChanged: (value) {
                              changeSelectedSize(value, 'XL');
                            },
                          ),
                        ),
                        Expanded(
                          child: Text('XL'),
                        ),
                        Expanded(
                          child: Checkbox(
                            value: selectedSizes.contains('XXL'),
                            onChanged: (value) {
                              changeSelectedSize(value, 'XXL');
                            },
                          ),
                        ),
                        Expanded(
                          child: Text('XXL'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('28'),
                              onChanged: (value) {
                                changeSelectedSize(value, '28');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('28'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('30'),
                              onChanged: (value) {
                                changeSelectedSize(value, '30');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('30'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('32'),
                              onChanged: (value) {
                                changeSelectedSize(value, '32');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('32'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('34'),
                              onChanged: (value) {
                                changeSelectedSize(value, '34');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('34'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('36'),
                              onChanged: (value) {
                                changeSelectedSize(value, '36');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('36'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('38'),
                              onChanged: (value) {
                                changeSelectedSize(value, '38');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('38'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('40'),
                              onChanged: (value) {
                                changeSelectedSize(value, '40');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('40'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('42'),
                              onChanged: (value) {
                                changeSelectedSize(value, '42');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('42'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('44'),
                              onChanged: (value) {
                                changeSelectedSize(value, '44');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('44'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('46'),
                              onChanged: (value) {
                                changeSelectedSize(value, '46');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('46'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('48'),
                              onChanged: (value) {
                                changeSelectedSize(value, '48');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('48'),
                          ),
                          Expanded(
                            child: Checkbox(
                              value: selectedSizes.contains('50'),
                              onChanged: (value) {
                                changeSelectedSize(value, '50');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text('50'),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('add product'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategory();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0].data['category'];
      print(categories.length);
    });
  }

  void changeSelectedCategory(String value) {
    setState(() {
      _currentCategory = value;
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      _currentBrand = brands[0].data['brand'];
      print(brands.length);
    });
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
          0,
          DropdownMenuItem(
            child: Text(brands[i].data['brand']),
            value: brands[i].data['brand'],
          ),
        );
      });
    }
    return items;
  }

  void changeSelectedBrand(String value) {
    setState(() {
      _currentBrand = value;
    });
  }

  changeSelectedSize(bool value, String size) {
    setState(() {
      if (selectedSizes.contains(size)) {
        selectedSizes.remove(size);
      } else {
        selectedSizes.add(size);
      }
    });

    print(selectedSizes);
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() {
          image1 = tempImg;
        });
        break;
      case 2:
        setState(() {
          image2 = tempImg;
        });
        break;
      case 3:
        setState(() {
          image3 = tempImg;
        });
        break;
      default:
    }
  }

  Widget _displayChild1() {
    if (image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Future<void> validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      if (image1 != null && image2 != null && image3 != null) {
        if (selectedSizes.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(image1);
          final String picture2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2 =
              storage.ref().child(picture2).putFile(image2);

          final String picture3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3 =
              storage.ref().child(picture3).putFile(image3);

          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);
          StorageTaskSnapshot snapshot2 =
              await task2.onComplete.then((snapshot) => snapshot);

          task3.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();

            List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

            productService.uploadProduct(
              productName: productNameController.text,
              price: double.parse(priceController.text),
              sizes: selectedSizes,
              images: imageList,
              quantity: int.parse(quantityController.text),
            );
            _formKey.currentState.reset();
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: 'Product added');
            Navigator.of(context).pop();
          });
        } else {
          Fluttertoast.showToast(msg: 'select at least one size');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        Fluttertoast.showToast(msg: 'all the images must be provided');
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
