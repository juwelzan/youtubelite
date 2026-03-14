import 'package:get_it/get_it.dart';
import 'package:youtubelite/feature/home/service/youtube_service.dart';

final sl = GetIt.instance;

class DependencyInjection {
  static void init() async {
    sl.registerLazySingleton<YoutubeService>(() => YoutubeService());
  }
}
