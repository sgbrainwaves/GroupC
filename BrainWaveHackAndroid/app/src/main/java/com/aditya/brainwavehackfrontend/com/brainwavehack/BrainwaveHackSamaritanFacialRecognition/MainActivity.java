package com.aditya.brainwavehackfrontend.com.brainwavehack.BrainwaveHackSamaritanFacialRecognition;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.StrictMode;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.Toast;

import com.aditya.brainwavehackfrontend.R;
import com.aditya.brainwavehackfrontend.com.brainwavehack.BrainWaveHackSamaritanSpeechRecognition.CompleteAutomaticSpeechRecognition;
import com.aditya.brainwavehackfrontend.com.brainwavehack.BrainWaveHackSamaritanSpeechRecognition.GoogleVoiceAPI;
import com.aditya.brainwavehackfrontend.com.brainwavehack.BrainWaveHackSamaritanSpeechRecognition.TextToSpeechActivity;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * This is the file which is the first activity that loads up in android application
 */

public class MainActivity extends ActionBarActivity {

    private ProgressBar progressBar;
    private ProgressDialog pDialog;

    private static final String url = "http://splitmoney.site50.net/inset_file_data.php";

    private Button okButton;
    private EditText etText;
    private String textQuery;
    private final String errorMessage = "Please enter a valid query";
    private final String exceptionQuery = "Cannot connect to the database. Please check your network" +
            " and try again.";
    private final String successMessage = "Data has been entered successfully into the database";
    private InputStream is = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        StrictMode.ThreadPolicy threadPolicy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(threadPolicy);

        okButton = (Button) findViewById(R.id.buttonOK);
        etText = (EditText) findViewById(R.id.etText);

        okButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new InsertTask().execute();
            }
        });
    }

    /**Implementing the Insert Task Progress Bar
     * @return
     */

    private class InsertTask extends AsyncTask<Void, Void, Void>{

        @Override
        protected void onPreExecute() {
            pDialog = new ProgressDialog(MainActivity.this);
            pDialog.setTitle("Inserting data into the database");
            pDialog.setMessage("Please wait..");
            pDialog.show();
            pDialog.setCancelable(false);
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            pDialog.dismiss();
            Toast.makeText(MainActivity.this, successMessage, Toast.LENGTH_SHORT).show();
            etText.setText("");
            Toast.makeText(MainActivity.this, successMessage, Toast.LENGTH_SHORT).show();
        }

        @Override
        protected Void doInBackground(Void... params) {

                    if(etText.getText().toString().equals("")){
                        Toast.makeText(MainActivity.this, errorMessage, Toast.LENGTH_SHORT).show();
                    }
                    else{

                        textQuery = etText.getText().toString();
                        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
                        nameValuePairs.add(new BasicNameValuePair("textQuery", textQuery));

                        try{
                            HttpClient httpClient = new DefaultHttpClient();
                            HttpPost httpPost = new HttpPost(url);
                            httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
                            HttpResponse response = httpClient.execute(httpPost);
                            HttpEntity entity = response.getEntity();
                            is = entity.getContent();

                        }catch(ClientProtocolException e){
                            Toast.makeText(MainActivity.this, exceptionQuery, Toast.LENGTH_SHORT).show();
                        }catch(IOException e){
                            Toast.makeText(MainActivity.this, exceptionQuery, Toast.LENGTH_SHORT).show();
                        }
                    }
            return null;
        }
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

        else if(id == R.id.action_imageUpload){
            Intent it = new Intent(MainActivity.this, ImageActivity.class);
            startActivity(it);
        }

        else if (id == R.id.action_complete_voice_recognition){
            Intent it = new Intent(MainActivity.this, CompleteAutomaticSpeechRecognition.class);
            startActivity(it);
        }

        return super.onOptionsItemSelected(item);
    }
}
