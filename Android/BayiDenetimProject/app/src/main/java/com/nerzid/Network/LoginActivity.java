package com.nerzid.Network;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.nerzid.Database.JSONParser;
import com.nerzid.Main.MainActivity;
import com.nerzid.Main.R;
import com.nerzid.credentials.TabletCredentials;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class LoginActivity extends ActionBarActivity {

    EditText tabletKeyET;
    EditText tabletPassET;
    Button loginBtn;

    String tabletKey;
    String tabletPass;

    JSONParser jParser = new JSONParser();

    JSONObject json;
    private static String url_login = "http://bayidenetimproject-se302.rhcloud.com/TabletAuthentication";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        findViewById();//Set All views;

        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(isNetworkAvailable())
                {
                    tabletKey = tabletKeyET.getText().toString();
                    tabletPass = tabletPassET.getText().toString();
                    new Login().execute();
                }
                else
                {
                    Context context = getApplicationContext();
                    CharSequence text = "Check Your Internet Connection";
                    int duration = Toast.LENGTH_SHORT;

                    Toast toast = Toast.makeText(context, text, duration);
                    toast.show();
                }
            }
        });
    }

    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) getSystemService(getApplicationContext().CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }

    private void findViewById(){
        tabletKeyET = (EditText) findViewById(R.id.dTabletKeyET);
        tabletPassET = (EditText) findViewById(R.id.dTabletPassET);
        loginBtn = (Button) findViewById(R.id.loginBtn);
    }


    private class Login extends AsyncTask<String, String, String> {

        String message = "";
        @Override
        protected String doInBackground(String... args) {

            List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("dTabletKey",tabletKey));
            params.add(new BasicNameValuePair("dTabletPass",tabletPass));
            json = jParser.makeHttpRequest(url_login, "GET", params);
            System.out.println(json.toString());

            try {
                message = json.getString("message");


            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch(NullPointerException e){
                e.printStackTrace();
            }

            return null;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            if(message.equals("success"))
            {
                loginsuccess();
            }
            else
            {
                loginfail();;
            }
        }
    }

    private void loginsuccess()
    {
        Intent goMainActivity = new Intent(this, MainActivity.class);
        TabletCredentials.TabletKey = tabletKey;
        startActivity(goMainActivity);
    }

    private void loginfail()
    {
        // 1. Instantiate an AlertDialog.Builder with its constructor
        AlertDialog.Builder builder = new AlertDialog.Builder(LoginActivity.this);

        // 2. Chain together various setter methods to set the dialog characteristics
        builder.setMessage(R.string.dialog_message)
                .setTitle(R.string.dialog_title);

        // 3. Get the AlertDialog from create()
        AlertDialog dialog = builder.create();
        dialog.show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_login, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
