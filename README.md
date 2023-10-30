This package provides the value type [EmailAddress] to have a typed
representation of the e-mail address with the encapsulated validation.

## Getting started

1. Install the package as a dependency, running the command in the shell:

    ```sh
    dart pub add email_address
    ```

2. Import the library:

    ```dart
   import 'package:email_address/email_address.dart';
    ```

## Usage

Parsing a `EmailAddress` from string:

```dart
try {
  final address = EmailAddress.parse('john@exmaple.com');
} on EmailAddressFormatException {
  // ...
}
```

Alternatively, you can use `.parseOrNull()`:

```dart
assert(EmailAddress.parseOrNull('john@exmaple.com') != null);
assert(EmailAddress.parseOrNull('not a e-mail address') == null);
```

When you need to, just check the format of the string without creating
an instance of the `EmailAddress`:

```dart
assert(EmailAddress.validFormat('john@example.com') == true);
assert(EmailAddress.validFormat('not a e-mail address') == false);
```

Make case-insensitive check for equality of the addresses:

```dart
final address = EmailAddress.parse('john@example.com');
final sameAddressInUpperCase = EmailAddress.parse('JOHN@EXAMPLE.COM');

assert(address == sameAddressInUpperCase);
```

Convert the `EmailAddress` back to string using `.toString()` method as expected:

```dart
final address = EmailAddress.parse('JohnDoe@example.com');
assert('JohnDoe@example.com' == address.toString());
```
