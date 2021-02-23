package com.example.sultanov.timur.btinkubator;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.InputType;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.MultiAutoCompleteTextView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    ListView list;
    Integer[] imgid = {
            R.mipmap.play,
            R.mipmap.wrench,
            R.mipmap.question,
            R.mipmap.zoom,
            R.mipmap.danger,
            R.mipmap.knob_add
    };
    private String m_Text;
    int time = 1000;
    public static final String APP_PREFERENCES = "mysettings";
    public static final String APP_PREFERENCES_COUNTER = "counter";
    public static final String APP_PREFERENCES_BTU_NAME = "btu_name";
    private SharedPreferences mSettings;
    private ImageView splashImage;
    private Toolbar toolbar;
    private String btu_name = "HC-06";
    BluetoothSPP bt;


//==============================================================================================

    String getM_text() {
        return m_Text;
    }

    //==============================================================================================
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        toolbar = (Toolbar) findViewById(R.id.main_toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setHomeAsUpIndicator(R.mipmap.alarm);
        m_Text = getResources().getString(R.string.btu_name);
        final String[] itemname = getResources().getStringArray(R.array.itemname);
        final String[] subitemname = getResources().getStringArray(R.array.subitemname);
        CustomListAdapter adapter = new CustomListAdapter(this, itemname, subitemname, imgid);
        bt = new BluetoothSPP(this);
        list = (ListView) findViewById(R.id.list);
        list.setAdapter(adapter);
        list.setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {
                // TODO Auto-generated method stub
                String Selecteditem = itemname[position];
                //Toast.makeText(getApplicationContext(), Selecteditem, Toast.LENGTH_SHORT).show();
                switch (position) {
                    case 0:
                        startNewActivity();
                        break;
                    case 1:
                        settingsActivity();
                        break;
                    case 2:
                        HelpActivity();
                        break;
                    case 3:
                        startAboutActivity();
                        break;
                    case 4:
                        startErrorActivity();
                        break;
                    case 5:
                        InputDeviceName();
                        break;

                }

            }
        });
        mSettings = getSharedPreferences(APP_PREFERENCES, Context.MODE_PRIVATE);
        if (mSettings.contains(APP_PREFERENCES_COUNTER)) {
            // Получаем число из настроек
            time = mSettings.getInt(APP_PREFERENCES_COUNTER, 0);
        }
        if (mSettings.contains(APP_PREFERENCES_BTU_NAME)) {
            // Получаем имя модуля  из настроек
            btu_name = mSettings.getString(APP_PREFERENCES_BTU_NAME, "HC-06");

        }
    }
    @Override
    protected void onStart() {
        super.onStart();
        accessLocationPermission();
        if (!bt.isBluetoothEnabled()) {
            Intent intent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(intent, BluetoothState.REQUEST_ENABLE_BT);
        }
    }
    //==============================================================================================
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == BluetoothState.REQUEST_ENABLE_BT) {
            if (resultCode == Activity.RESULT_OK) {
                Toast.makeText(getApplicationContext()
                        , getResources().getString(R.string.btu_en_text)
                        , Toast.LENGTH_LONG).show();

            } else {
                Toast.makeText(getApplicationContext()
                        , getResources().getString(R.string.not_btu)
                        , Toast.LENGTH_SHORT).show();
            }
        }
    }
    //==============================================================================================
    public String getBtName() {
        return m_Text;
    }

    public void setBtName(String name) {
        m_Text = name;
    }

    public void HelpActivity() {
        Intent intent = new Intent(this, HelpActivity.class);
        startActivity(intent);
    }

    //==============================================================================================
    public void startAboutActivity()
    {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
        LayoutInflater inflater = this.getLayoutInflater();
        final View dialogView = inflater.inflate(R.layout.custom_about_dialog, null);
        dialogBuilder.setView(dialogView);

        final TextView timeDelayValue = (TextView) dialogView.findViewById(R.id.about_text);
        dialogBuilder.setTitle(getResources().getString(R.string.about));
        //dialogBuilder.setMessage("Введите время опроса,мсек");
        dialogBuilder.setIcon(R.mipmap.zoom);
        dialogBuilder.setCancelable(false);
        dialogBuilder.setPositiveButton(getResources().getString(R.string.ok), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {

            }
        });
