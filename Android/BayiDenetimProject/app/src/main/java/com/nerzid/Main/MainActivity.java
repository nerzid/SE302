package com.nerzid.Main;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.database.Cursor;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Handler;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.VideoView;
import com.nerzid.Database.DBAdapter;
import com.nerzid.Network.ReceiveForms;
import com.nerzid.Network.SendForms;


public class MainActivity extends ActionBarActivity {

    private VideoView background_Videoview;

    private Button answer1Btn;
    private Button answer2Btn;
    private Button answer3Btn;

    public ProgressBar loadingFormsPB;
    public ProgressDialog progressDialog;
    public Handler updateBarHandler;

    private TextView questionTxtView;

    DBAdapter database;
    ReceiveForms receiveForms;

    private int iterator;

    private int form_no;
    private String form_name;
    private String question;
    private String answer_1;
    private String answer_2;
    private String answer_3;
    private int answer_1_count;
    private int answer_2_count;
    private int answer_3_count;

    private boolean isReceiveFormFinished;

    private boolean isfirstFormSet;

    Cursor cursor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        background_Videoview = (VideoView) findViewById(R.id.backgroundVideoView);

        answer1Btn = (Button) findViewById(R.id.answer1);
        answer2Btn = (Button) findViewById(R.id.answer2);
        answer3Btn = (Button) findViewById(R.id.answer3);

        questionTxtView = (TextView) findViewById(R.id.question);

        iterator = 0;//This will be used to get data row by row

        question = "";
        answer_1 = "";
        answer_2 = "";
        answer_3 = "";

