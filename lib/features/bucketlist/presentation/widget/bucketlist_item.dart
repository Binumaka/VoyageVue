import 'package:flutter/material.dart';

class BucketlistItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(String) onRemove;

  const BucketlistItem({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenWidth > 600 ? 250 : 150;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              (item['image'] != null && !item['image'].startsWith('http'))
                  ? 'http://192.168.1.70:3000/destinations_image/${item['image']}'
                  : item['image'],
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text('Destiantion Title: ${item['title']}'),
            Text('Location: ${item['location']}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onRemove(item['_id']),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Remove from Bucketlist'),
            )
          ],
        ),
      ),
    );
  }
}