//        dialogBuilder.setNegativeButton("Отменить", new DialogInterface.OnClickListener() {
//            public void onClick(DialogInterface dialog, int whichButton) {
//
//            }
//        });
        AlertDialog b = dialogBuilder.create();
        b.show();
    }
    //==============================================================================================
    public void startNewActivity() {
        if (time == 0) {
            //Toast.makeText(this, getResources().getString(R.string.enter_time), Toast.LENGTH_SHORT).show();
            settingsActivity();
        } else {
            if (!bt.isBluetoothEnabled()) {
                Intent intent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(intent, BluetoothState.REQUEST_ENABLE_BT);
            }
            else {
                Intent intent = new Intent(this, ProcessActivity.class);
                intent.putExtra("tDelay", time);
                startActivity(intent);
                finish();
            }
        }
    }

    //==============================================================================================
    public void startErrorActivity()
    {
        Intent intent = new Intent(this, errorsActivity.class);
        startActivity(intent);
        finish();
    }

    //==============================================================================================
    public void settingsActivity() {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
        LayoutInflater inflater = this.getLayoutInflater();
        final View dialogView = inflater.inflate(R.layout.custom_dialog, null);
        dialogBuilder.setView(dialogView);

        final EditText timeDelayValue = (EditText) dialogView.findViewById(R.id.edit1);
        timeDelayValue.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL);

        timeDelayValue.setText(String.format("%d", time));
        dialogBuilder.setTitle(getResources().getString(R.string.settings));
        dialogBuilder.setMessage(getResources().getString(R.string.enter_time));
        dialogBuilder.setIcon(R.mipmap.alarm);
        dialogBuilder.setCancelable(false);
        dialogBuilder.setPositiveButton(getResources().getString(R.string.ok), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                //do something with edt.getText().toString();
                if (timeDelayValue.getText().toString().isEmpty()) {
                    timeDelayValue.setText("0");
                    settingsActivity();
                }
                time = Integer.parseInt(timeDelayValue.getText().toString());
                if (time < 500 || time > 5000) {
                    time = 500;
                }
                SharedPreferences.Editor editor = mSettings.edit();
                editor.putInt(APP_PREFERENCES_COUNTER, time);
                editor.apply();
                Log.i("Check", String.format("Save change time var = %d", time));
            }
        });
        dialogBuilder.setNegativeButton(getResources().getString(R.string.cancel), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                if (timeDelayValue.getText().toString().isEmpty()) {
                    timeDelayValue.setText("0");
                    settingsActivity();
                }
                else
                {
                    SharedPreferences.Editor editor = mSettings.edit();
                    editor.putInt(APP_PREFERENCES_COUNTER, time);
                    editor.apply();
                    Log.i("Check", String.format("Save no change time var = %d", time));
                }

            }
        });
        AlertDialog b = dialogBuilder.create();
        b.show();
    }

    //==============================================================================================
    static final int REQUEST_CODE_LOC = 100;
    private void accessLocationPermission() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            int accessCoarseLocation = checkSelfPermission(android.Manifest.permission.ACCESS_COARSE_LOCATION);
            int accessFineLocation = checkSelfPermission(android.Manifest.permission.ACCESS_FINE_LOCATION);

            List<String> listRequestPermission = new ArrayList<String>();

            if (accessCoarseLocation != PackageManager.PERMISSION_GRANTED) {
        listRequestPermission.add(android.Manifest.permission.ACCESS_COARSE_LOCATION);
    }
            if (accessFineLocation != PackageManager.PERMISSION_GRANTED) {
        listRequestPermission.add(android.Manifest.permission.ACCESS_FINE_LOCATION);
    }

            if (!listRequestPermission.isEmpty()) {
        String[] strRequestPermission = listRequestPermission.toArray(new String[listRequestPermission.size()]);
        requestPermissions(strRequestPermission, REQUEST_CODE_LOC);
    }
  }
}
    //==============================================================================================
    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        switch (requestCode) {
            case REQUEST_CODE_LOC:
                if (grantResults.length > 0) {
                    for (int gr : grantResults) {
                        // Check if request is granted or not
                        if (gr != PackageManager.PERMISSION_GRANTED) {
                            return;
                        }
                    }

                    //TODO - Add your code here to start Discovery

                }
                break;
            default:
                return;
        }
    }
    //==============================================================================================
    public void InputDeviceName() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(getResources().getString(R.string.device_name));
        builder.setIcon(R.mipmap.alarm);

        // Set up the input
        final EditText input = new EditText(this);
        // Specify the type of input expected; this, for example, sets the input as a password, and will mask the text
        input.setInputType(InputType.TYPE_CLASS_TEXT);
        builder.setView(input);
        builder.setCancelable(false);
        input.setText(btu_name);

        // Set up the buttons
        builder.setPositiveButton(getResources().getString(R.string.ok), new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                btu_name = input.getText().toString();
                if (btu_name.isEmpty()) {
                    InputDeviceName();
                }
                else
                {
                    SharedPreferences.Editor editor = mSettings.edit();
                    editor.putString(APP_PREFERENCES_BTU_NAME, btu_name);
                    editor.apply();
                }


            }
        });
        builder.setNegativeButton(getResources().getString(R.string.cancel), new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();

            }
        });
        builder.show();
    }

    //==============================================================================================
}