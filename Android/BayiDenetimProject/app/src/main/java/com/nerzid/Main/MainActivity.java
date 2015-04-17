package com.nerzid.Main;

import android.database.Cursor;
import android.net.Uri;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.VideoView;
import com.nerzid.Database.DBAdapter;


public class MainActivity extends ActionBarActivity {

    private VideoView background_Videoview;

    private Button answer1Btn;
    private Button answer2Btn;
    private Button answer3Btn;

    private TextView questionTxtView;

    DBAdapter database;

    private int iterator;

    private String question;
    private String answer_1;
    private String answer_2;
    private String answer_3;

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

        openDB();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        closeDB();
    }

    private void openDB()
    {
        database = new DBAdapter(this);
        database.open();

        cursor = database.getAllRows();
        //database.insertRow("ilk form", 0, "Bu soru böyle mi sorulur ?", "KaçYaşındayımkiben", "BenSoruyomuyumSana", "KiminleNapıyosunDiye");

        if(cursor.moveToFirst())
        {
            question = cursor.getString(DBAdapter.COL_QUESTION_NAME);
            answer_1 = cursor.getString(DBAdapter.COL_ANSWER_1);
            answer_2 = cursor.getString(DBAdapter.COL_ANSWER_2);
            answer_3 = cursor.getString(DBAdapter.COL_ANSWER_3);
        }

        updateDisplay();
    }

    private void updateDisplay()
    {
        questionTxtView.setText(question);
        answer1Btn.setText(answer_1);
        answer2Btn.setText(answer_2);
        answer3Btn.setText(answer_3);
    }

    private void closeDB()
    {
        database.close();
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

    public void onClick_Answer1(View view){
        answer1Btn.setText("ZAA");
    }
    public void onClick_Answer2(View view){

    }
    public void onClick_Answer3(View view){

    }
}
