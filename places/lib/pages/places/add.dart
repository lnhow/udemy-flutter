import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'package:places/providers/places.provider.dart';
import 'package:places/widgets/input_image.dart';
import 'package:places/widgets/input_location.dart';
import 'package:provider/provider.dart';

class PagePlaceAdd extends StatefulWidget {
  static const route = '/places/add';
  const PagePlaceAdd({super.key});

  @override
  State<PagePlaceAdd> createState() => _PagePlaceAddState();
}

class _PagePlaceAddState extends State<PagePlaceAdd> {
  final _formData = PlaceFormData();

  void _onSelectImage(File image) {
    _formData.image = image;
  }

  void _onSelectLocation(double lat, double lng) {
    _formData.location = Location(latitude: lat, longitude: lng);
  }

  void _submit() {
    if (_formData.validateTitle(_formData.title) != null ||
        _formData.location == null ||
        _formData.image == null) {
      return;
    }
    Place inputPlace = _formData.toPlace();
    Provider.of<PlacesProvider>(context, listen: false).add(inputPlace);
    Navigator.of(context).pop();
  }

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
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    // validator: _formData.validateDescription,
                    onChanged: (newValue) {
                      _formData.title = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputImage(_onSelectImage),
                  const SizedBox(
                    height: 16,
                  ),
                  InputLocation(_onSelectLocation),
                ]),
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Submit'),
                    onPressed: () {
                      _submit();
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
    location = place.location;
    image = place.image;
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

  Place toPlace() {
    return Place(
        id: '',
        title: title ?? '',
        location: location ?? Location(latitude: 0, longitude: 0, address: ''),
        image: image ?? File(''));
  }
}
