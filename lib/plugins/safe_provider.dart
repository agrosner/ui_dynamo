import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SafeProvider {
  static T of<T>(BuildContext context) {
    try {
      return Provider.of<T>(context);
    } on ProviderNotFoundException {
      /// ignored error
      return null;
    }
  }
}
