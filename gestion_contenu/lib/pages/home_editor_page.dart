import 'package:flutter/material.dart';
import 'package:gestioncontenu/models/content.dart';
import 'package:gestioncontenu/providers/auth_provider.dart';
import 'package:gestioncontenu/providers/content_provider.dart';
import 'package:gestioncontenu/widgets/content_card.dart';
import 'package:provider/provider.dart';

class HomeEditorPage extends StatefulWidget {
  const HomeEditorPage({super.key});
  static const routeName = '/home_editor';

  @override
  State<HomeEditorPage> createState() => _HomeEditorPageState();
}

class _HomeEditorPageState extends State<HomeEditorPage> {
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

  Future<void> _openCreateDialog() async {
    final created = await showDialog<ContentItem>(
      context: context,
      builder: (ctx) => const _ContentDialog(),
    );
    if (created != null && mounted) {
      await context.read<ContentProvider>().create(created);
    }
  }

  Future<void> _openEditDialog(ContentItem item) async {
    final updated = await showDialog<ContentItem>(
      context: context,
      builder: (ctx) => _ContentDialog(existing: item),
    );
    if (updated != null && mounted) {
      await context.read<ContentProvider>().update(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = context.watch<ContentProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes contenus'),
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
                        onEdit: content.canEdit(item) ? () => _openEditDialog(item) : null,
                        onDelete: content.canEdit(item)
                            ? () async {
                                final ok = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Supprimer'),
                                    content: const Text('Confirmer la suppression ?'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
                                      FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Supprimer')),
                                    ],
                                  ),
                                );
                                if (ok == true && mounted) {
                                  await context.read<ContentProvider>().remove(item.id);
                                }
                              }
                            : null,
                      );
                    },
                  ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContentDialog extends StatefulWidget {
  final ContentItem? existing;
  const _ContentDialog({this.existing});

  @override
  State<_ContentDialog> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<_ContentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _imageCtrl;
  late final TextEditingController _categoryCtrl;
  late final TextEditingController _tagsCtrl;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _titleCtrl = TextEditingController(text: e?.title ?? '');
    _descCtrl = TextEditingController(text: e?.description ?? '');
    _imageCtrl = TextEditingController(text: e?.image ?? '');
    _categoryCtrl = TextEditingController(text: e?.category ?? '');
    _tagsCtrl = TextEditingController(text: (e?.tags ?? []).join(','));
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _imageCtrl.dispose();
    _categoryCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final tags = _tagsCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (widget.existing == null) {
      Navigator.pop(
        context,
        ContentItem(
          id: '',
          title: _titleCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          image: _imageCtrl.text.trim(),
          authorId: '',
          tags: tags,
          category: _categoryCtrl.text.trim(),
        ),
      );
    } else {
      Navigator.pop(
        context,
        widget.existing!.copyWith(
          title: _titleCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          image: _imageCtrl.text.trim(),
          tags: tags,
          category: _categoryCtrl.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? 'Nouveau contenu' : 'Modifier le contenu'),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (v) => v != null && v.isNotEmpty ? null : 'Requis',
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (v) => v != null && v.isNotEmpty ? null : 'Requis',
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _imageCtrl,
                decoration: const InputDecoration(labelText: "URL de l'image"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _categoryCtrl,
                decoration: const InputDecoration(labelText: 'Catégorie'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tagsCtrl,
                decoration: const InputDecoration(labelText: 'Tags (séparés par des virgules)'),
              ),
            ]),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
        FilledButton(onPressed: _submit, child: const Text('Valider')),
      ],
    );
  }
}
