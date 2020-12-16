import 'package:flutter/material.dart';

class FormBuilderValidators {
  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator required({
    String errorText = "This field cannot be empty.",
  }) {
    return (valueCandidate) {
      if (valueCandidate == null ||
          ((valueCandidate is Iterable ||
                  valueCandidate is String ||
                  valueCandidate is Map) &&
              valueCandidate.length == 0)) {
        return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value be true.
  /// Commonly used for required checkboxes.
  static FormFieldValidator requiredTrue({
    String errorText = "This field must be set to true",
  }) {
    return (valueCandidate) {
      if (valueCandidate != true) {
        return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// or equal to the provided number.
  static FormFieldValidator min(
    num min, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null &&
          ((valueCandidate is num && valueCandidate < min) ||
              (valueCandidate is String &&
                  num.tryParse(valueCandidate) != null &&
                  num.tryParse(valueCandidate) < min))) {
        return errorText ?? "Value must be greater than or equal to $min";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than
  /// or equal to the provided number.
  static FormFieldValidator max(
    num max, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null) {
        if ((valueCandidate is num && valueCandidate > max) ||
            (valueCandidate is String &&
                num.tryParse(valueCandidate) != null &&
                num.tryParse(valueCandidate) > max)) {
          return errorText ?? "Value must be less than or equal to $max";
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  static FormFieldValidator minLength(
    num minLength, {
    bool allowEmpty = false,
    String errorText,
  }) {
    return (valueCandidate) {
      final valueLength = valueCandidate?.length ?? 0;
      if (valueLength < minLength && (!allowEmpty || valueLength > 0)) {
        return errorText ??
            "Value must have a length greater than or equal to $minLength";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  static FormFieldValidator maxLength(
    num maxLength, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.length > maxLength) {
        return errorText ??
            "Value must have a length less than or equal to $maxLength";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to match the provided regex pattern.
  static FormFieldValidator pattern(
    Pattern pattern, {
    String errorText = "Value does not match pattern.",
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!RegExp(pattern).hasMatch(valueCandidate)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  static FormFieldValidator numeric({
    String errorText = "Value must be numeric.",
  }) {
    return (valueCandidate) {
      if (num.tryParse(valueCandidate) == null && valueCandidate.isNotEmpty) {
        return errorText;
      }
      return null;
    };
  }
}
