package com.example.dee.predmedbud;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;


public class symptom extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_symptom);

        Spinner symptom_spinner = (Spinner) findViewById(R.id.symptoms_spinner);
        // Create an ArrayAdapter using the string array and a default spinner layout
        ArrayAdapter<CharSequence> symptom_adapter = ArrayAdapter.createFromResource(this,R.array.symptoms_array, android.R.layout.simple_spinner_item);
        // Specify the layout to use when the list of choices appears
        symptom_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
// Apply the adapter to the spinner
        symptom_spinner.setAdapter(symptom_adapter);

        Spinner intensity_spinner = (Spinner) findViewById(R.id.intensity_spinner);
        // Create an ArrayAdapter using the string array and a default spinner layout
        ArrayAdapter<CharSequence> intensity_adapter = ArrayAdapter.createFromResource(this,R.array.intensity_array, android.R.layout.simple_spinner_item);
        // Specify the layout to use when the list of choices appears
        intensity_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
// Apply the adapter to the spinner
        intensity_spinner.setAdapter(intensity_adapter);

        Spinner duration_spinner = (Spinner) findViewById(R.id.duration_spinner);
        // Create an ArrayAdapter using the string array and a default spinner layout
        ArrayAdapter<CharSequence> duration_adapter = ArrayAdapter.createFromResource(this,R.array.duration_array, android.R.layout.simple_spinner_item);
        // Specify the layout to use when the list of choices appears
        duration_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
// Apply the adapter to the spinner
        duration_spinner.setAdapter(duration_adapter);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_symptom, menu);
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

    public void storesym_callback(View view) {

        Toast.makeText(this.getApplicationContext(), "Symptoms saved. Enter next one.", Toast.LENGTH_LONG).show();
        Intent i = new Intent(this.getApplicationContext(),symptom.class);
        startActivity(i);
        //overridePendingTransition(R.anim.animation1,R.anim.animation2);
    }

    public void diagnose(View view) {

        Toast.makeText(this.getApplicationContext(), "Ongoing diagnosis...", Toast.LENGTH_LONG).show();
        Intent i = new Intent(this.getApplicationContext(), diagnosis.class);
        startActivity(i);
        //overridePendingTransition(R.anim.animation1,R.anim.animation2);
    }
}
