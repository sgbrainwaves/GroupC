package com.aditya.brainwavehackfrontend.com.brainwavehack.BrainwaveHackSamaritanFacialRecognition;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import com.aditya.brainwavehackfrontend.R;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * This is the file that is in use in this application.
 */

public class ImageActivity extends ActionBarActivity {

    public static String imageFilePath;

    public static String full_File_Name;

    public static Bitmap bitmap;

    private static final int CAMERA_CAPTURE_IMAGE_REQUEST_CODE=100;
    private static final int MEDIA_TYPE_IMAGE=1;

    // public File uri of the image saved in the server
    public static Uri publicFileUri;

    // File url to store image/video
    private static final String IMAGE_DIRECTORY_NAME = "BrainwaveHackCamera";
    // file Uri to store image / video
    private Uri fileUri;

    private ImageView imageView;
    private Button imageButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_image);

        imageView = (ImageView) findViewById(R.id.ivImage);
        imageButton = (Button) findViewById(R.id.buttonImage);

        /**
         * Capture image on the button click event
         */
        imageButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Method to capture the image
                captureImage();
            }
        });

        /**
         * Checking the availability of the camera on the device
         */
        // Checking camera availability, force closes the application if the camera
        // is not available
        if (!isDeviceSupportCamera()) {
            Toast.makeText(getApplicationContext(),
                    "Sorry! Your device doesn't support camera",
                    Toast.LENGTH_LONG).show();
            // will close the app if the device doesn't have camera
            finish();
        }
    }

    /**
     * Method that checks whether the device has the camera hardware or not
     */
    private boolean isDeviceSupportCamera() {
        if (getApplicationContext().getPackageManager().hasSystemFeature(
                PackageManager.FEATURE_CAMERA)) {
            // this device has a camera
            return true;
        } else {
            // no camera on this device
            return false;
        }
    }

    /**
     * Method used for handling the click on the button and saving the image
     * Capturing the image will launch the camera app request intent
     */
    private void captureImage() {
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); // intent for opening the camera

        fileUri = getOutputMediaFileUri(MEDIA_TYPE_IMAGE); // Media type image specifies if it is the camera (by default)
        // Display the fileUri in the toast to get the path of the image stored in th phone
        Toast.makeText(ImageActivity.this, ""+fileUri, Toast.LENGTH_SHORT).show();
        // save the fileUri into the public Uri
        publicFileUri = fileUri;

        // fileUri displays the path where the image file is stored
        uploadImageToServer();
        
        intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);

        // start the image capture Intent, saves the image in the specified directory
        startActivityForResult(intent, CAMERA_CAPTURE_IMAGE_REQUEST_CODE);

        //BitmapDrawable drawable = (BitmapDrawable) imageView.getDrawable();
        //bitmap = drawable.getBitmap();
    }

    /**
     * Method for uploading an image file to server
     */
    private void uploadImageToServer() {

    }


    /*
	 * Here we store the file url as it will be null after returning from camera
	 * app
	 */
    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);

        // save file url in bundle as it will be null on scren orientation
        // changes
        outState.putParcelable("file_uri", fileUri);
    }

    /**
     * Gets the file uri back after the application in opened
     * @param savedInstanceState
     */
    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);

        // get the file url
        fileUri = savedInstanceState.getParcelable("file_uri");
    }

    /**
     * Receiving the activity result method will be called after closing the camera
     * @return
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // if the result is capturing Image, then perform the code
        // by default we implement the user to only take the image
        if (requestCode == CAMERA_CAPTURE_IMAGE_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // successfully captured the image
                // display it in image view
                previewCapturedImage();
            } else if (resultCode == RESULT_CANCELED) {
                // user cancelled Image capture
                Toast.makeText(getApplicationContext(),
                        "User cancelled image capture", Toast.LENGTH_SHORT)
                        .show();
            } else {
                // failed to capture image
                Toast.makeText(getApplicationContext(),
                        "Sorry! Failed to capture image", Toast.LENGTH_SHORT)
                        .show();
            }
        }
    }

    /**
     * Displays the image from a file path into the imageview
     * @return
     */
    /*
	 * Display image from a path to ImageView
	 */
    private void previewCapturedImage() {
        try {
            // bimatp factory
            BitmapFactory.Options options = new BitmapFactory.Options();

            // downsizing image as it throws OutOfMemory Exception for larger
            // images
            options.inSampleSize = 8;

            final Bitmap bitmap = BitmapFactory.decodeFile(fileUri.getPath(),
                    options);

            imageView.setImageBitmap(bitmap);
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
    }

    /**
     * Some of the helper methods to deal with the o
     */

    /**
     * Creating the url to store image
     */
    public Uri getOutputMediaFileUri(int type){
        // extracts the uri from the file depending on the type
        // whether camera or video
        return Uri.fromFile(getOutputMediaFile(type));
    }

    // returns the image / video depending on the type
    public static File getOutputMediaFile(int type){
        // External sdcard location
        File mediaStorageDir = new File(
                Environment
                        .getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                IMAGE_DIRECTORY_NAME);

        // Create the storage directory if it does not exist
        if (!mediaStorageDir.exists()) {
            if (!mediaStorageDir.mkdirs()) {
                Log.d(IMAGE_DIRECTORY_NAME, "Oops! Failed create "
                        + IMAGE_DIRECTORY_NAME + " directory");
                return null;
            }
        }

        // Create a media file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss",
                Locale.getDefault()).format(new Date());
        File mediaFile;
        if (type == MEDIA_TYPE_IMAGE) {
            /*mediaFile = new File(mediaStorageDir.getPath() + File.separator
                    + "IMG_" + timeStamp + ".jpg");*/
            File sdCardDirectory = Environment.getExternalStorageDirectory();
            full_File_Name = "IMG_"+timeStamp+".jpg";
            mediaFile = new File(sdCardDirectory.getPath()+File.separator+"IMG_"+timeStamp+".jpg");
            imageFilePath = sdCardDirectory.getPath()+File.separator+"IMG_"+timeStamp+".jpg";
        }
        else {
            return null;
        }

        return mediaFile;
    }



    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_image, menu);
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

        else if (id == R.id.action_upload_image){
            Intent it = new Intent(ImageActivity.this, UploadImage.class);
            startActivity(it);
        }

        return super.onOptionsItemSelected(item);
    }
}
