package com.example.sultanov.timur.btinkubator;

import android.Manifest;
import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.support.v4.app.NotificationCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

//import app.akexorcist.bluetotohspp.library.BluetoothSPP;
//import app.akexorcist.bluetotohspp.library.BluetoothState;
//import app.akexorcist.bluetotohspp.library.DeviceList;

public class ProcessActivity extends AppCompatActivity {

    public OutputStream mmOutputStream = null;
    public InputStream mmInputStream = null;
    private ImageView ForwardSensorAlarm;
    private ImageView BoardSensorAlarm;
    private ImageView BackwardSensorAlarm;
    private ImageView ConnectionStatus;
    private TextView ForwardSensorPPM;
    private TextView BoardSensorPPM;
    private TextView BackwardSensorPPM;
    private ImageView ForwardSensorR0;
    private ImageView BoardSensorR0;
    private ImageView BackwardSensorR0;
    private TextView inString;
    private boolean connectionStatus = false;
    private Button connectBtn;
    private static boolean BoardSensorStatus            = true;
    private static boolean ForwardSensorStatus          = true;
    private static boolean BackwardSensorStatus         = true;
    private static boolean BoardSensorDamageStatus      = true;
    private static boolean ForwardSensorDamageStatus    = true;
    private static boolean BackwardSensorDamageStatus   = true;
    BluetoothSPP bt;
    TimerTask mTimerTask;
    final Handler myHandler = new Handler();
    Timer t;
    private int mDelay;
    private String BTnameTransfered;
    Toolbar toolbar;

    DatabaseHelper databaseHelper;
    SQLiteDatabase db;
    Cursor userCursor;
    long userId=0;
    private   Intent custom_data;
    private SharedPreferences mSettings;
    public static final String APP_PREFERENCES = "mysettings";
    public static final String APP_PREFERENCES_BTU_NAME = "btu_name";
    private String btuName = "NO_NAME";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_process);
        ForwardSensorAlarm = (ImageView) findViewById(R.id.ForwardSensorAlarm);
        BoardSensorAlarm = (ImageView) findViewById(R.id.BoardSensorAlarm);
        BackwardSensorAlarm = (ImageView) findViewById(R.id.BackwardSensorAlarm);
        ForwardSensorPPM = (TextView) findViewById(R.id.ForwardSensorPPM);
        BoardSensorPPM = (TextView) findViewById(R.id.BoardSensorPPM);
        BackwardSensorPPM = (TextView) findViewById(R.id.BackwardSensorPPM);
        ForwardSensorR0 = (ImageView) findViewById(R.id.ForwardSensorR0);
        BoardSensorR0 = (ImageView) findViewById(R.id.BoardSensorR0);
        BackwardSensorR0 = (ImageView) findViewById(R.id.BackwardSensorR0);
        ConnectionStatus = (ImageView) findViewById(R.id.ConnectonStatus);
        //connectBtn = (Button)findViewById(R.id.connectBtn);
        bt = new BluetoothSPP(this);
        t = new Timer();
        Intent intent = getIntent();
        mDelay = intent.getIntExtra("tDelay",500);
        databaseHelper = new DatabaseHelper(this);
