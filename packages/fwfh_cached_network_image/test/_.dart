import 'dart:convert';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/test/_.dart' as helper;

const kDataUri = helper.kDataUri;

String? cachedNetworkImageExplainer(helper.Explainer parent, Widget widget) {
  if (widget is FastCachedImage) {
    return '[CachedNetworkImage:imageUrl=${widget.url}]';
  }

  return null;
}

Future<String> explain(
  WidgetTester tester,
  String html, {
  bool useExplainer = true,
}) async {
  await helper.explain(
    tester,
    null,
    explainer: cachedNetworkImageExplainer,
    hw: HtmlWidget(
      html,
      key: helper.hwKey,
      factoryBuilder: () => _WidgetFactory(),
    ),
    useExplainer: useExplainer,
  );

  await tester.pump(const Duration(milliseconds: 3));
  await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 10)));
  await tester.pump();

  return helper.explainWithoutPumping(
    explainer: cachedNetworkImageExplainer,
    useExplainer: useExplainer,
  );
}


class _WidgetFactory extends WidgetFactory with CachedNetworkImageFactory {

}
