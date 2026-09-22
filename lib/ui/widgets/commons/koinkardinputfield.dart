import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class KoinkardInputField extends StatefulWidget {
  const KoinkardInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.fillColor,
    this.borderColor,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<KoinkardInputField> createState() => _KoinkardInputFieldState();
}

class _KoinkardInputFieldState extends State<KoinkardInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant KoinkardInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseBorderColor =
        widget.borderColor ?? kWhiteColor.withValues(alpha: 0.14);
    final activeBorderColor = kOrangeColor.withValues(alpha: 0.85);
    final inputFillColor =
        widget.fillColor ?? kWhiteColor.withValues(alpha: 0.06);

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
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          obscureText: _obscureText,
          enableSuggestions: widget.enableSuggestions && !_obscureText,
          autocorrect: widget.autocorrect && !_obscureText,
          maxLines: _obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          style: AppTextStyles.bodyMedium.copyWith(
            color: kWhiteColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            counterText: '',
            filled: true,
            fillColor: inputFillColor,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: kWhiteColor.withValues(alpha: 0.46),
            ),
            helperStyle: AppTextStyles.labelXSmall.copyWith(
              color: kWhiteColor.withValues(alpha: 0.58),
            ),
            errorStyle: AppTextStyles.labelXSmall.copyWith(
              color: Colors.red.shade300,
            ),
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 16.h,
                ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 8.w),
                    child: widget.prefixIcon,
                  ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 24.w,
              minHeight: 24.h,
            ),
            suffixIcon: _buildSuffixIcon(),
            suffixIconConstraints: BoxConstraints(
              minWidth: 24.w,
              minHeight: 24.h,
            ),
            enabledBorder: _buildBorder(baseBorderColor),
            focusedBorder: _buildBorder(activeBorderColor),
            border: _buildBorder(baseBorderColor),
            disabledBorder:
                _buildBorder(baseBorderColor.withValues(alpha: 0.08)),
            errorBorder: _buildBorder(Colors.red.shade300),
            focusedErrorBorder: _buildBorder(Colors.red.shade300),
          ),
        ),
      ],
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

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        onPressed: () => setState(() => _obscureText = !_obscureText),
        splashRadius: 18.r,
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: kWhiteColor.withValues(alpha: 0.72),
          size: 20.sp,
        ),
      );
    }

    if (widget.suffixIcon == null) {
      return null;
    }

    if (widget.onSuffixTap == null) {
      return Padding(
        padding: EdgeInsets.only(right: 14.w, left: 8.w),
        child: widget.suffixIcon,
      );
    }

    return IconButton(
      onPressed: widget.onSuffixTap,
      splashRadius: 18.r,
      icon: widget.suffixIcon!,
    );
  }
}
