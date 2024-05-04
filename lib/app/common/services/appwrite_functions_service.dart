import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_functions_service.g.dart';

@riverpod
AppwriteFunctionsService appwriteFunctionsService(
    AppwriteFunctionsServiceRef ref) {
  return AppwriteFunctionsService(ref);
}

class AppwriteFunctionsService {
  final Ref ref;
  AppwriteFunctionsService(this.ref);

  void init() {}
}
