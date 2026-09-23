import 'package:flutter/material.dart';

/// A reusable search text field with a leading search icon and a clear
/// button that only appears once the user has typed something.
///
/// This is implemented as a [StatefulWidget] purely to listen to the
/// [TextEditingController] and rebuild when its text becomes
/// empty/non-empty (to show/hide the clear button) — the controller
/// itself is owned by the *caller*, not this widget, so the caller
/// retains full control over the current search text.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // Rebuilding on every keystroke is cheap here — this widget's subtree
    // is small — so a full setState is appropriate rather than
    // introducing a ValueListenableBuilder for this one field.
    setState(() {});
  }

  @override
  void dispose() {
    // We only remove the listener we added; we do NOT dispose
    // `widget.controller` here because this widget does not own it — the
    // parent screen created it and is responsible for its lifecycle.
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = widget.controller.text.isNotEmpty;

    return Semantics(
      textField: true,
      label: widget.hintText,
      child: TextField(
        controller: widget.controller,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: hasText
              ? IconButton(
                  icon: const Icon(Icons.close_rounded),
                  tooltip: 'Clear search',
                  onPressed: () {
                    widget.controller.clear();
                    widget.onClear?.call();
                  },
                )
              : null,
        ),
      ),
    );
  }
}
