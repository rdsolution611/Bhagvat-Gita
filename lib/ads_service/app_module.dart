import 'package:testingnew/ads_service/ad_services.dart';
import 'package:testingnew/main.dart';

void setUp() {
  getIt.registerSingleton<AdService>(AdService());
}
