import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class KoinkardOtpField extends StatefulWidget {
  const KoinkardOtpField({
    super.key,
    this.length = 6,
    this.label,
    this.helperText,
    this.errorText,
    this.initialValue,
    this.autofocus = false,
    this.enabled = true,
    this.obscureText = false,
    this.fillColor,
    this.borderColor,
    this.activeBorderColor,
    this.onChanged,
    this.onCompleted,
  }) : assert(length > 1, 'OTP length must be greater than 1');

  final int length;
  final String? label;
  final String? helperText;
  final String? errorText;
  final String? initialValue;
  final bool autofocus;
  final bool enabled;
  final bool obscureText;
  final Color? fillColor;
  final Color? borderColor;
  final Color? activeBorderColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<KoinkardOtpField> createState() => _KoinkardOtpFieldState();
}

class _KoinkardOtpFieldState extends State<KoinkardOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
    _seedInitialValue();
  }

  @override
  void didUpdateWidget(covariant KoinkardOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _seedInitialValue();
    }
  }

  void _seedInitialValue() {
    final normalized = (widget.initialValue ?? '')
        .replaceAll(RegExp(r'\s+'), '')
        .characters
        .take(widget.length)
        .toList();

    for (var i = 0; i < widget.length; i++) {
      _controllers[i].text = i < normalized.length ? normalized[i] : '';
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = widget.fillColor ?? kWhiteColor.withValues(alpha: 0.06);
    final borderColor =
        widget.borderColor ?? kWhiteColor.withValues(alpha: 0.14);
    final activeBorderColor =
        widget.activeBorderColor ?? kOrangeColor.withValues(alpha: 0.85);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.paragraphSmall.copyWith(
              color: kWhiteColor,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Row(
          children: List.generate(widget.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == widget.length - 1 ? 0 : 10.w,
                ),
                child: _OtpCell(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  autofocus: widget.autofocus && index == 0,
                  enabled: widget.enabled,
                  obscureText: widget.obscureText,
                  fillColor: fillColor,
                  borderColor: borderColor,
                  activeBorderColor: activeBorderColor,
                  onChanged: (value) => _handleChanged(index, value),
                ),
              ),
            );
          }),
        ),
        if (widget.helperText != null || widget.errorText != null) ...[
          SizedBox(height: 10.h),
          Text(
            widget.errorText ?? widget.helperText ?? '',
            style: AppTextStyles.labelXSmall.copyWith(
              color: widget.errorText != null
                  ? Colors.red.shade300
                  : kWhiteColor.withValues(alpha: 0.58),
            ),
          ),
        ],
      ],
    );
  }

  void _handleChanged(int index, String value) {
    if (value.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
      _notifyValueChanged();
      return;
    }

    if (value.length > 1) {
      _applyBulkValue(value);
      return;
    }

    _controllers[index].text = value.characters.last;
    _controllers[index].selection = TextSelection.fromPosition(
      TextPosition(offset: _controllers[index].text.length),
    );

    if (index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
    }

    _notifyValueChanged();
  }

  void _applyBulkValue(String value) {
    final characters = value.replaceAll(RegExp(r'\s+'), '').characters.toList();

    for (var i = 0; i < widget.length; i++) {
      _controllers[i].text = i < characters.length ? characters[i] : '';
    }

    final lastFilledIndex = characters.isEmpty
        ? 0
        : (characters.length - 1).clamp(0, widget.length - 1);

    if (characters.length >= widget.length) {
      _focusNodes[lastFilledIndex].unfocus();
    } else {
      _focusNodes[lastFilledIndex].requestFocus();
    }

    _notifyValueChanged();
  }

  void _notifyValueChanged() {
    final value = _controllers.map((controller) => controller.text).join();
    widget.onChanged?.call(value);

    final isComplete = _controllers.every(
      (controller) => controller.text.isNotEmpty,
    );

    if (isComplete) {
      widget.onCompleted?.call(value);
    }
  }
}

class _OtpCell extends StatelessWidget {
  const _OtpCell({
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.enabled,
    required this.obscureText,
    required this.fillColor,
    required this.borderColor,
    required this.activeBorderColor,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final bool enabled;
  final bool obscureText;
  final Color fillColor;
  final Color borderColor;
  final Color activeBorderColor;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        enabled: enabled,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        style: AppTextStyles.headingXSmall.copyWith(
          color: kWhiteColor,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(vertical: 18.h),
          enabledBorder: _buildBorder(borderColor),
          focusedBorder: _buildBorder(activeBorderColor),
          border: _buildBorder(borderColor),
          disabledBorder: _buildBorder(
            borderColor.withValues(alpha: 0.08),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.r),
      borderSide: BorderSide(
        color: color,
        width: 1.1,
      ),
    );
  }
}
