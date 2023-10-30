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

import 'package:email_address/email_address.dart';

void main() {
  // Parsing a `EmailAddress` from string:
  try {
    final address = EmailAddress.parse('john@exmaple.com');
    print('The address `$address` has been parsed.');
  } on EmailAddressFormatException {
    print('Parsing error!');
  }

  // Alternatively, you can use `.parseOrNull()`:
  {
    assert(EmailAddress.parseOrNull('john@exmaple.com') != null);
    assert(EmailAddress.parseOrNull('not a e-mail address') == null);
  }

  // When you need to, just check the format of the string without creating
  // an instance of the `EmailAddress`:
  {
    assert(EmailAddress.validFormat('john@example.com') == true);
    assert(EmailAddress.validFormat('not a e-mail address') == false);
  }

  // Make case-insensitive check for equality of the addresses:
  {
    final address = EmailAddress.parse('john@example.com');
    final sameAddressInUpperCase = EmailAddress.parse('JOHN@EXAMPLE.COM');

    assert(address == sameAddressInUpperCase);
  }

  // Convert the `EmailAddress` back to string using `.toString()` method as expected:
  {
    final address = EmailAddress.parse('JohnDoe@example.com');
    assert('JohnDoe@example.com' == address.toString());
  }
}