//==================================================================================================
        toolbar = (Toolbar) findViewById(R.id.process_toolbar);
        setSupportActionBar(toolbar);
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        toolbar.inflateMenu(R.menu.process_menu);
        indNullState();
        // Quick permission check
        int permissionCheck = 0;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            permissionCheck = this.checkSelfPermission("Manifest.permission.ACCESS_FINE_LOCATION");
            permissionCheck += this.checkSelfPermission("Manifest.permission.ACCESS_COARSE_LOCATION");
            if (permissionCheck != 0) {
             this.requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION,
                     Manifest.permission.ACCESS_COARSE_LOCATION}, 1001); //Any number
            }
        }
        if (bt.isBluetoothAvailable()==false) {
            Toast.makeText(getApplicationContext()
                    , getResources().getString(R.string.not_btu)
                    , Toast.LENGTH_SHORT).show();
            Intent intent_no_btu = new Intent(getApplicationContext(), MainActivity.class);
            startActivity(intent_no_btu);
            finish();
        }
        bt.setBluetoothStateListener(new BluetoothSPP.BluetoothStateListener() {
            public void onServiceStateChanged(int state) {
                if (state == BluetoothState.STATE_CONNECTED)
                    Log.i("Check", "State : Connected");
                else if (state == BluetoothState.STATE_CONNECTING)
                    Log.i("Check", "State : Connecting");
                else if (state == BluetoothState.STATE_LISTEN)
                    Log.i("Check", "State : Listen");
                else if (state == BluetoothState.STATE_NONE)
                    Log.i("Check", "State : None");
            }
        });

        bt.setOnDataReceivedListener(new BluetoothSPP.OnDataReceivedListener() {
            public void onDataReceived(byte[] data, String message) {
                     Log.i("Check", "Message : " + data.length);
                if(data.length>=20)
                {
                    parseOutMcPacket(data);
                }
            }
        });

        //View.OnClickListener conBtn = new View.OnClickListener() {
        //    @Override
        //    public void onClick(View v) {
        //        reConnect();
        //    }
        //};
        //connectBtn.setOnClickListener(conBtn);
        bt.setBluetoothConnectionListener(new BluetoothSPP.BluetoothConnectionListener() {
            public void onDeviceConnected(String name, String address) {
                Log.i("Check", "Device Connected!!");
                ConnectionStatus.setImageResource(R.mipmap.btu_en);
                connectionStatus = true;
                startTimerTask();
                //connectBtn.setEnabled(false);
                Log.i("Check", "Device adress: "+ bt.getConnectedDeviceAddress());
                Log.i("Check", "Device name: "+ bt.getConnectedDeviceName());
                indNullState();
            }

            public void onDeviceDisconnected() {
                Log.i("Check", "Device Disconnected!!");
                ConnectionStatus.setImageResource(R.mipmap.btu_dis);
                onBackPressed();
                //stopTimerTask();
                indNullState();
                connectionStatus = false;
                //connectBtn.setEnabled(true);

            }

            public void onDeviceConnectionFailed() {
                indNullState();
                ConnectionStatus.setImageResource(R.mipmap.btu_dis);
                connectionStatus = false;
                Log.i("Check", "Unable to Connected!!");
            }
        });

        bt.setAutoConnectionListener(new BluetoothSPP.AutoConnectionListener() {
            public void onNewConnection(String name, String address) {
                Log.i("Check", "New Connection - " + name + " - " + address);
            }

            public void onAutoConnectionStarted() {
                Log.i("Check", "Auto menu_connection started");
            }
        });
        mSettings = getSharedPreferences(APP_PREFERENCES, Context.MODE_PRIVATE);
        if (mSettings.contains(APP_PREFERENCES_BTU_NAME)) {
            // Получаем число из настроек
            btuName = mSettings.getString(APP_PREFERENCES_BTU_NAME, "NO_NAME");
            Log.i("Check", "Read btu name settings");
        }
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.process_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch(id) {
            case R.id.action_connect:
               if(bt!=null)
               {
                   reConnect();
                   Log.i("Check", "Action connect button");
               }
               return true;
            case R.id.action_disconnect:
                //disconnectWiFi();
                if(bt!=null) {
                    bt.disconnect();
                    Log.i("Check", "Action disconnect button");
                }
                indNullState();
                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                startActivity(intent);
                finish();
                return true;
        }
        return super.onOptionsItemSelected(item);
    }
       public void parseOutMcPacket(byte[] data){
        final String[] sensor_err_message = getResources().getStringArray(R.array.sensor_err_message);
        final double tmp = 0.8056640625;
        final int MAX_MC101_SENSROR_VALUE = 60000;
        String sp = null;
        int readData = 0;
        readData = ((data[2] & 0xFF) << 8)|(data[3] & 0xFF);
        if(readData > MAX_MC101_SENSROR_VALUE)
        {
            readData = MAX_MC101_SENSROR_VALUE;
        }
        if(readData < 0)
        {
            readData = 0 ;
        }
        sp= String.format("%d ppm",(readData));
        BoardSensorPPM.setText(sp);
        readData = ((data[4] & 0xFF) << 8) | (data[5] & 0xFF);
           if(readData > MAX_MC101_SENSROR_VALUE)
           {
               readData = MAX_MC101_SENSROR_VALUE;
           }
           if(readData < 0)
           {
               readData = 0 ;
           }
        sp= String.format("%d ppm",readData);
        ForwardSensorPPM.setText(sp);
        readData = ((data[6] & 0xFF) << 8) | (data[7] & 0xFF);
           if(readData > MAX_MC101_SENSROR_VALUE)
           {
               readData = MAX_MC101_SENSROR_VALUE;
           }
           if(readData < 0)
           {
               readData = 0 ;
           }
        sp= String.format("%d ppm",readData);
        BackwardSensorPPM.setText(sp);

        if(data[17]==1)
        {
            BoardSensorR0.setImageResource(R.mipmap.alarm);
            if(BoardSensorDamageStatus)
            {
                save(sensor_err_message[3],readDateTime());
                BoardSensorDamageStatus  = false;
            }
        }
        else
        {
            BoardSensorR0.setImageResource(R.mipmap.on);
            BoardSensorDamageStatus  = true;
        }
        if(data[18]==1)
        {
            ForwardSensorR0.setImageResource(R.mipmap.alarm);
            if(ForwardSensorDamageStatus)
            {
                save(sensor_err_message[4], readDateTime());
                ForwardSensorDamageStatus = false;
            }
        }
        else
        {
            ForwardSensorR0.setImageResource(R.mipmap.on);
            ForwardSensorDamageStatus = true;
        }
        if(data[19]==1)
        {
            BackwardSensorR0.setImageResource(R.mipmap.alarm);
            if(BackwardSensorDamageStatus)
            {
                save(sensor_err_message[5],readDateTime());
                BackwardSensorDamageStatus = false;
            }
        }
        else
        {
            BackwardSensorR0.setImageResource(R.mipmap.on);
            BackwardSensorDamageStatus = true;
        }
        if(data[14]==1)
        {
            BoardSensorAlarm.setImageResource(R.mipmap.alarm);
            if(BoardSensorStatus)
            {
                save(sensor_err_message[0],readDateTime());
                BoardSensorStatus = false;
            }
        }
        else
        {
            BoardSensorAlarm.setImageResource(R.mipmap.on);
            BoardSensorStatus = true;
        }
        if(data[15]==1)
        {
            ForwardSensorAlarm.setImageResource(R.mipmap.alarm);
            if(ForwardSensorStatus)
            {
                save(sensor_err_message[1],readDateTime());
                ForwardSensorStatus = false;
            }
        }
        else
        {
            ForwardSensorAlarm.setImageResource(R.mipmap.on);
            ForwardSensorStatus = true;
        }
        if(data[16]==1)
        {
            BackwardSensorAlarm.setImageResource(R.mipmap.alarm);
            if(BackwardSensorStatus)
            {
                save(sensor_err_message[2],readDateTime());
                BackwardSensorStatus = false;
            }
        }
        else
        {
            BackwardSensorAlarm.setImageResource(R.mipmap.on);
            BackwardSensorStatus = true;
        }
        readStatusSensorSendNotification();
    }

    public String readDateTime()
    {
        String mydate = java.text.DateFormat.getDateTimeInstance().format(Calendar.getInstance().getTime());
        return mydate;
    }

    public void indNullState()
    {
        BoardSensorAlarm.setImageResource(R.mipmap.off);
        ForwardSensorAlarm.setImageResource(R.mipmap.off);
        BackwardSensorAlarm.setImageResource(R.mipmap.off);

        BoardSensorR0.setImageResource(R.mipmap.off);
        ForwardSensorR0.setImageResource(R.mipmap.off);
        BackwardSensorR0.setImageResource(R.mipmap.off);

        BoardSensorPPM.setText("  - - - - - - - - -");
        ForwardSensorPPM.setText("  - - - - - - - - -");
        BackwardSensorPPM.setText("  - - - - - - - - -");
    }
    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopTimerTask();
        if(bt!=null){
            bt.stopService();
            if(bt.getServiceState() == BluetoothState.STATE_CONNECTED) {
                bt.disconnect();
            }
        }

        if(db!=null) db.close();
        if(userCursor!=null) userCursor.close();
        BoardSensorStatus            = true;
        ForwardSensorStatus          = true;
        BackwardSensorStatus         = true;
        BoardSensorDamageStatus      = true;
        ForwardSensorDamageStatus    = true;
        BackwardSensorDamageStatus   = true;
    }
    //==============================================================================================
    public void connectStart()
    {
        if (!bt.isServiceAvailable()) {
//            if(custom_data!=null&&btuName.contains(custom_data.getExtras().getString(BluetoothState.DEVICE_NAME))){
//                bt.setupService();
//                bt.startService(BluetoothState.DEVICE_OTHER);
//                bt.connect(custom_data);
//                Log.i("Check", "connect from custom data");
//            }
//            else
            {
                bt.setupService();
                bt.startService(BluetoothState.DEVICE_OTHER);
                RequestConnect();
                Log.i("Check", "connect without custom data");
            }

        }
    }
    @Override
    protected void onStart() {
        super.onStart();
        connectStart();
        indNullState();
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == BluetoothState.REQUEST_CONNECT_DEVICE) {
            if (resultCode == Activity.RESULT_OK)
            {
                custom_data = data;
                SharedPreferences.Editor editor = mSettings.edit();
                btuName  = data.getExtras().getString(BluetoothState.DEVICE_NAME);
                editor.putString(APP_PREFERENCES_BTU_NAME, btuName);
                editor.apply();
                bt.connect(data);
                Log.i("Check", "Request connect");

            }

//        } else if (requestCode == BluetoothState.REQUEST_ENABLE_BT) {
//            if (resultCode == Activity.RESULT_OK) {
//                connectStart();
//
//            } else {
//                Toast.makeText(getApplicationContext()
//                        , getResources().getString(R.string.not_btu)
//                        , Toast.LENGTH_SHORT).show();
//                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
//                startActivity(intent);
//                finish();
//            }
        }
    }
    public void reConnect()
    {
        if(bt!=null){
            if(bt.getServiceState() == BluetoothState.STATE_CONNECTED) {
                bt.disconnect();
            }
            RequestConnect();
            Log.i("Check", "Reconnect");
        }

    }
    public void RequestConnect(){
        if(bt.getServiceState() == BluetoothState.STATE_CONNECTED) {
            bt.disconnect();
        } else {
            Log.i("Check", "Open list scan devices");
            Intent intent = new Intent(getApplicationContext(), DeviceList.class);
            intent.putExtra("bluetooth_devices", getResources().getString(R.string.bluetooth_devices));
            intent.putExtra("no_devices_found", getResources().getString(R.string.no_devices_found));
            intent.putExtra("scanning", getResources().getString(R.string.scanning));
            intent.putExtra("scan_for_devices", getResources().getString(R.string.scan_for_devices));
            intent.putExtra("select_device", getResources().getString(R.string.select_device));
            intent.putExtra("layout_list", R.layout.device_list);
            intent.putExtra("layout_text", R.layout.device_name);
            startActivityForResult(intent, BluetoothState.REQUEST_CONNECT_DEVICE);
        }


//    if(bt!=null){
//       if(bt.getServiceState() == BluetoothState.STATE_CONNECTED) {
//            bt.disconnect();
//    }
        //Log.i("Check", "RequestConnect");
      //  {
           // if(custom_data!=null)
           // {
                //if(bt!=null){
                    //tmpAdress = custom_data.getExtras().getString(BluetoothState.EXTRA_DEVICE_ADDRESS);
//                    if(!btuAdress.contains("NO_NAME")){
//                        bt.connect(btuAdress);
//                        Log.i("Check", "connect by adress string");
//                    }
//                     else
//                       {
//                          bt.connect(custom_data);
//                           Log.i("Check", "connect by data");
//                       }

               // }


           // }
           // else
//            {
//                Intent intent = new Intent(getApplicationContext(), DeviceList.class);
//                startActivityForResult(intent, BluetoothState.REQUEST_CONNECT_DEVICE);
//                Log.i("Check", "Open list scan devices");
//            }

        }
    //}
