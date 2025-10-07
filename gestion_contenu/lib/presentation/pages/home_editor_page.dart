import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestioncontenu/core/utils/search_field.dart';
import 'package:gestioncontenu/data/mocked_data.dart';
import 'package:gestioncontenu/domains/entities/content.dart';
import 'package:gestioncontenu/models/content.dart';
import 'package:gestioncontenu/presentation/providers/content_provider.dart';
import 'package:gestioncontenu/presentation/providers/theme_provider.dart';
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
  bool _isEditing = false;
  Content? _editingContent;
  String _imagePath = "";
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    // Gestiion du theme
    final theme = ref.watch(themeProvider);
    final contentAsync = ref.watch(allContentProvider);
    final fakeAsync = AsyncData(contents_data);

    final contents = fakeAsync.when(
      data: (contents) {
        if (contents.isEmpty) {
          return _buildEmptyState();
        }
        return _buildContentList(contents);
      },
      error: (error, stackTrace) => _buildErrorState(error),
      loading: () => _buildLoadingState(),
    );

    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      drawer: _buildDrawer(theme),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: SearchField(),
          ),
          Expanded(child: contents)
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Mes Publications',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.logout,
            weight: 2,
          ),
        )
      ],
      elevation: 1,
      shadowColor: Colors.black12,
    );
  }

  Drawer _buildDrawer(bool theme) {
    return Drawer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              SwitchListTile(
                value: theme,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).switchToTheme();
                },
                title: Text('Mode sombre', style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _showBottomSheet,
      backgroundColor: Colors.blue[600],
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.add, size: 28),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'Aucun contenu trouvé',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Commencez par créer votre première publication',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: _showBottomSheet,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Créer une publication'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 20),
            Text(
              "Erreur lors de la récupération",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Veuillez réessayer plus tard",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // TODO: Implémenter le rechargement
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue[600],
                side: BorderSide(color: Colors.blue[600]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 16),
          Text(
            'Chargement des contenus...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentList(List<Content> contents) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: contents.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ContentCard(
              content: contents[index],
              edit: () {
                _showBottomSheet(contentToEdit: contents[index]);
              }),
        );
      },
    );
  }

  void _showBottomSheet({Content? contentToEdit}) {
    _isEditing = contentToEdit != null;
    _editingContent = contentToEdit;
    // Renitialiser l'image
    if (!_isEditing) {
      _image = null;
      _imagePath = "";
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: _buildBottomSheetContent(),
        );
      },
    ).then((_) {
      _resetForm();
    });
  }

  Widget _buildBottomSheetContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBottomSheetHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    _buildImagePickerSection(),
                    const SizedBox(height: 24),
                    _buildFormFields(),
                  ],
                ),
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildBottomSheetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _isEditing
              ? 'Modification de la Publication'
              : 'Nouvelle Publication',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildImagePickerSection() {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _handleImage()),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                _pickImage(setState);
              },
              icon: const Icon(Icons.camera_alt, size: 18),
              label: const Text('CHOISIR UNE IMAGE'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue[600],
                side: BorderSide(color: Colors.blue[600]!),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _handleImage() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(_image!.path),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (_isEditing && _editingContent?.image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/img/ile_de_kassa.jpg', // Remplacez par votre asset
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 40,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'Ajouter une image',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField('title', 'Titre', 'Saisir le titre', Icons.title,
            initialValues: _editingContent?.title),
        const SizedBox(height: 16),
        _buildTextField('description', 'Description', 'Saisir une description',
            Icons.description,
            maxLines: 3, initialValues: _editingContent?.description),
        const SizedBox(height: 16),
        _buildTextField('tags', 'Tags',
            'Saisir les tags (séparés par des virgules)', Icons.tag,
            initialValues: _editingContent?.tags),
        const SizedBox(height: 16),
        _buildTextField(
            'category', 'Catégorie', 'Saisir la catégorie', Icons.category,
            initialValues: _editingContent?.category),
      ],
    );
  }

  Widget _buildTextField(
      String name, String labelText, String hintText, IconData icon,
      {int maxLines = 1, String? initialValues}) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValues,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Ce champ est requis'),
      ]),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
        ),
        filled: true,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Colors.grey[400]!),
              ),
              child: const Text('ANNULER'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: submit,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text('PUBLIER'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(setState) async {
    final image = await takeImage();
    if (image != null) {
      setState(() {
        _image = image;
        _imagePath = image.path;
      });
    }
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
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          message: Text(
            "Sélectionnez la source de l'image",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.camera);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Appareil photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.gallery);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Galerie'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Annuler',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );

    return image;
  }

  void submit() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      final Map<String, dynamic> formData;

      if (_image != null) {
        formData = {
          ...data,
          'image': _image,
        };
      } else {
        formData = {...data};
      }

      try {
        // Ligique de creation de modification
        // final asyncContent = _isEditing
        //     ? ref.read(contentNotifierProvider.notifier).createContent(formData)
        //     : ref
        //         .read(contentNotifierProvider.notifier)
        //         .editContent(formData, _editingContent!.id);
        _resetForm();
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Publication ${_isEditing ? 'modifiée' : 'créée'} avec succès!'),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      } catch (e) {
        print('Erreur: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la création: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _editingContent = null;
  }
}
