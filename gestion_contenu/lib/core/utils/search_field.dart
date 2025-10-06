import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.debounceDelay = const Duration(milliseconds: 500),
    this.hintText = 'Rechercher un contenu...',
  });

  final Duration debounceDelay;
  final String hintText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Timer? _debounceTimer;

  // void _onSearchChanged(String value) {
  //   // Annuler le timer précédent
  //   _debounceTimer?.cancel();

  //   // Démarrer un nouveau timer
  //   _debounceTimer = Timer(widget.debounceDelay, () {
  //     widget.onSearch(value);
  //   });
  // }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'search',
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[300],
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
      onChanged: (value) {},
      // onChanged: (value) => _onSearchChanged(value ?? ''),
    );
  }
}
