import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'package:places/widgets/input_image.dart';

class PagePlaceAdd extends StatefulWidget {
  static const route = '/places/add';
  const PagePlaceAdd({super.key});

  @override
  State<PagePlaceAdd> createState() => _PagePlaceAddState();
}

class _PagePlaceAddState extends State<PagePlaceAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Places - Add'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: [
                  TextFormField(
                    // initialValue: _formData.description,
                    decoration: const InputDecoration(labelText: 'Description'),
                    textInputAction: TextInputAction.next,
                    // validator: _formData.validateDescription,
                    onSaved: (newValue) {
                      // _formData.description = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const InputImage()
                ]),
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Submit'),
                    onPressed: () {
                      // _submitForm();
                    },
                  ))
            ],
          ),
        ));
  }
}

class PlaceFormData {
  String? id;
  String? _title;
  Location? location;
  File? image;

  String? get title {
    return _title;
  }

  PlaceFormData() {
    id = _title = '';
  }

  PlaceFormData.fromProduct(Place place) {
    id = place.id;
    _title = place.title;
  }

  set title(String? title) {
    if (validateTitle(title) == null) {
      _title = title;
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? validateImage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an image url';
    }
    if (!value.startsWith(RegExp('^https?://'))) {
      return 'Please enter a valid image url';
    }
    return null;
  }

  Place toPlace() {
    return Place(
        id: '',
        title: title ?? '',
        location: Location(lattitude: 0, longitude: 0, address: ''),
        image: File(''));
  }
}
