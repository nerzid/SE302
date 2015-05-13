package com.nerzid.Network;

import android.annotation.TargetApi;
import android.app.Application;
import android.content.Context;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Build;

import com.nerzid.Database.DBAdapter;
import com.nerzid.Database.JSONParser;
import com.nerzid.Main.MainActivity;
import com.nerzid.credentials.TabletCredentials;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by nerzid on 2.5.2015.
 */
public class ReceiveForms extends AsyncTask<String,String,String>{

    JSONObject jsonObject;
    JSONArray jsonArray;
    JSONParser jsonParser;
    DBAdapter database;
    Cursor cursor;

    public static int json_Count = 1;
    public static int json_index = 1;//This will be used for Loading ProgressBar MainActivity
    public static boolean jsonConnected;
    public static boolean jsonCompleted;

    ArrayList<String> answerList;

    String url_receiveForm = "http://bayidenetimproject-se302.rhcloud.com/SendForms";

    public ReceiveForms(DBAdapter database)
    {
        this.database = database;
        jsonConnected = false;
        jsonCompleted = false;
    }

    @Override
    protected String doInBackground(String... args) {

        jsonObject = new JSONObject();
        jsonArray = new JSONArray();
        jsonParser = new JSONParser();


        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("dTabletKey", TabletCredentials.TabletKey));
        jsonArray = jsonParser.getJSONFromUrl(url_receiveForm+"?dTabletKey=" + TabletCredentials.TabletKey);
        //System.out.println(jsonObject.toString());


        try {


            json_Count = jsonArray.length();
            jsonConnected = true;
            System.out.println(jsonArray.toString());
            System.out.println("JSONARRAY SIZE: " + json_Count);
            for(int i = 0; i < json_Count; i++)
            {
                json_index = i+1;

                JSONObject jArrObj = jsonArray.getJSONObject(i);

                System.out.println("JARR OBJECT" + jArrObj.toString());

                int formID = jArrObj.getInt("fID");

                answerList  = new ArrayList<>();


                String fName = jArrObj.getString("fName");

                if(jArrObj.has("qText"))
                {
                    String question = jArrObj.getString("qText");
                    System.out.println("QUESTION: " + question);
                    if(database.isQuestionExist(formID,question)) {
                        System.out.println("THIS EXISTS!");
                        continue;
                    }

                    int answer_count = 1;

                    answerList = new ArrayList<>();
                    while(jArrObj.has("aText" + answer_count))
                    {
                        String answer = jArrObj.getString("aText" + answer_count++);

                        answerList.add(answer);
                    }
                    System.out.println("Insert Ediliyor --> Fname: " + fName + " fID: " + formID + " qText: " + question + answerList.toString());

                    //INSERT FORMS TO DATABASE HERE
                    long id = database.insertRow(fName,formID,question,answerList.get(0),answerList.get(1), answerList.get(2), 0, 0, 0);

                    System.out.println("ROW ID: " + id);
                }
            }

        } catch (JSONException e) {
            System.out.println("JSON EXCEPTION:" + e.getMessage());
            e.printStackTrace();
        } catch(NullPointerException e){
            System.out.println("NULLPOINTER EXCEPTION:" + e.getMessage());
            e.printStackTrace();
        }finally {
            jsonCompleted = true;
        }
        return null;
    }
}
