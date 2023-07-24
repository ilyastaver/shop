import 'package:flutter/material.dart';

typedef OnSearchChangedCallback = void Function(String query);

class SearchInput extends StatefulWidget {
  final OnSearchChangedCallback onSearchChanged;

  const SearchInput({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool _isSearching = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorTheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _textEditingController,
        onChanged: (value) {
          setState(() {
            _isSearching = value.isNotEmpty;
            widget.onSearchChanged(value); // Call the callback with the search query
          });
        },
        onSubmitted: (value) {
          if (_isSearching) {
            _clearSearch();
          }
        },
        decoration: InputDecoration(
          hintText: 'ПОИСК',
          hintStyle: textTheme.bodyMedium?.copyWith(color: colorTheme.onBackground),
          prefixIcon: IconButton(
            icon: Icon(
              _isSearching ? Icons.clear : Icons.search,
              color: _isSearching ? Colors.grey : null,
            ),
            onPressed: () {
              if (_isSearching) {
                _clearSearch();
              }
            },
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey, // You can customize the color of the border when not focused
            ),
            borderRadius: BorderRadius.zero,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey, // You can customize the color of the border when focused
            ),
            borderRadius: BorderRadius.zero,
          ),
          filled: true,
          fillColor: colorTheme.onSecondary,
        ),
      ),
    );
  }

  void _clearSearch() {
    _textEditingController.clear();
    setState(() {
      _isSearching = false;
    });

    FocusScope.of(context).unfocus();

    widget.onSearchChanged('');
  }
}
