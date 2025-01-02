package corerd.solution.bhagavad.gita

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "samples.flutter.dev/firebase"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            call, result ->
            if (call.method == "setId") {
                AdConstant.init(this, result, call.argument<String>("googleAdsId")!!)
            } else {
                result.notImplemented()
            }
        }
    }
}