        Uri adres = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.tempolu);
        background_Videoview.setVideoURI(adres);
        background_Videoview.start();

        isfirstFormSet = false;
        isReceiveFormFinished = false;

        openDB();

        launchRingDialog();

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        closeDB();
    }

    private void gatherForms()
    {
        receiveForms = new ReceiveForms(database);
        receiveForms.execute();
    }

    private void openDB()
    {
        database = new DBAdapter(this);
        database.open();
        gatherForms();

    }

    private void setViews()
    {
        questionTxtView.setText(question);
        answer1Btn.setText(answer_1);
        answer2Btn.setText(answer_2);
        answer3Btn.setText(answer_3);
    }

    private void setCurrentFormVariables()
    {
        int row_id = cursor.getInt(DBAdapter.COL_ROWID);
        form_no = cursor.getInt(DBAdapter.COL_FORM_NO);
        form_name = cursor.getString(DBAdapter.COL_FORM_NAME);
        question = cursor.getString(DBAdapter.COL_QUESTION_NAME);
        answer_1 = cursor.getString(DBAdapter.COL_ANSWER_1);
        answer_2 = cursor.getString(DBAdapter.COL_ANSWER_2);
        answer_3 = cursor.getString(DBAdapter.COL_ANSWER_3);
        answer_1_count = cursor.getInt(DBAdapter.COL_ANSWER_1_COUNT);
        answer_2_count = cursor.getInt(DBAdapter.COL_ANSWER_2_COUNT);
        answer_3_count = cursor.getInt(DBAdapter.COL_ANSWER_3_COUNT);

        System.out.println("RowID: " + row_id + " Question: " + question + " Ans1_Count: " + answer_1_count + " Ans2_Count: " + answer_2_count + " Ans3_Count: " + answer_3_count);
    }

    private void startDisplaying()
    {
        cursor = database.getAllRows();
        //System.out.println("DATABASE 1. ROW "+database.getRowByRowID(1).getString(DBAdapter.COL_QUESTION_NAME));

        if(!cursor.moveToFirst())
        {
            // 1. Instantiate an AlertDialog.Builder with its constructor
            AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);

            // 2. Chain together various setter methods to set the dialog characteristics
            builder.setMessage(R.string.dialog_formError_message)
                    .setTitle(R.string.dialog_formError_title);

            // 3. Get the AlertDialog from create()
            AlertDialog dialog = builder.create();
            dialog.show();
        }
        else
        {
            updateDisplay();
        }
    }

    private void displayNextForm()
    {
        if(cursor.moveToNext())
        {
            setCurrentFormVariables();
            setViews();
        }
        else
        {
            if(!cursor.moveToFirst())
            {
                // 1. Instantiate an AlertDialog.Builder with its constructor
                AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);

                // 2. Chain together various setter methods to set the dialog characteristics
                builder.setMessage(R.string.dialog_formError_message)
                        .setTitle(R.string.dialog_formError_title);

                // 3. Get the AlertDialog from create()
                AlertDialog dialog = builder.create();
                dialog.show();
            }
            else
            {

                setCurrentFormVariables();
                setViews();
            }
        }
    }

    private void updateDisplay()
    {
        if(!isfirstFormSet)
        {
            setCurrentFormVariables();
            setViews();
            isfirstFormSet = true;
        }
        else
        {
            displayNextForm();
        }
    }

    private void closeDB()
    {
        database.close();
    }

    private void sendForms()
    {
        SendForms sendForms = new SendForms(database,form_no,answer_3_count,answer_2_count,answer_1_count,answer_3,answer_2,answer_1,question,form_name);
        sendForms.execute();

        progressDialog = new ProgressDialog(this);

        progressDialog.setTitle(getApplicationContext().getResources().getString(R.string.dialog_loadingProgressSending_title));
        progressDialog.setMessage(getApplicationContext().getResources().getString(R.string.dialog_loadingProgress_message));
        progressDialog.show();

        AsyncTask<String, String, String> task = new AsyncTask<String, String, String>() {
            @Override
            protected String doInBackground(String... params) {
                while(!SendForms.isJsonConnected && !SendForms.isErrorOccured){

                }

                if(SendForms.isJsonConnected)
                    publishProgress(getApplicationContext().getResources().getString(R.string.dialog_loadingProgressSendingJsonConnection_message));
                if(SendForms.isErrorOccured)
                    onPostExecute("error");

                while(!SendForms.isSendingCompleted && !SendForms.isErrorOccured)
                {

                }

                if(SendForms.isSendingSuccesful)
                    onPostExecute("success");
                else
                    onPostExecute("fail");
                return null;
            }
            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
/*
                if(s.equals("error"))
                    createAlertDialog(R.string.dialog_loadingProgressSendingError_message, R.string.dialog_loadingProgressSendingError_title);
                else if(s.equals("success"))
                    createAlertDialog(R.string.dialog_loadingProgressSendingSucess_message, R.string.dialog_loadingProgressSendingCompeleted_title);
                else if(s.equals("fail"))
                    createAlertDialog(R.string.dialog_loadingProgressSendingFail_message, R.string.dialog_loadingProgressSendingCompeleted_title);
*/
                progressDialog.dismiss();
            }

            @Override
            protected void onProgressUpdate(String... values) {
                super.onProgressUpdate(values);
                progressDialog.setMessage(values[0]);
            }
        };
        task.execute();


    }

    public void createAlertDialog(int messageId, int titleId)
    {
        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);

        // 2. Chain together various setter methods to set the dialog characteristics
        builder.setMessage(messageId)
                .setTitle(titleId);

        // 3. Get the AlertDialog from create()
        AlertDialog dialog = builder.create();
        dialog.show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
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

    public void onClick_Answer1(View view)
    {
        answer_1_count++;
        int pos = cursor.getPosition();
        cursor.close();
        database.updateRow(form_no, form_name, question, answer_1, answer_2, answer_3, answer_1_count, answer_2_count, answer_3_count);
        cursor = database.getAllRows();
        cursor.moveToPosition(pos);
        sendForms();
        displayNextForm();
    }
    public void onClick_Answer2(View view){
        answer_2_count++;
        int pos = cursor.getPosition();
        cursor.close();
        database.updateRow(form_no, form_name, question, answer_1, answer_2, answer_3, answer_1_count, answer_2_count, answer_3_count);
        cursor = database.getAllRows();
        cursor.moveToPosition(pos);
        sendForms();
        displayNextForm();
    }
    public void onClick_Answer3(View view){
        answer_3_count++;
        int pos = cursor.getPosition();
        cursor.close();
        database.updateRow(form_no,form_name,question,answer_1,answer_2,answer_3,answer_1_count,answer_2_count,answer_3_count);
        cursor = database.getAllRows();
        cursor.moveToPosition(pos);
        sendForms();
        displayNextForm();
    }

    public void launchProgressBarDialog()
    {
        progressDialog = new ProgressDialog(this);

        progressDialog.setTitle(getApplicationContext().getResources().getString(R.string.dialog_loadingProgress_title));
        progressDialog.setMessage(getApplicationContext().getResources().getString(R.string.dialog_loadingProgress_message));

        progressDialog.setProgressStyle(progressDialog.STYLE_HORIZONTAL);
        progressDialog.setProgress(0);
        progressDialog.setMax(ReceiveForms.json_Count);
        progressDialog.show();

        System.out.println("JSON  COUNT: " + progressDialog.getMax());

        updateBarHandler = new Handler();

        final int increment = 1;

        int json_index;
        AsyncTask<String,Integer,String> task = new AsyncTask<String, Integer, String>() {
            @Override
            protected String doInBackground(String... params) {
                int tmp = 1;
                while(progressDialog.getProgress() <= progressDialog.getMax() && !ReceiveForms.jsonCompleted)
                {
                    System.out.println("json:index:" + ReceiveForms.json_index);
                    if(ReceiveForms.json_index != tmp)
                    {
                        publishProgress(ReceiveForms.json_index);
                        tmp = ReceiveForms.json_index;
                        System.out.println("**********PROGRESS VALUE : " + String.valueOf(ReceiveForms.json_index));
                        System.out.println("----------PROGRESS PROGRESS: " + progressDialog.getProgress());
                    }
                }
                return null;
            }

            @Override
            protected void onProgressUpdate(Integer... values) {
                super.onProgressUpdate(values);
                progressDialog.setProgress(values[0]);
            }
            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                progressDialog.dismiss();
                startDisplaying();
            }
        };
        task.execute();
    }

    public void launchRingDialog()
    {
        progressDialog = ProgressDialog.show(this, "Connecting Json", "Please Wait...", true);
        progressDialog.setCancelable(false);

        AsyncTask<String, String, String> task = new AsyncTask<String, String, String>() {
            @Override
            protected String doInBackground(String... params) {
                while(!ReceiveForms.jsonConnected){
                }
                return null;
            }
            @Override
            protected void onPostExecute(String s) {
                super.onPostExecute(s);
                progressDialog.dismiss();
                launchProgressBarDialog();
            }
        };
        task.execute();
    }
}
