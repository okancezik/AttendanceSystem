import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

class TranslationsHelper {
  final StreamController<String> _controller = StreamController.broadcast();
  Stream<String> get stream => _controller.stream;
  Sink get _sink => _controller.sink;

  TranslationsHelper() {
    _sink.add("tr");
  }

  void handleTranslationTr(context) {
    _sink.add("tr");
    EasyLocalization.of(context)!.setLocale(Locale("tr", "TR"));
  }

  void handleTranslationEn(context) {
    _sink.add("en");
    EasyLocalization.of(context)!.setLocale(Locale("en", "US"));
  }
}