//}
    public void setup() {

    }

    //==================================================================================================
    @Override
    public void onBackPressed() {
        super.onBackPressed();
        indNullState();
        connectionStatus = false;
        stopTimerTask();
        indNullState();
        if (bt != null) {
            bt.stopService();
            if (bt.getServiceState() == BluetoothState.STATE_CONNECTED) {
                bt.disconnect();
            }
            Intent intent = new Intent(getApplicationContext(), MainActivity.class);
            startActivity(intent);
            finish();
        }

        Log.i("Check", "onBackPress");
    }
    public void startTimerTask() {
           mTimerTask = new TimerTask() {
             public void run() {
                 //myHandler.post(new Runnable() {
                 // public void run() {
                 if (connectionStatus) {
                     bt.send("request", true);
                     Log.i("Check", "Send request");
                 }

                 //  }
                 // });
             }
         };
        t.schedule(mTimerTask, 0,mDelay);
    }

    public void stopTimerTask() {
        if (mTimerTask != null) {
            mTimerTask.cancel();
            mTimerTask = null;
          }
    }
    public void save(String name,String dateTime){
        db = databaseHelper.getWritableDatabase();
        ContentValues cv = new ContentValues();
        cv.put(DatabaseHelper.COLUMN_NAME, name);
        cv.put(DatabaseHelper.COLUMN_YEAR, dateTime);

        //if (userId > 0) {
            //db.update(DatabaseHelper.TABLE, cv, DatabaseHelper.COLUMN_ID + "=" + String.valueOf(userId), null);
       // } else {
            db.insert(DatabaseHelper.TABLE, null, cv);
       // }
        db.close();
    }
    static boolean firstSensorError = false;
    //==============================================================================================
    void readStatusSensorSendNotification()
    {
        Notification notification;
        NotificationManager notificationManager = null;
        long[] vibrate = new long[] { 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 };
        if(!(BoardSensorStatus&&ForwardSensorStatus&&BackwardSensorStatus&&BoardSensorDamageStatus
            &&ForwardSensorDamageStatus&&BackwardSensorDamageStatus))
        {
            Log.i("Check", "Send notification");
            if(firstSensorError==false)
            {
                firstSensorError = true;
                // Create PendingIntent
                Intent resultIntent = new Intent(this, ProcessActivity.class)
                        .setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP
                                | Intent.FLAG_ACTIVITY_SINGLE_TOP);

                PendingIntent resultPendingIntent = PendingIntent.getActivity(this, 0, resultIntent,
                        PendingIntent.FLAG_UPDATE_CURRENT);

                // Create Notification
                NotificationCompat.Builder builder =
                        new NotificationCompat.Builder(this)
                                .setSmallIcon(R.mipmap.alarm)
                                .setContentTitle(getResources().getString(R.string.notification_title))
                                .setContentText(getResources().getString(R.string.notification_text))
                                .setDefaults(Notification.DEFAULT_LIGHTS)
                                .setDefaults(Notification.DEFAULT_VIBRATE)
                                .setDefaults(Notification.DEFAULT_SOUND)
                                .setDefaults(Notification.FLAG_INSISTENT)
                                .setWhen(System.currentTimeMillis())
                                //.setDefaults(Notification.FLAG_ONGOING_EVENT)
                                //.setDefaults(Notification.FLAG_AUTO_CANCEL)
                                .setContentIntent(resultPendingIntent);

                notification = builder.build();
                Uri ringURI = Uri.parse("android.resource://com.example.timur.homegassensor/" + R.raw.surround_bells);
                //RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM);
                notification.sound = ringURI;
                notification.ledARGB = Color.RED;
                notification.ledOffMS = 0;
                notification.ledOnMS = 1;
                notification.vibrate = vibrate;
                notification.flags = notification.flags | Notification.FLAG_SHOW_LIGHTS|Notification.FLAG_AUTO_CANCEL;

                // Show Notification
                notificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
                notificationManager.notify(1, notification);
            }
        }
        else
        {
            firstSensorError = false;
            if(notificationManager!=null)notificationManager.cancelAll();
        }
    }
    //==============================================================================================
}







