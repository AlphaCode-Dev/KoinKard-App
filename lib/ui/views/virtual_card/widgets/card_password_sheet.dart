import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../virtual_card_viewmodel.dart';

class CardPasswordSheet extends StatefulWidget {
  const CardPasswordSheet(
      {super.key, required this.model, required this.terminating});
  final VirtualCardViewModel model;
  final bool terminating;

  @override
  State<CardPasswordSheet> createState() => _CardPasswordSheetState();
}

class _CardPasswordSheetState extends State<CardPasswordSheet> {
  final _password = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _obscure = true;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_busy || !_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.model.verifyPassword(_password.text);
    if (!mounted) return;
    if (error == null) {
      _password.clear();
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _busy = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
              child: Form(
                  key: _form,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lock_outline_rounded,
                            color: AppColors.primary, size: 28),
                        const SizedBox(height: 12),
                        Text(
                            widget.terminating
                                ? 'Terminate card'
                                : 'Card details',
                            style: const TextStyle(
                                color: AppColors.darkText,
                                fontSize: 21,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text(
                            widget.terminating
                                ? 'Enter your account password to continue to card termination.'
                                : 'Enter your account password to view your card details.',
                            style: const TextStyle(
                                color: AppColors.balanceLabel, height: 1.5)),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const ValueKey('card-action-password'),
                          controller: _password,
                          enabled: !_busy,
                          obscureText: _obscure,
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(color: AppColors.darkText),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter your account password.'
                              : null,
                          onFieldSubmitted: (_) => _verify(),
                          decoration: InputDecoration(
                            labelText: 'Account password',
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            suffixIcon: IconButton(
                                tooltip: _obscure
                                    ? 'Show password'
                                    : 'Hide password',
                                onPressed: _busy
                                    ? null
                                    : () =>
                                        setState(() => _obscure = !_obscure),
                                icon: Icon(
                                    _obscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.balanceLabel)),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Semantics(
                              liveRegion: true,
                              child: Text(_error!,
                                  style: const TextStyle(
                                      color: AppColors.errorBorder))),
                        ],
                        const SizedBox(height: 20),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white),
                              onPressed: _busy ? null : _verify,
                              child: _busy
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.white))
                                  : const Text('Verify password'),
                            )),
                        Center(
                            child: TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel',
                                    style: TextStyle(
                                        color: AppColors.balanceLabel)))),
                      ])),
            )),
      );
}
