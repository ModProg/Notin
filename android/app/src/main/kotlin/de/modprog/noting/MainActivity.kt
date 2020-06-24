package de.modprog.noting

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import androidx.annotation.NonNull
import be.tarsos.dsp.AudioProcessor
import be.tarsos.dsp.io.android.AudioDispatcherFactory
import be.tarsos.dsp.pitch.PitchDetectionHandler
import be.tarsos.dsp.pitch.PitchProcessor
import be.tarsos.dsp.pitch.PitchProcessor.PitchEstimationAlgorithm
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    // private val channel = "samples.flutter.dev/battery"
    // private var pitch=1F
    // private var audioThread: Thread? = null;

    // private val RECORDER_SAMPLERATE = 8000
    // private val RECORDER_CHANNELS: Int = android.media.AudioFormat.CHANNEL_IN_MONO
    // private val RECORDER_AUDIO_ENCODING: Int = android.media.AudioFormat.ENCODING_PCM_16BIT
    // override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    //     super.configureFlutterEngine(flutterEngine)
    //     val bufferSize = AudioRecord.getMinBufferSize(RECORDER_SAMPLERATE,
    //             RECORDER_CHANNELS, RECORDER_AUDIO_ENCODING)
    //     val test = AudioRecord(MediaRecorder.AudioSource.MIC,        RECORDER_SAMPLERATE, RECORDER_CHANNELS,        RECORDER_AUDIO_ENCODING, 1024*2)
    //     test.startRecording()
    //     print(test)
    //     val dispatcher = AudioDispatcherFactory.fromDefaultMicrophone(8000, 1024, 0)
    //     print(dispatcher)
    //     val pdh = PitchDetectionHandler { res, _ ->
    //         pitch = res.pitch
    //     }
    //     val pitchProcessor: AudioProcessor = PitchProcessor(PitchEstimationAlgorithm.FFT_YIN, 22050F, 1024, pdh)
    //     dispatcher.addAudioProcessor(pitchProcessor)

    //     audioThread = Thread(dispatcher, "Audio Thread")
    //     audioThread?.start()
    //     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
    //         when (call.method) {
    //             "getBatteryLevel" -> {
    //                 val batteryLevel = getBatteryLevel()

    //                 if (batteryLevel != -1) {
    //                     result.success(batteryLevel)
    //                 } else {
    //                     result.error("UNAVAILABLE", "Battery level not available.", null)
    //                 }
    //             }
    //             "getPitch" -> {
    //                 getPitch(result)
    //             }
    //         }
    //     }
    // }

    // private fun getBatteryLevel(): Int {
    //     val batteryLevel: Int
    //     batteryLevel = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
    //         val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    //         batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    //     } else {
    //         val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    //         intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    //     }

    //     return batteryLevel
    // }

    // private fun getPitch(result: MethodChannel.Result) {
    //     result.success(pitch)
    // }


}
