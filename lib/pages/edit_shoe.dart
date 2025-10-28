//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/modals/shoe_modal.dart';
import 'package:shoe_app/services/shoe_service.dart';

class EditShoe extends StatefulWidget {
  final Shoe shoe;
  const EditShoe({super.key, required this.shoe});

  @override
  State<EditShoe> createState() => _EditShoeState();
}

class _EditShoeState extends State<EditShoe> {
  late TextEditingController showNameEditController;
  late TextEditingController costPriceEditController;
  late TextEditingController sellPricEditEController;
  late TextEditingController descriptionEditController;
  String _dateEditString = '';
  DateTime? _dateEditTime;
  String _dateEditStringSold = '';
  DateTime? _dateEditTimeSold;
  //String? _statusEditMessage;
  //bool isLoading = false;
  bool _value = false;

  @override
  void initState() {
    super.initState();
    showNameEditController = TextEditingController(text: widget.shoe.shoeName);
    costPriceEditController = TextEditingController(
      text: widget.shoe.costPrice.toString(),
    );
    sellPricEditEController = TextEditingController(
      text: widget.shoe.sellPrice.toString(),
    );
    descriptionEditController = TextEditingController(
      text: widget.shoe.description,
    );
    _dateEditString = convertDateToString(widget.shoe.dateBought);
    _dateEditTime = widget.shoe.dateBought;
    _dateEditStringSold = widget.shoe.dateSold.toString();
    _dateEditTimeSold = widget.shoe.dateSold;
    _value = widget.shoe.status!;
  }

  @override
  void dispose() {
    showNameEditController.dispose();
    costPriceEditController.dispose();
    sellPricEditEController.dispose();
    descriptionEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final bytes = base64Decode(widget.shoe.imageUrl);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Edit ${widget.shoe.shoeName}',
                style: TextStyle(fontSize: 30, color: Colors.brown),
              ),
              space,
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Hero(
                  tag: 'shoe-image-${widget.shoe.id}',
                  child: Image.memory(
                    widget.shoe.imageBytes,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextField(
                controller: showNameEditController,
                decoration: InputDecoration(labelText: 'Shoe Name'),
              ),
              space,
              TextField(
                controller: costPriceEditController,
                decoration: InputDecoration(labelText: 'Cost Price'),
              ),
              space,
              TextField(
                controller: sellPricEditEController,
                decoration: InputDecoration(labelText: 'Sell Price'),
              ),
              space,
              TextField(
                controller: descriptionEditController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              space,
              Row(
                children: [
                  Text('Selected Date: '),
                  SizedBox(width: 7),
                  Text(
                    _dateEditString,
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                ],
              ),
              space,
              Row(
                children: [
                  Text(
                    'pick date the shoe was bought',
                    style: TextStyle(color: Colors.brown),
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
                    _dateEditStringSold,
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                ],
              ),
              space,
              Row(
                children: [
                  Text(
                    'pick date the shoe was sold',
                    style: TextStyle(color: Colors.brown),
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
              // if (_statusEditMessage != null) ...[
              //   Text(_statusEditMessage!, style: TextStyle(color: Colors.red)),
              //   space,
              // ],
              ElevatedButton(
                onPressed: () {
                  saveShoe(context);
                },
                child: Text('Edit Shoe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String convertDateToString(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();

    if (month.length == 1) {
      month = '0$month';
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
      _dateEditString = dateString;
      _dateEditTime = dateTime;
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
      _dateEditStringSold = dateString;
      _dateEditTimeSold = dateTime;
    });
  }

  void saveShoe(BuildContext context) {
    Provider.of<ShoeService>(context, listen: false).editShoe(
      widget.shoe.id,
      shoeName: showNameEditController.text,
      costPrice: double.parse(costPriceEditController.text),
      sellPrice: double.parse(sellPricEditEController.text),
      dateBought: _dateEditTime!,
      //imageUrl: widget.shoe.imageUrl,
      description: descriptionEditController.text,
      status: _value,
      dateSold: _dateEditTimeSold,
    );
    print('${widget.shoe.shoeName} updated successfully');
    Navigator.of(context).popUntil((route) => route.isFirst);
    clearFields();
  }

  void clearFields() {
    showNameEditController.clear();
    costPriceEditController.clear();
    sellPricEditEController.clear();
    descriptionEditController.clear();
    setState(() {
      _dateEditString = '';
      _dateEditTime = null;
    });
  }
}
