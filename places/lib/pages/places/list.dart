import 'package:flutter/material.dart';
import 'package:places/pages/places/add.dart';
import 'package:places/providers/places.provider.dart';
import 'package:places/widgets/empty.dart';
import 'package:places/widgets/loading.dart';
import 'package:provider/provider.dart';

class PagePlacesList extends StatelessWidget {
  static const route = '/places';
  const PagePlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PagePlaceAdd.route);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future:
              Provider.of<PlacesProvider>(context, listen: false).loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            return Consumer<PlacesProvider>(
                builder: (context, provider, child) {
                  final places = provider.places;
                  if (places.isEmpty) {
                    return child!;
                  }
                  return ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(place.image),
                          ),
                          title: Text(place.title),
                          onTap: () {
                            // TODO: Go to detail page
                          },
                        );
                      });
                },
                child: const EmptyList(
                  text: 'There are no places yet',
                ));
          }),
    );
  }
}
