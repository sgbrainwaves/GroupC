package com.aditya.brainwavehackfrontend.com.brainwavehack.BrainWaveHackSamaritanSpeechRecognition;

import android.content.Intent;
import android.speech.RecognizerIntent;
import android.speech.tts.TextToSpeech;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListView;
import android.widget.Toast;

import com.aditya.brainwavehackfrontend.R;

import java.util.List;

/*
This class is used for providing the Google Voice Recognition API functions
1. Provides for converting a speech recognized in some language into text (default -> english)
2. Provides the function for converting a text of a language into speech in a language which can
be recognized by the user.
 */

public class GoogleVoiceAPI extends ActionBarActivity
implements TextToSpeech.OnInitListener{

    private static final int SPEECH_REQUEST_CODE = 0;
    private ListView lv;
    private static final String[] queriesToDisplay = {"1. Show my my Bank Balance", "2. Change my email address",
    "3. Display my last three transactions", "4. Show me my Mini Statement"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_google_voice_api);

        lv = (ListView) findViewById(R.id.listViewOfQueries);

        // Create an intent that can the start the Speech Recognizer activity
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        //Start the activity, the intent will be populated with the speech text
        startActivityForResult(intent, SPEECH_REQUEST_CODE);

    }


    // This is where we process the intent and the speech gets converted to the text


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == SPEECH_REQUEST_CODE && resultCode==RESULT_OK){
            List<String> results = data.getStringArrayListExtra(
                    RecognizerIntent.EXTRA_RESULTS
            );
            // This is the spoken text and will be converted to the text
            String spokenText = results.get(0);
            Toast.makeText(GoogleVoiceAPI.this, spokenText, Toast.LENGTH_SHORT).show();

        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_google_voice_api, menu);
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

        else if (id == R.id.action_google_callback){
            Intent intent = new Intent(GoogleVoiceAPI.this, GoogleVoiceAPI.class);
            startActivity(intent);
            finish();
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onInit(int status) {

    }
}
