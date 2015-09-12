package com.example.dee.predmedbud;

import android.database.Cursor;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;


public class signup extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_signup, menu);
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

    public void submit (View v) {

        /*EditText name,email,pwd,mobile,city;

        name=(EditText)findViewById(R.id.editText3);
        email=(EditText)findViewById(R.id.editText4);
        pwd=(EditText)findViewById(R.id.editText5);
        mobile=(EditText)findViewById(R.id.editText6);
        city=(EditText)findViewById(R.id.editText7);




        if(name.getText().toString().equals("")||email.getText().toString().equals("")||pwd.getText().toString().equals("")||mobile.getText().toString().equals("")||city.getText().toString().equals(""))
        {
            Toast.makeText(this.getApplicationContext(), "Fill all the fields", Toast.LENGTH_LONG).show();
            return;
        }
        Cursor c=d1.rawQuery("select count(id) from client where email='"+email.getText().toString()+"'",null);
        c.moveToNext();
        if(c.getString(0).equals("1"))
        {
            Toast.makeText(this.getApplicationContext(),"You are already registered",Toast.LENGTH_SHORT).show();
            return;
        }*/

        Toast.makeText(this.getApplicationContext(), "Signup successful", Toast.LENGTH_SHORT).show();
        signup.this.finish();
    }

}
