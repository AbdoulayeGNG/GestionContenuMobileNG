import 'package:flutter/material.dart';
import 'package:gestioncontenu/models/content.dart';
import 'package:gestioncontenu/providers/auth_provider.dart';
import 'package:gestioncontenu/providers/content_provider.dart';
import 'package:gestioncontenu/widgets/content_card.dart';
import 'package:provider/provider.dart';

class HomeViewerPage extends StatefulWidget {
  const HomeViewerPage({super.key});
  static const routeName = '/home_viewer';
  @override
  State<HomeViewerPage> createState() => _HomeViewerPageState();
}

class _HomeViewerPageState extends State<HomeViewerPage> {
  final _categoryCtrl = TextEditingController();
  final _tagCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ContentProvider>().fetch());
  }

  @override
  void dispose() {
    _categoryCtrl.dispose();
    _tagCtrl.dispose();
    super.dispose();
  }

  void _openDetail(ContentItem item) => Navigator.pushNamed(context, '/detail', arguments: item);

  @override
  Widget build(BuildContext context) {
    final content = context.watch<ContentProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contenus'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (!mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
            },
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _categoryCtrl,
                decoration: const InputDecoration(labelText: 'Catégorie'),
                onSubmitted: (v) => content.setCategoryFilter(v.trim()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _tagCtrl,
                decoration: const InputDecoration(labelText: 'Tag'),
                onSubmitted: (v) => content.setTagFilter(v.trim()),
              ),
            ),
            IconButton(
              onPressed: () {
                content.setCategoryFilter(_categoryCtrl.text.trim());
                content.setTagFilter(_tagCtrl.text.trim());
              },
              icon: const Icon(Icons.filter_list),
            )
          ]),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: content.fetch,
            child: content.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: content.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (ctx, i) {
                      final item = content.items[i];
                      return ContentCard(
                        item: item,
                        onTap: () => _openDetail(item),
                        onEdit: null,
                        onDelete: null,
                      );
                    },
                  ),
          ),
        ),
      ]),
    );
  }
}
