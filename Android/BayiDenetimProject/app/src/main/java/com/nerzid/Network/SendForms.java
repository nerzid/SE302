package com.nerzid.Network;

import android.os.AsyncTask;

import com.nerzid.Database.DBAdapter;
import com.nerzid.Database.JSONParser;
import com.nerzid.credentials.TabletCredentials;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by nerzid on 2.5.2015.
 */
public class SendForms extends AsyncTask<String,String,String>{

    String url_sendForm = "http://bayidenetimproject-se302.rhcloud.com/ReceiveForms";

    DBAdapter database;
    JSONObject jsonObject;
    JSONParser jsonParser;

    public static boolean isJsonConnected;
    public static boolean isSendingCompleted;
    public static boolean isSendingSuccesful;
    public static boolean isErrorOccured;

    int formNo;
    String form_name;
    String question_name;
    String aText1;
    String aText2;
    String aText3;

    int aCount1;
    int aCount2;
    int aCount3;

    public SendForms(DBAdapter database, int formNo, int aCount3, int aCount2, int aCount1, String aText3, String aText2, String aText1, String question_name, String form_name) {
        this.database = database;
        this.formNo = formNo;
        this.aCount3 = aCount3;
        this.aCount2 = aCount2;
        this.aCount1 = aCount1;
        this.aText3 = aText3;
        this.aText2 = aText2;
        this.aText1 = aText1;
        this.question_name = question_name;
        this.form_name = form_name;

        isJsonConnected = false;
        isSendingCompleted = false;
        isSendingSuccesful = false;
        isErrorOccured = false;
    }

    @Override
    protected String doInBackground(String... args) {

        jsonObject = new JSONObject();
        jsonParser = new JSONParser();


        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("dTabletKey", TabletCredentials.TabletKey));
        params.add(new BasicNameValuePair("formNo", String.valueOf(formNo)));

        params.add(new BasicNameValuePair("qText", question_name));
        params.add(new BasicNameValuePair("aText1", aText1));
        params.add(new BasicNameValuePair("aText2", aText2));
        params.add(new BasicNameValuePair("aText3", aText3));

        params.add(new BasicNameValuePair("aCount1", String.valueOf(aCount1)));
        params.add(new BasicNameValuePair("aCount2", String.valueOf(aCount2)));
        params.add(new BasicNameValuePair("aCount3", String.valueOf(aCount3)));



        jsonObject = jsonParser.makeHttpRequest(url_sendForm,"POST", params);
        //System.out.println(jsonObject.toString());

        try {
            String message = jsonObject.getString("message");

            isJsonConnected = true;

            System.out.println("Message: " + message);

            if(jsonObject.has("message2"))
                System.out.println("Message2: " + jsonObject.getString("message2"));

            if(message.contains("success"))
            {
                database.updateRow(formNo,form_name,question_name,aText1,aText2,aText3,0,0,0);//Making aCounts'to zero again
                isSendingSuccesful = true;
            }
            else if(message.contains("fail"))
            {
                System.out.println("COULDNT SEND FORM PROPERLY");
                isSendingSuccesful = false;
            }
            else
            {
                System.out.println("EMPTY JSON");
                isSendingSuccesful = false;
            }

            if(jsonObject.has("error"))
                System.out.println(jsonObject.getString("error"));

        } catch (JSONException e) {
            e.printStackTrace();
            isErrorOccured = true;
        }
        return null;
    }

    @Override
    protected void onPostExecute(String s) {
        super.onPostExecute(s);
        isSendingCompleted = true;
    }
}
