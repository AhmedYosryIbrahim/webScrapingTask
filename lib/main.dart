import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:web_scraping_task/app.dart';
import 'package:web_scraping_task/config/themes/app_theme.dart';
import 'core/utils/bloc_observer.dart';
import 'injector.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const WebScrapingApp());
}