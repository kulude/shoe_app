//import 'dart:convert';
//import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/services/shoe_service.dart';
import 'package:shoe_app/utilities/scaffold_messanger.dart';
import 'package:shoe_app/utilities/text_field.dart';

class AddShoePage extends StatefulWidget {
  const AddShoePage({super.key});

  @override
  State<AddShoePage> createState() => _AddShoePageState();
}

class _AddShoePageState extends State<AddShoePage> {
  final showNameController = TextEditingController();
  final costPriceController = TextEditingController();
  final sellPriceController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _file;
  Uint8List? _uint8list;
  String _dateString = '';
  DateTime? _dateTime;
  String _dateStringSold = '';
  DateTime? _dateTimeSold;
  String? _statusMessage;
  bool isLoading = false;
  bool _value = false;

  @override
  void dispose() {
    showNameController.dispose();
    costPriceController.dispose();
    sellPriceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shoe'),
        actions: [
          Row(
            children: [
              isLoading
                  ? CircularProgressIndicator()
                  : Text('Take or select photo'),
              SizedBox(width: 6),
              PopupMenuButton(
                initialValue: 1,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text('Pick Photo'),
                    onTap: () {
                      takePhoto(source: ImageSource.gallery);
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('Take Photo'),
                    onTap: () {
                      takePhoto(source: ImageSource.camera);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                space,
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: _uint8list != null
                      ? Image.memory(_uint8list!, fit: BoxFit.cover)
                      : Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
                MyTextField(controller: showNameController, label: 'shoe name'),
                space,
                MyTextField(
                  controller: costPriceController,
                  label: 'Cost Price',
                ),
                space,
                MyTextField(
                  controller: sellPriceController,
                  label: 'Sell Price',
                ),
                space,
                MyTextField(
                  controller: descriptionController,
                  label: 'Description',
                ),
                space,
                Row(
                  children: [
                    Text('Selected Date: '),
                    SizedBox(width: 7),
                    Text(
                      _dateString,
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
                space,
                Row(
                  children: [
                    Text(
                      'pick date the shoe was bought',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(width: 7),
                    IconButton(
                      onPressed: pickDate,
                      icon: Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
                space,
                Row(
                  children: [
                    Text('Selected Date Sold: '),
                    SizedBox(width: 7),
                    Text(
                      _dateStringSold,
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
                space,
                Row(
                  children: [
                    Text(
                      'pick date the shoe was sold',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(width: 7),
                    IconButton(
                      onPressed: pickDateSold,
                      icon: Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _value ? 'Sold' : 'In stock',
                      style: TextStyle(fontSize: 24),
                    ),
                    Switch(
                      focusColor: Colors.brown,
                      value: _value,
                      onChanged: (bool? value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                  ],
                ),
                space,
                if (_statusMessage != null) ...[
                  Text(_statusMessage!, style: TextStyle(color: Colors.red)),
                  space,
                ],
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveShoe(context);
                    }
                  },
                  child: Text('Save Shoe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertDateToString(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();

    if (month.length == 1) {
      month = '0' + month;
    }
    String day = date.day.toString();

    if (day.length == 1) {
      day = '0' + day;
    }

    return '$year/$month/$day';
  }

  final space = SizedBox(height: 16);

  void pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2028),
    );

    final dateString = date != null
        ? convertDateToString(date)
        : 'No date selected';
    final dateTime = date ?? DateTime.now();
    setState(() {
      _dateString = dateString;
      _dateTime = dateTime;
    });
  }

  void pickDateSold() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2028),
    );

    final dateString = date != null
        ? convertDateToString(date)
        : 'No date selected';
    final dateTime = date;
    setState(() {
      _dateStringSold = dateString;
      _dateTimeSold = dateTime;
    });
  }

  void pickPhoto() async {
    setState(() {
      isLoading = true;
    });
    try {
      ImagePicker picker = ImagePicker();
      XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1280,
        maxWidth: 1280,
        imageQuality: 80,
      );

      if (pickedImage == null) return;

      final bytes = await computeBytes(pickedImage);

      if (!mounted) {
        setState(() {
          _file = pickedImage;
          _uint8list = bytes;
        });
      }
    } on PlatformException catch (e) {
      if (mounted) {
        Utilities().scaffoldMessanger(context, 'platform error ${e.message}');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void takePhoto({required ImageSource source}) async {
    setState(() {
      isLoading = true;
    });
    try {
      ImagePicker picker = ImagePicker();
      XFile? pickedImage = await picker.pickImage(source: source);

      if (pickedImage == null) return;

      final bytes = await computeBytes(pickedImage);
      if (mounted) {
        setState(() {
          _file = pickedImage;
          _uint8list = bytes;
        });
      }
    } on PlatformException catch (e) {
      if (mounted) {
        Utilities().scaffoldMessanger(context, 'permission  ${e.message}');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void saveShoe(BuildContext context) {
    if (_file == null || _dateTime == null) {
      setState(() {
        _statusMessage = 'Please select a photo and date.';
      });
      return;
    }
    //String image64String = base64Encode(_uint8list!);
    Shoe newShoe = Shoe(
      shoeName: showNameController.text,
      costPrice: double.parse(costPriceController.text),
      sellPrice: double.parse(sellPriceController.text),
      dateBought: _dateTime!,
      imageBytes: _uint8list!,
      description: descriptionController.text,
      status: _value,
      dateSold: _dateTimeSold,
    );
    Provider.of<ShoeService>(context, listen: false).addShoe(newShoe);
    Navigator.pop(context);
    clearFields();
  }

  void clearFields() {
    showNameController.clear();
    costPriceController.clear();
    sellPriceController.clear();
    descriptionController.clear();
    setState(() {
      _file = null;
      _uint8list = null;
      _dateString = '';
      _dateTime = null;
      _statusMessage = null;
    });
  }
}

Future<Uint8List> computeBytes(XFile file) async {
  return await compute(_readAsBytes, file.path);
}

Future<Uint8List> _readAsBytes(String path) async {
  final file = XFile(path);
  return await file.readAsBytes();
}
