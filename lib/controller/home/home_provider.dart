
import 'package:ai_lab/controller/app_providers.dart';
import 'package:ai_lab/controller/home/home_controller.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/data/remote/home/home_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = NotifierProvider<HomeController, HomeState>(
  HomeController.new,
);


final homeDataProvider = Provider<HomeData>((ref) {
  return HomeData(crud: ref.watch(crudProvider));
});

