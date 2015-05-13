package com.nerzid;

import android.app.Application;
import android.content.Context;

/**
 * Created by nerzid on 13.5.2015.
 */
public class MyApplication extends Application{
    private static Context context;

    @Override
    public void onCreate() {
        super.onCreate();
        MyApplication.context = getApplicationContext();
    }

    public static Context getAppContext(){
        return MyApplication.context;
    }
}
