import 'package:flutter/material.dart';
import 'package:gestioncontenu/models/content.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({super.key});
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final ContentItem item = ModalRoute.of(context)!.settings.arguments as ContentItem;
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (item.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(item.image, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(height: 160, child: Center(child: Icon(Icons.broken_image)))),
            ),
          const SizedBox(height: 16),
          Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(children: [
            Icon(Icons.person, color: Colors.grey.shade700),
            const SizedBox(width: 6),
            Expanded(child: Text('Auteur: ${item.authorId}', overflow: TextOverflow.ellipsis)),
          ]),
          const SizedBox(height: 8),
          Text('Catégorie: ${item.category}'),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: item.tags.map((t) => Chip(label: Text(t))).toList()),
          const SizedBox(height: 16),
          Text(item.description),
        ]),
      ),
    );
  }
}
