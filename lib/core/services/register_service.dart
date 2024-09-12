
import 'package:food_recipes/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';
import 'auth_service.dart';
import 'database_service.dart';
import 'media_service.dart';

final GetIt getIt = GetIt.instance;
Future<void> registerService() async {
 getIt.registerSingleton<AuthService>(
    AuthService()
  );
  getIt.registerSingleton<MediaService>(
      MediaService()
  );
  getIt.registerSingleton<StorageService>(
      StorageService()
  );
  getIt.registerSingleton<DatabaseService>(
      DatabaseService()
  );
}
