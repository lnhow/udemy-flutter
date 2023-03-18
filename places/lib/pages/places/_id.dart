import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:places/pages/places/map.dart';
import 'package:places/providers/places.provider.dart';
import 'package:provider/provider.dart';

class PagePlaceDetail extends StatelessWidget {
  static const route = '/places/_id';

  const PagePlaceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final place = Provider.of<PlacesProvider>(context).getPlace(id as String);
    final location = place.location;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10),
          child: Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Text(
          location.address ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => PageMap(
                        initialLocation: location,
                        selectable: false,
                      )));
            },
            child: const Text('View on map'))
      ]),
    );
  }
}
