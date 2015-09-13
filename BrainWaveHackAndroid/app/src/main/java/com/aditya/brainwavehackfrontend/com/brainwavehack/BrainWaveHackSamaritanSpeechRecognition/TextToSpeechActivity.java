package com.aditya.brainwavehackfrontend.com.brainwavehack.BrainWaveHackSamaritanSpeechRecognition;

import android.speech.tts.TextToSpeech;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.aditya.brainwavehackfrontend.R;

import java.util.Locale;

public class TextToSpeechActivity extends ActionBarActivity implements
        TextToSpeech.OnInitListener{

    private EditText speechText;
    private Button speechConvertButton;
    private TextToSpeech tts;

    private static final String exceptionMessage = "Cannot connect to Google Servers. Please check" +
            " your Network and try again.";
    private static final String initializationFailedMessage = "Initialization has failed. Please " +
            "check your Network is properly configured";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_text_to_speech);

        tts = new TextToSpeech(this, this);
        speechText = (EditText) findViewById(R.id.textToSpeechText);
        speechConvertButton = (Button) findViewById(R.id.buttonConvert);

        speechConvertButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Method that takes input from the speechText and speaks
                // out the corresponding sentence
                speakOut();
            }
        });
    }

    /**
     * Method that takes the input from the text and converts the speech
     */
    private void speakOut() {
        String text = speechText.getText().toString();
        tts.speak(text, TextToSpeech.QUEUE_FLUSH, null);
    }


    @Override
    protected void onDestroy() {
        // Don't forget to shutdown tts! The textToSpeech Object
        if(tts!=null){
            tts.stop();
            tts.shutdown();
        }
        super.onDestroy();
    }

    @Override
    public void onInit(int status) {
        if (status == TextToSpeech.SUCCESS){

            // Here is where we have to change the language.
            // To set a different language, the Locale can be changed after displaying all
            // the locales in the form of a list

            int result = tts.setLanguage(Locale.FRENCH);

            if(result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED){
                Toast.makeText(TextToSpeechActivity.this, exceptionMessage, Toast.LENGTH_SHORT).show();
            }
            else{
                speechConvertButton.setEnabled(true);
                speakOut();
            }
        }
        else{
            Toast.makeText(TextToSpeechActivity.this, initializationFailedMessage, Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_text_to_speech, menu);
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
