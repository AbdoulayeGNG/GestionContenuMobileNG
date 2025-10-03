import 'package:flutter/material.dart';
import 'package:gestioncontenu/models/content.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const ContentCard({super.key, required this.item, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            SizedBox(
              width: 84,
              height: 84,
              child: item.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(item.image, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image)),
                    )
                  : const Icon(Icons.image, size: 48),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 6, children: item.tags.map((t) => Chip(label: Text(t), visualDensity: VisualDensity.compact)).toList()),
              ]),
            ),
            if (onEdit != null || onDelete != null) ...[
              const SizedBox(width: 8),
              Column(children: [
                if (onEdit != null)
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: onEdit),
                if (onDelete != null)
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
              ])
            ]
          ]),
        ),
      ),
    );
  }
}
