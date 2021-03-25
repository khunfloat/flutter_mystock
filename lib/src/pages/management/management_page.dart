import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_stock/src/models/product_response.dart';
import 'package:my_stock/src/services/network.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  File _image;
  final picker = ImagePicker();
  final _form = GlobalKey<FormState>();
  bool _editMode;
  ProductResponse _product;

  @override
  void initState() {
    _editMode = true;
    _product = ProductResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      Object arguments = ModalRoute.of(context).settings.arguments;

      if (arguments is ProductResponse){
        _product = arguments;
      }
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                _buildNameInput(),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: _buildPriceInput(),
                      flex: 1,
                    ),
                    SizedBox(width: 12.0),
                    Flexible(
                      child: _buildStockInput(),
                      flex: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputStyle({String label}) => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        labelText: label,
      );

  TextFormField _buildNameInput() => TextFormField(
        initialValue: _product.name == null ? "" : _product.name.toString(),
        decoration: inputStyle(label: "name"),
        onSaved: (String value) {
          _product.name = value;
          print(value);
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        initialValue: _product.price == null ? "" : _product.price.toString(),
        decoration: inputStyle(label: "price"),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          _product.price = int.parse(value ?? 0);
          print(value);
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        initialValue: _product.stock == null ? "" : _product.stock.toString(),
        decoration: inputStyle(label: "stock"),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          _product.stock = int.parse(value ?? 0);
          print(value);
        },
      );

  AppBar _buildAppBar() => AppBar(
        centerTitle: false,
        title: Text(_editMode ? 'Edit Product' : 'Add Product'),
        actions: [
          TextButton(
            onPressed: () async {
              _form.currentState.save();
              FocusScope.of(context)
                  .requestFocus(FocusNode()); //out from focusing the form
              if (_editMode) {
                //todo
              } else {
                try {
                  final message = await NetworkService().addProduct(
                      null, _product);
                  // showAlertBar(message);
                  Navigator.pop(context);
                } catch (ex){
                  // showAlertBar(ex.toString(), color: Colors.red, icon: FontAwesomeIcons.cross);
                }
                }
              },
            child: Text(
              'submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      );

  void showAlertBar(
    String message, {
    IconData icon = FontAwesomeIcons.checkCircle,
    MaterialColor color = Colors.green,
  }) {
    Flushbar(
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }
}
