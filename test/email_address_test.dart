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

import 'package:test/test.dart';

import 'package:email_address/email_address.dart';

void main() {
  // EmailAddress tests
  //----------------------------------------------------------------------------

  group('EmailAddress', () {
    const validAddressExamples = {
      'valid address in English': 'john@example.com',
      'valid address in Russian': 'джон@пример.ком',
    };

    const invalidAddressExamples = {
      'empty string': '',
      'invalid format': 'not a e-mail address',
      'address with the top-level domain': 'john@localhost',
    };

    group('parsing and validation:', () {
      validAddressExamples.forEach((exampleName, rawAddress) {
        test('.parse() succeeds for $exampleName', () {
          expect(() => EmailAddress.parse(rawAddress), returnsNormally);
        });
        test('.parseOrNull() succeeds for $exampleName', () {
          expect(EmailAddress.parseOrNull(rawAddress), isNotNull);
        });
        test('.validFormat() returns true for $exampleName', () {
          expect(EmailAddress.validFormat(rawAddress), isTrue);
        });
      });

      invalidAddressExamples.forEach((exampleName, rawAddress) {
        test('.parse() throws for $exampleName', () {
          expect(() => EmailAddress.parse(rawAddress),
              throwsA(isA<EmailAddressFormatException>()));
        });
        test('.parseOrNull() returns null for $exampleName', () {
          expect(EmailAddress.parseOrNull(rawAddress), isNull);
        });
        test('.validFormat() returns false for $exampleName', () {
          expect(EmailAddress.validFormat(rawAddress), isFalse);
        });
      });
    });

    test('.toString()', () {
      final addressString = 'John@Exmaple.com';
      final addressValue = EmailAddress.parseOrNull(addressString)!;

      expect(addressValue.toString(), equals(addressString));
    });

    test('==()', () {
      final address = EmailAddress.parseOrNull('john@example.com')!;

      expect(address == address, isTrue);
      expect(address == EmailAddress.parseOrNull('john@example.com'), isTrue);

      expect(address == EmailAddress.parseOrNull('JOHN@EXAMPLE.COM'), isTrue);
      expect(EmailAddress.parseOrNull('JOHN@EXAMPLE.COM') == address, isTrue);

      expect(address == EmailAddress.parseOrNull('john@another.com'), isFalse);
      expect(
          address == EmailAddress.parseOrNull('thomas@example.com'), isFalse);
    });

    test('.hashCode', () {
      final address = EmailAddress.parseOrNull('john@example.com')!;
      final sameAddress = EmailAddress.parseOrNull('john@example.com')!;
      final sameAddressUppercase =
          EmailAddress.parseOrNull('JOHN@EXAMPLE.COM')!;

      expect(address.hashCode, equals(sameAddress.hashCode));
      expect(address.hashCode, equals(sameAddressUppercase.hashCode),
          reason: "Case should not affect hash code calculation.");
    });
  });

  // EmailAddressFormatException tests
  //----------------------------------------------------------------------------

  group('EmailAddressFormatException', () {
    test('.of() constructor', () {
      final exception = EmailAddressFormatException.of('invalid string');

      expect(exception, isA<FormatException>());
      expect(exception.message, equals('Invalid e-mail address format.'));
      expect(exception.source, equals('invalid string'));
    });
  });
}
