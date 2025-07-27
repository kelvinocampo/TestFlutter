import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/api_key_model.dart';
import '../providers/api_key_provider.dart';
import '../l10n/app_localizations.dart';

class ApiKeyForm extends StatefulWidget {
  final ApiKey? existingKey;

  const ApiKeyForm({super.key, this.existingKey});

  @override
  State<ApiKeyForm> createState() => _ApiKeyFormState();
}

class _ApiKeyFormState extends State<ApiKeyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _keyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingKey != null) {
      _nameController.text = widget.existingKey!.name;
      _keyController.text = widget.existingKey!.key;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final nameText = _nameController.text.trim();
      final keyText = _keyController.text.trim();
      final provider = context.read<ApiKeyProvider>();

      final newKey = ApiKey(
        id: widget.existingKey?.id,
        name: nameText,
        key: keyText,
        isActive: widget.existingKey?.isActive ?? false,
      );

      if (widget.existingKey != null) {
        await provider.editKey(newKey);
      } else {
        await provider.addKey(newKey);
      }

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(
        widget.existingKey != null ? localizations.edit_apikey : localizations.new_apikey,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: localizations.apikey_name),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localizations.apikey_name_required;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _keyController,
              decoration: const InputDecoration(labelText: 'API Key'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localizations.apikey_required;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations.cancel),
        ),
        ElevatedButton(onPressed: _save, child: Text(localizations.save)),
      ],
    );
  }
}
