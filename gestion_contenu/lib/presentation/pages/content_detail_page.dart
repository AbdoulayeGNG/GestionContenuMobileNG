import 'package:flutter/material.dart';
import 'package:gestioncontenu/core/constants.dart';
import 'package:gestioncontenu/domains/entities/content.dart';

class ContentDetailPage extends StatelessWidget {
  final Content content;

  const ContentDetailPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                format.format(content.updatedAt!),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Titre
              Text(
                content.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/img/belair.jpg',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.category, color: Colors.blue[600], size: 25),
                      SizedBox(
                        width: 10,
                      ),
                      Text(content.category),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.tag, color: Colors.blue[600], size: 25),
                      SizedBox(
                        width: 10,
                      ),
                      Text(content.tags!),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                content.description!,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
