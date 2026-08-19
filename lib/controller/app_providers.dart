import 'package:ai_lab/core/class/crud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final crudProvider = Provider<Crud>((ref) {
  return Crud();
});


