// Copyright (c) 2023 LLC "LitGroup"
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished
// to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'package:meta/meta.dart' show immutable;
import 'package:email_validator/email_validator.dart' show EmailValidator;

/// The value-type representing a e-mail address.
///
/// This type controls the validity of the email address.
///
/// NOTE: Top-level domains are forbidden, so the address "user@localhost"
/// is not allowed. This limitation was added to support the most common
/// use cases.
@immutable
final class EmailAddress {
  /// Tries to parse a e-mail address from the string.
  ///
  /// It succeeds if the entire string is a valid address.
  /// Throws [EmailAddressFormatException] for an invalid string.
  static EmailAddress parse(String value) {
    return validFormat(value)
        ? EmailAddress._internal(value)
        : throw EmailAddressFormatException.of(value);
  }

  /// Tries to parse a e-mail address from the string.
  ///
  /// It succeeds if the entire string is a valid address.
  /// Returns `null` for an invalid string.
  static EmailAddress? parseOrNull(String value) {
    return validFormat(value) ? EmailAddress._internal(value) : null;
  }

  /// Checks if the given string represents a valid e-mail address.
  static bool validFormat(String value) {
    return EmailValidator.validate(value, /* allowTopLevelDomains */ false);
  }

  EmailAddress._internal(this._value) : _canonicalValue = _value.toLowerCase();

  /// The original value.
  final String _value;

  /// The pre-cached lowercase value to be used for comparison.
  final String _canonicalValue;

  /// Makes case insensitive check for equality.
  @override
  bool operator ==(Object other) =>
      other is EmailAddress && other._canonicalValue == _canonicalValue;

  @override
  int get hashCode => _canonicalValue.hashCode;

  /// Returns the original string this value has been created from.
  @override
  String toString() => _value;
}

//------------------------------------------------------------------------------
// Exception
//------------------------------------------------------------------------------

class EmailAddressFormatException extends FormatException {
  /// Creates an exception.
  ///
  /// Supply the actual [source] with the incorrect format.
  EmailAddressFormatException.of(String source)
      : super('Invalid e-mail address format.', source);
}
