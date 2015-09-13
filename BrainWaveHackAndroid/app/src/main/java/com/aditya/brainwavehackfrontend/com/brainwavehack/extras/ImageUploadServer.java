package com.aditya.brainwavehackfrontend.com.brainwavehack.extras;

import android.app.ProgressDialog;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.aditya.brainwavehackfrontend.R;
import com.aditya.brainwavehackfrontend.com.brainwavehack.BrainwaveHackSamaritanFacialRecognition.ImageActivity;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * Given a particular URI, the application should be able to
 * upload the image to the server, i.e to the 000webhost.com
 * server with a given url, and should be able to retrieve the
 * image given the url of the image.
 */

public class ImageUploadServer extends ActionBarActivity {

    private static final String serverUri = "some_dumb_url";

    private Button uploadServerImage;
    private Uri fileUri = ImageActivity.publicFileUri; // gets the uri of the image to upload to server
    private ProgressDialog progressDialog;
    private int serverResponseCode = 0;

    private final String errorMessage = "File does not exist. Server Error";
    private final String exceptionMessage = "Cannot connect to server. Please check " +
            "your network Connection and try again.";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_image_upload_server);

        uploadServerImage = (Button) findViewById(R.id.uploadServerImage);

        uploadServerImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Display the file path in the Toast
                Toast.makeText(ImageUploadServer.this, "" + fileUri, Toast.LENGTH_SHORT).show();
                new UploadImageTask().execute();
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_image_upload_server, menu);
        return true;
    }

    private class UploadImageTask extends AsyncTask<Void, Void, Void>{

        @Override
        protected void onPreExecute() {
            progressDialog = new ProgressDialog(ImageUploadServer.this);
            progressDialog.setTitle("Uploading Image To Server ... ");
            progressDialog.setMessage("Please Wait ... ");
            progressDialog.show();
            progressDialog.setCancelable(false);
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            progressDialog.dismiss();
        }

        @Override
        protected Void doInBackground(Void... params) {
            String fileName = ""+fileUri;
            HttpURLConnection conn = null;
            DataOutputStream dos = null;
            String lineEnd = "\r\n";
            String twoHyphens = "--";
            String boundary = "*****";
            int bytesRead, bytesAvailable, bufferSize;
            byte[] buffer;
            int maxBufferSize = 1 * 1024 * 1024;
            File sourceFile = new File(fileName);

            // If the source file / image does not exist, display error message
            if (!sourceFile.isFile()) {
                Toast.makeText(ImageUploadServer.this, errorMessage, Toast.LENGTH_SHORT).show();
                //progressDialog.dismiss();
            }

            // Else upload the source file / image for upload to the server
            else{
                try{
                    // Open a URL connection to the servlet
                    FileInputStream fileInputStream = new FileInputStream(sourceFile);
                    URL url = new URL(serverUri); // defines the url of the php file

                    // Open a Http Connection to the Servlet
                    conn = (HttpURLConnection) url.openConnection();
                    conn.setDoInput(true); // allows input to the url connection
                    conn.setDoOutput(true); // allows output from the url connection
                    conn.setUseCaches(false); // don't use a cached copy
                    conn.setRequestMethod("POST");
                    conn.setRequestProperty("Connection", "Keep-Alive"); // keeps the connection alive
                    conn.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + boundary);
                    conn.setRequestProperty("uploaded_file", fileName);

                    dos = new DataOutputStream(conn.getOutputStream());

                    dos.writeBytes(twoHyphens + boundary + lineEnd);
                    dos.writeBytes("Content-Disposition: form-data; name=uploaded_file;filename="
                            + fileName + "" + lineEnd);
                    dos.writeBytes(lineEnd);

                    // create a buffer of maximum size
                    bytesAvailable = fileInputStream.available();

                    bufferSize = Math.min(bytesAvailable, maxBufferSize);
                    buffer = new byte[bufferSize];

                    // read file and write it into form...
                    bytesRead = fileInputStream.read(buffer, 0, bufferSize);

                    while (bytesRead > 0) {

                        dos.write(buffer, 0, bufferSize);
                        bytesAvailable = fileInputStream.available();
                        bufferSize = Math.min(bytesAvailable, maxBufferSize);
                        bytesRead = fileInputStream.read(buffer, 0, bufferSize);

                    }

                    // send multipart form data necesssary after file data...
                    dos.writeBytes(lineEnd);
                    dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);

                    // Responses from the server (code and message)
                    serverResponseCode = conn.getResponseCode();
                    String serverResponseMessage = conn.getResponseMessage();

                    Log.i("uploadFile", "HTTP Response is : "
                            + serverResponseMessage + ": " + serverResponseCode);

                    if(serverResponseCode == 200){

                        String msg = "File upload complete";
                        Toast.makeText(ImageUploadServer.this, msg, Toast.LENGTH_SHORT).show();
                    }

                    // close the streams
                    fileInputStream.close();
                    dos.flush();
                    dos.close();

                }catch(MalformedURLException e){
                    Toast.makeText(ImageUploadServer.this, exceptionMessage, Toast.LENGTH_SHORT).show();
                }catch(Exception e){
                    Toast.makeText(ImageUploadServer.this, exceptionMessage, Toast.LENGTH_SHORT).show();
                }


            }

            return null;
        }
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
