import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestioncontenu/data/mocked_data.dart';
import 'package:gestioncontenu/models/content.dart';
import 'package:gestioncontenu/presentation/providers/content_provider.dart';
import 'package:gestioncontenu/presentation/widgets/content_card.dart';
import 'package:gestioncontenu/providers/auth_provider.dart';
import 'package:gestioncontenu/providers/content_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeEditorPage extends ConsumerStatefulWidget {
  const HomeEditorPage({super.key});
  static const routeName = '/home_editor';

  @override
  ConsumerState<HomeEditorPage> createState() => _HomeEditorPageState();
}

class _HomeEditorPageState extends ConsumerState<HomeEditorPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final contentAsync = ref.watch(allContentProvider);
    final fakeAsync = AsyncData(contents_data);

    final contents = fakeAsync.when(
      data: (contents) {
        if (contents.isEmpty) {
          return Center(child: Text('Aucun contenu trouve'));
        }
        final data = contents
            .map((content) => ContentCard(
                  content: content,
                ))
            .toList();
        return SingleChildScrollView(
          child: Column(
            children: data,
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text("Erreur lors de la recuperation des contenus}"),
      ),
      loading: () => CircularProgressIndicator(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Publications'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 25,
              ),
              onPressed: _showBottomSheet)
        ],
      ),
      body: contents,
    );
  }

  _showBottomSheet() {
    String imagePath = "";
    XFile? image;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                image = await takeImage();
                                setState(() {
                                  imagePath = image!.path;
                                });
                                print(imagePath);
                              },
                              icon: Icon(Icons.camera_alt)),
                          FormBuilderTextField(
                            name: 'title',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Titre',
                              hintText: 'Saisir le titre',
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'description',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: 'Saisir une description',
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'tags',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'tags',
                              hintText: 'Saisir le tag',
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'category',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Category',
                              hintText: 'Saisir la category',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: submit,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text("Enregistrer",
                                    style: TextStyle(color: Colors.white)),
                              ))
                        ],
                      ),
                    ),
                  )));
        });
  }

  Future<XFile?> takeImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image;

    await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              "Choisir une source",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.camera);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text('CAMERA'),
              ),
              TextButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text('GALLERY'),
              )
            ],
          );
        });

    return image;
  }

  void submit() {
    final data = _formKey.currentState!.saveAndValidate();
    print(data);
  }
}

// class _ContentDialog extends StatefulWidget {
//   final ContentItem? existing;
//   const _ContentDialog({this.existing});

//   @override
//   State<_ContentDialog> createState() => _ContentDialogState();
// }

// class _ContentDialogState extends State<_ContentDialog> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _titleCtrl;
//   late final TextEditingController _descCtrl;
//   late final TextEditingController _imageCtrl;
//   late final TextEditingController _categoryCtrl;
//   late final TextEditingController _tagsCtrl;

//   @override
//   void initState() {
//     super.initState();
//     final e = widget.existing;
//     _titleCtrl = TextEditingController(text: e?.title ?? '');
//     _descCtrl = TextEditingController(text: e?.description ?? '');
//     _imageCtrl = TextEditingController(text: e?.image ?? '');
//     _categoryCtrl = TextEditingController(text: e?.category ?? '');
//     _tagsCtrl = TextEditingController(text: (e?.tags ?? []).join(','));
//   }

//   @override
//   void dispose() {
//     _titleCtrl.dispose();
//     _descCtrl.dispose();
//     _imageCtrl.dispose();
//     _categoryCtrl.dispose();
//     _tagsCtrl.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     final tags = _tagsCtrl.text
//         .split(',')
//         .map((e) => e.trim())
//         .where((e) => e.isNotEmpty)
//         .toList();
//     if (widget.existing == null) {
//       Navigator.pop(
//         context,
//         ContentItem(
//           id: '',
//           title: _titleCtrl.text.trim(),
//           description: _descCtrl.text.trim(),
//           image: _imageCtrl.text.trim(),
//           authorId: '',
//           tags: tags,
//           category: _categoryCtrl.text.trim(),
//         ),
//       );
//     } else {
//       Navigator.pop(
//         context,
//         widget.existing!.copyWith(
//           title: _titleCtrl.text.trim(),
//           description: _descCtrl.text.trim(),
//           image: _imageCtrl.text.trim(),
//           tags: tags,
//           category: _categoryCtrl.text.trim(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//           widget.existing == null ? 'Nouveau contenu' : 'Modifier le contenu'),
//       content: SizedBox(
//         width: 480,
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(children: [
//               TextFormField(
//                 controller: _titleCtrl,
//                 decoration: const InputDecoration(labelText: 'Titre'),
//                 validator: (v) => v != null && v.isNotEmpty ? null : 'Requis',
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _descCtrl,
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//                 validator: (v) => v != null && v.isNotEmpty ? null : 'Requis',
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _imageCtrl,
//                 decoration: const InputDecoration(labelText: "URL de l'image"),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _categoryCtrl,
//                 decoration: const InputDecoration(labelText: 'Catégorie'),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _tagsCtrl,
//                 decoration: const InputDecoration(
//                     labelText: 'Tags (séparés par des virgules)'),
//               ),
//             ]),
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Annuler')),
//         FilledButton(onPressed: _submit, child: const Text('Valider')),
//       ],
//     );
//   }

// }
