part of'helpers.dart';


InputDecoration fieldDecoNew({
  String? labelText,
  String? hintText,
  IconData? prefixIcon,
  Widget? prefixWidget,
  Widget? suffix,
  InputBorder? border,
  bool isFilled = true,
  bool value = false,
  double? yPadding,
  double? outlineBorderRadius,
  String? helperText,
  Color? fillColor,
  BorderRadius? classBorderRadius,
}) {
  return InputDecoration(
    filled: isFilled,
    fillColor: value ? white : fillColor,
    border: border ?? (isFilled ? InputBorder.none : null),
    contentPadding:
    EdgeInsets.symmetric(horizontal: 10, vertical: yPadding ?? 0),
    labelText: labelText,
    hintText: hintText,
    counterText: '',
    labelStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    helperText: helperText,
    helperMaxLines: 3,
    hintStyle: const TextStyle(fontSize: 14.0),
    prefixIcon: prefixWidget ??
        (prefixIcon != null ? Icon(prefixIcon, size: 20) : null),
    suffixIcon: suffix,
    enabledBorder: isFilled
        ? fieldEnabledFillBorder(
      value,
      outlineBorderRadius,
      classBorderRadius,
    )
        : fieldEnabledLineBorder(
      value,
      classBorderRadius,
    ),
    disabledBorder: isFilled
        ? fieldEnabledFillBorder(
      value,
      outlineBorderRadius,
      classBorderRadius,
    )
        : fieldDisabledBorder(
      value,
      classBorderRadius,
    ),
    errorBorder: fieldErrorBorder(
      value,
      classBorderRadius,
    ),
    focusedErrorBorder: focusedErrorBorder(
      value,
      classBorderRadius,
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    ),
    focusedBorder: isFilled
        ? focusedFillBorder(
      value,
      classBorderRadius,
    )
        : focusedLineBorder(
      value,
      classBorderRadius,
    ),
  );
}

/// Fields Borders
OutlineInputBorder fieldEnabledFillBorder(
    bool value,
    double? outlineBorderRadius,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
        borderRadius: classBorderRadius ??
            BorderRadius.circular(outlineBorderRadius ?? 30.0),
        borderSide: BorderSide(color: value ? white : Colors.black87));

OutlineInputBorder fieldEnabledLineBorder(
    bool value,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
      borderSide:
      BorderSide(color: value ? white : Colors.black54, width: 1.2),
      borderRadius: classBorderRadius ?? BorderRadius.circular(30.0),
    );

OutlineInputBorder fieldDisabledBorder(
    bool value,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
      borderSide: BorderSide(
          color: value ? white : Colors.grey.withOpacity(0.5),
          width: 1.2),
      borderRadius: classBorderRadius ?? BorderRadius.circular(30.0),
    );

OutlineInputBorder fieldErrorBorder(
    bool value,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
      borderRadius: classBorderRadius ?? BorderRadius.circular(30.0),
    );

OutlineInputBorder focusedErrorBorder(
    bool value,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
      borderRadius: classBorderRadius ?? BorderRadius.circular(30.0),
    );

OutlineInputBorder focusedFillBorder(
    bool value,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
        borderRadius: classBorderRadius ?? BorderRadius.circular(30.0),
        borderSide: BorderSide(
            color: value ? white : Colors.black.withOpacity(0.8),
            width: 2));

OutlineInputBorder focusedLineBorder(
    bool value,
    BorderRadius? classBorderRadius,
    ) =>
    OutlineInputBorder(
      borderSide:
      BorderSide(color: value ? white : Colors.black, width: 1.5),
      borderRadius: classBorderRadius ?? BorderRadius.circular(30.0),
    );
