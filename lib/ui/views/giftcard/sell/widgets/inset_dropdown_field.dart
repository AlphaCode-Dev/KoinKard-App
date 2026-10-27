import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class InsetDropdownField<T> extends FormField<T> {
  InsetDropdownField({
    super.key,
    required T? value,
    required InputDecoration decoration,
    required Widget selectedChild,
    required List<PopupMenuEntry<T>> items,
    required ValueChanged<T>? onChanged,
    Key? fieldKey,
    super.validator,
  }) : super(
          initialValue: value,
          enabled: onChanged != null && items.isNotEmpty,
          builder: (state) => Builder(builder: (buttonContext) {
            final enabled = onChanged != null && items.isNotEmpty;
            return Semantics(
              button: true,
              enabled: enabled,
              label: decoration.hintText,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: !enabled
                    ? null
                    : () async {
                        final selected =
                            await _showInsetMenu<T>(buttonContext, items);
                        if (buttonContext.mounted && selected != null) {
                          state.didChange(selected);
                          onChanged(selected);
                        }
                      },
                child: InputDecorator(
                  key: fieldKey,
                  decoration: decoration.copyWith(
                      enabled: enabled, errorText: state.errorText),
                  child: Row(children: [
                    Expanded(child: selectedChild),
                    const Icon(Icons.arrow_drop_down,
                        color: AppColors.balanceLabel),
                  ]),
                ),
              ),
            );
          }),
        );

  @override
  FormFieldState<T> createState() => _InsetDropdownFieldState<T>();
}

class _InsetDropdownFieldState<T> extends FormFieldState<T> {
  @override
  void didUpdateWidget(covariant InsetDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}

Future<T?> _showInsetMenu<T>(
    BuildContext context, List<PopupMenuEntry<T>> items) {
  final button = context.findRenderObject()! as RenderBox;
  final overlay =
      Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
  const inset = 30.0;
  final width = (button.size.width - inset * 2).clamp(0.0, button.size.width);
  final topLeft = button.localToGlobal(Offset(inset, button.size.height),
      ancestor: overlay);
  return showMenu<T>(
    context: context,
    color: AppColors.white,
    surfaceTintColor: AppColors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    constraints:
        BoxConstraints(minWidth: width, maxWidth: width, maxHeight: 360),
    position: RelativeRect.fromRect(
      Rect.fromLTWH(topLeft.dx, topLeft.dy, width, 0),
      Offset.zero & overlay.size,
    ),
    items: items,
  );
}
