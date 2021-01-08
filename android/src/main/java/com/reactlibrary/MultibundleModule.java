package com.reactlibrary;

import com.facebook.react.bridge.CatalystInstance;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

import java.io.File;

public class MultibundleModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public MultibundleModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "Multibundle";
    }

    @ReactMethod
    public void loadBundle(String bundleName, int bundleId, Promise promise) {

        try {
            File file =  reactContext.getApplicationContext().getExternalFilesDir(null);
            CatalystInstance catalystInstance = this.reactContext.getCatalystInstance();
            String path = file.getAbsolutePath() + "/bundle/";
            //"assets://"
//            catalystInstance.loadScriptFromAssets(
//              this.reactContext.getAssets(),
//                    path+ bundleName + ".android.bundle",
//              bundleId,
//              false);

            catalystInstance.loadScriptFromFile( path+ bundleName + ".android.bundle", "",
                    bundleId,
                    false);
            promise.resolve(null);
        } catch(Exception e) {
            promise.reject(e);
        }

    }
}
