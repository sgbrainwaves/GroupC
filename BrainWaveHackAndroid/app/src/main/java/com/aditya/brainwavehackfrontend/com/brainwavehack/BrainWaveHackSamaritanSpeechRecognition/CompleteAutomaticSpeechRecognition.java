package com.aditya.brainwavehackfrontend.com.brainwavehack.BrainWaveHackSamaritanSpeechRecognition;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.speech.RecognizerIntent;
import android.speech.tts.TextToSpeech;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.aditya.brainwavehackfrontend.R;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;

/**
 * This is the complete application to provide a complete interface to speech recognition
 * and speaking using the Google API for voice recognition and speaking.
 * Modeling an interactive session by providing user speech recognition as input and the google
 * call back as output.
 * The input for the speech should now to be taken from what has been returned from the database
 *
 * Should get the value of acc_no from the class that is returned by the comparison of the images with the server
 */

public class CompleteAutomaticSpeechRecognition extends ActionBarActivity
        implements TextToSpeech.OnInitListener {

    private ListView listView;

    // Variables to be used inside the post and get requests
    private String line = "";
    private String result = "";

    ImageView imgMike;

    // Here the static ip address and the url of the php file
    private static final String static_ip = "http://192.168.43.204";
    private static final String url = static_ip+"/cgi-bin/intellkiosk/doQuery.cgi";

    private InputStream is = null;

    // account number, to be changed later
    private static final int acc_no = 1;

    private static final int SPEECH_REQUEST_CODE = 0;

    // declaring the exception string to be printed during catch
    private static final String exceptionString = "Cannot connect to server. Please check your network and try again.";

    // ListView for displaying all the queries in the form of the list
    private ListView listViewQueries;
    private TextToSpeech tts; // The textToSpeech Object

    // Used for determining the language of speaking or the locale of speaking
    private static final Locale loc = Locale.US;

    String spokenText;
    String new_url;

    // private TextView tvUrl;
    private String[] queries = {"1. Tell my Balance", "2. Show my last transaction",
            "3. Change my phone number", "4. Change my Email Address", "5. Print my mini statement"};

    // Exception messages
    private static final String exceptionMessage = "Cannot connect to Google Servers. Please check" +
            " your Network and try again.";
    private static final String initializationFailedMessage = "Initialization has failed. Please " +
            "check your Network is properly configured";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_complete_automatic_speech_recognition);

        //tvUrl = (TextView) findViewById(R.id.textView1);

        imgMike = (ImageView) findViewById(R.id.mikemike);

        tts = new TextToSpeech(this, this);
        listViewQueries= (ListView) findViewById(R.id.listViewQueries1);
        listViewQueries.setAdapter(new ArrayAdapter<String>(CompleteAutomaticSpeechRecognition.this,
                android.R.layout.simple_list_item_1, queries));


        // Create an intent that can the start the Speech Recognizer activity
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        //Start the activity, the intent will be populated with the speech text
        startActivityForResult(intent, SPEECH_REQUEST_CODE);

        imgMike.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Create an intent that can the start the Speech Recognizer activity
                Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
                intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                        RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
                //Start the activity, the intent will be populated with the speech text
                startActivityForResult(intent, SPEECH_REQUEST_CODE);

            }
        });
    }

    // This is where we process the intent and the speech gets converted to the text


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == SPEECH_REQUEST_CODE && resultCode == RESULT_OK) {
            List<String> results = data.getStringArrayListExtra(
                    RecognizerIntent.EXTRA_RESULTS
            );
            // This is the spoken text and will be converted to the text
            spokenText = results.get(0);
            Toast.makeText(CompleteAutomaticSpeechRecognition.this, "This is the spoken text : "+spokenText, Toast.LENGTH_SHORT).show();

            /**
             * Here we make a post request, so that we can send the account number and the spokenText as input
             */
            registerResponseToServer(acc_no, spokenText);

            // Once the token has been spoken out, a response has been recorded
            // speakOut(spokenText);
        }
        super.onActivityResult(requestCode, resultCode, data);
    }


    /**
     * To implement the get and post
     * @param acc_no
     * @param spokenText
     */
    private void registerResponseToServer(int acc_no, String spokenText) {

        try{
            HttpClient httpClient = new DefaultHttpClient();

            String totally_new_url = url+"?acc="+acc_no+"&inp="+URLEncoder.encode(spokenText, "UTF-8");
            // tvUrl.setText(totally_new_url);

            HttpGet httpGet = new HttpGet(totally_new_url);
            HttpResponse response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();
            is = entity.getContent();
        }
        catch(Exception e){
            Toast.makeText(CompleteAutomaticSpeechRecognition.this, new_url, Toast.LENGTH_SHORT).show();
            Toast.makeText(CompleteAutomaticSpeechRecognition.this, "this is exception 1"+ exceptionString,
                    Toast.LENGTH_SHORT).show();
        }
        try{
            BufferedReader reader = new BufferedReader(new InputStreamReader(is, "iso-8859-1"), 8);
            StringBuilder sb = new StringBuilder();
            while((line=reader.readLine())!=null){
                sb.append(line+"\n");
            }
            result = sb.toString();
            is.close();
            // Closes the connection with the database at this point of time
            System.out.println("Successful receiving the data");
            System.out.println(result);

        }catch(Exception e){
            Toast.makeText(CompleteAutomaticSpeechRecognition.this, "Exception 2"+exceptionString,
                    Toast.LENGTH_SHORT).show();
        }/**try{
            JSONArray jsonArray = new JSONArray(result);
            int totalLength = jsonArray.length();
            for(int i=0; i<totalLength; i++){
                JSONObject json_data = jsonArray.getJSONObject(i);
                System.out.println("Value 1 : "+json_data.getString("status"));
                String status = json_data.getString("status");
                Toast.makeText(CompleteAutomaticSpeechRecognition.this, "Value :"+status, Toast.LENGTH_LONG).show();
            }
        }*/
        try{
            JSONObject json_data = new JSONObject(result);
            System.out.println("The json object is "+json_data.getString("status"));

            int status = Integer.parseInt(json_data.getString("status"));

            /**
             * if status == 0, then its a fail
             */
            if(status == 0){
                System.out.println("It's a fail");
                final String fail_msg = "Fetching data from the server has failed. Please try again.";
                speakOut(fail_msg);
                AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(CompleteAutomaticSpeechRecognition.this);
                dialogBuilder.setTitle("Fetch failed... ");
                dialogBuilder.setMessage("Please try again ... ");
                dialogBuilder.setPositiveButton("Try Again", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
                        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
                        //Start the activity, the intent will be populated with the speech text
                        startActivityForResult(intent, SPEECH_REQUEST_CODE);
                        speakOut("Try Again");
                    }
                }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        System.out.println("Did nothing");
                    }
                });

                AlertDialog dialog = dialogBuilder.create();
                dialog.show();
                // Toast.makeText(CompleteAutomaticSpeechRecognition.this, fail_msg, Toast.LENGTH_SHORT).show();
            }

            /**
             * status == 1, is for displaying the balance and account number
             */

            else if (status == 1){
                System.out.println("The json array is "+json_data.getString("resp"));

                System.out.println("The id 1 is : "+new JSONObject(json_data.getString("resp")).getString("acc"));
                System.out.println("The id 2 is : "+new JSONObject(json_data.getString("resp")).getString("bal"));
                String bal = new JSONObject(json_data.getString("resp")).getString("bal").toString();
                String tellBalance = "Your balance is "+bal+" rupees";
                speakOut(tellBalance);
                AlertDialog.Builder dialogBuilder= new AlertDialog.Builder(CompleteAutomaticSpeechRecognition.this);
                dialogBuilder.setTitle("Displaying user data ... ");
                dialogBuilder.setMessage("Account no. : "+new JSONObject(json_data.getString("resp")).getString("acc") +
                        "\nBalance : Rs."+new JSONObject(json_data.getString("resp")).getString("bal"));
                dialogBuilder.setPositiveButton("I'm Done Here...", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        speakOut("Welcome back user");
                    }
                });
                AlertDialog dialog = dialogBuilder.create();
                dialog.show();
            }

            /**
             * This is the case where the user is asked to update something to the database, like the phone number,
             * his email address or other details
             */
            else if (status == 2){
                String msg = "Fail 2";
                Toast.makeText(CompleteAutomaticSpeechRecognition.this, msg, Toast.LENGTH_SHORT).show();
            }

            /**
             * A transaction has taken place, and the user has to be informed about it
             */
            /**else if (status == 3){
                Toast.makeText(CompleteAutomaticSpeechRecognition.this, "status returned "+status, Toast.LENGTH_SHORT).show();

                String acc = new JSONObject(json_data.getString("resp")).getString("acc").toString();
                //String date = new JSONObject(json_data.getString("resp")).getString("date").toString();
                //String type = new JSONObject(json_data.getString("resp")).getString("type").toString();
                //String remark = new JSONObject(json_data.getString("resp")).getString("remark").toString();
                String amt = new JSONObject(json_data.getString("resp")).getString("amt").toString();

                //String transaction_statement = type+"ed Rs."+amt+" dated "+date;
                //speakOut(transaction_statement);
                AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(CompleteAutomaticSpeechRecognition.this);
                dialogBuilder.setTitle("User Transaction Details... ");
                //dialogBuilder.setMessage("ACC : "+acc+"\nDated : "+date+"\nRemark : "+remark+"\nType : "+type+"\nAmount Rs.: "+amt);
                dialogBuilder.setPositiveButton("Thanks a lot!", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        speakOut("Please make another query");
                        // Create an intent that can the start the Speech Recognizer activity
                        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
                        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
                        //Start the activity, the intent will be populated with the speech text
                        startActivityForResult(intent, SPEECH_REQUEST_CODE);
                    }
                });
            }*/
            else if(status == 3){
                JSONObject jsonObject = new JSONObject(result);
                String result = jsonObject.getString("txt");
                System.out.println(result);

                speakOut(result);
                AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(CompleteAutomaticSpeechRecognition.this);
                dialogBuilder.setTitle("Fetching Transaction...");
                dialogBuilder.setMessage(result);
                dialogBuilder.setPositiveButton("I'm done", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // Create an intent that can the start the Speech Recognizer activity
                        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
                        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
                        //Start the activity, the intent will be populated with the speech text
                        startActivityForResult(intent, SPEECH_REQUEST_CODE);
                        System.out.println("Does not do anything");
                    }
                });

                AlertDialog dialog = dialogBuilder.create();
                dialog.show();
            }

            // JSONArray json_array = new JSONArray(json_data.getString("resp"));

        }catch(Exception e){
            Toast.makeText(CompleteAutomaticSpeechRecognition.this, "error"+exceptionMessage, Toast.LENGTH_SHORT).show();
        }
    }

    /**
     * Destroy the class instances when the activity is paused or destroyed
     */
    @Override
    protected void onDestroy() {
        // Don't forget to shutdown tts! The textToSpeech Object
        if(tts!=null){
            tts.stop();
            tts.shutdown();
        }
        super.onDestroy();
    }

    /**
     * Method for converting the text to the speech
     */
    private void speakOut(String text) {
        tts.speak(text, TextToSpeech.QUEUE_FLUSH, null);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_complete_automatic_speech_recognition, menu);
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

        else if (id == R.id.action_automatic_speech){
            Intent it = new Intent(CompleteAutomaticSpeechRecognition.this, CompleteAutomaticSpeechRecognition.class);
            startActivity(it);
            finish();
        }

        return super.onOptionsItemSelected(item);
    }

    /*
    Method for handling the speech part
     */
    @Override
    public void onInit(int status) {
        if (status == TextToSpeech.SUCCESS){

            // Here is where we have to change the language.

            int result = tts.setLanguage(loc);

            if(result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED){
                Toast.makeText(CompleteAutomaticSpeechRecognition.this, exceptionMessage, Toast.LENGTH_SHORT).show();
            }
            else{
                // Create an intent that can the start the Speech Recognizer activity
                Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
                intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                        RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
                //Start the activity, the intent will be populated with the speech text
                startActivityForResult(intent, SPEECH_REQUEST_CODE);
            }
        }
        else{
            Toast.makeText(CompleteAutomaticSpeechRecognition.this, initializationFailedMessage, Toast.LENGTH_SHORT).show();
            speakOut("Didn't catch that my friend. Can you say that again for me?");
        }

    }
}
