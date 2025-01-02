package corerd.solution.bhagavad.gita

import android.content.Context
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodChannel

object AdConstant {

    fun init(context: Context, result: MethodChannel.Result,adsId:String) {

        val applicationInfo = context.packageManager.getApplicationInfo(
                context.packageName, PackageManager.GET_META_DATA
        )
        val bundle = applicationInfo.metaData

        try {
            println("Old Id IS" +bundle.getString("com.google.android.gms.ads.APPLICATION_ID"))
            applicationInfo.metaData.putString("com.google.android.gms.ads.APPLICATION_ID", adsId)
            println("New Id IS" +bundle.getString("com.google.android.gms.ads.APPLICATION_ID"))
            result.success("Success")

        }catch (e: Exception) {
            println(e)
            result.error("UNAVAILABLE", "Some thing Went Worng", null)
        }

    }

}