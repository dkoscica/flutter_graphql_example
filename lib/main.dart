import 'package:flutter/material.dart';
import 'package:flutter_graphql_example/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

void main() {
  Loggy.initLoggy();
  runApp(const ProviderScope(child: App()));
}
