package com.example.sultanov.timur.btinkubator;

import android.app.AlertDialog;
import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.InputType;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;

public class errorsActivity extends AppCompatActivity {

    ListView userList;
    DatabaseHelper databaseHelper;
    SQLiteDatabase db;
    Cursor userCursor;
    SimpleCursorAdapter userAdapter;
    Toolbar toolbar;
    long userId=0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_error);
        databaseHelper = new DatabaseHelper(this);

        userList = (ListView)findViewById(R.id.list);
        userList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                onUpdateListErr();
                delete(id);
                onUpdateListErr();
            }
        });
        onUpdateListErr();
        toolbar = (Toolbar) findViewById(R.id.error_toolbar);
        setSupportActionBar(toolbar);
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                startActivity(intent);
                finish();
            }
        });
        //toolbar.setSubtitle(R.string.app_name);
        toolbar.inflateMenu(R.menu.error_menu);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.error_menu, menu);
        return true;
    }
    //==============================================================================================
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        switch(id) {
            case R.id.action_error:
                clearErr();
                return true;
        }
        return super.onOptionsItemSelected(item);
    }
    public void onUpdateListErr() {
         // открываем подключение
        db = databaseHelper.getReadableDatabase();
        //получаем данные из бд в виде курсора
        userCursor =  db.rawQuery("select * from "+ DatabaseHelper.TABLE, null);
        // определяем, какие столбцы из курсора будут выводиться в ListView
        String[] headers = new String[] {DatabaseHelper.COLUMN_NAME, DatabaseHelper.COLUMN_YEAR};
        // создаем адаптер, передаем в него курсор
        userAdapter = new SimpleCursorAdapter(this, R.layout.error_list,
                userCursor, headers, new int[]{R.id.err_text_view, R.id.date_time_text_view}, 0);
        userList.setAdapter(userAdapter);
    }
    @Override
    public void onDestroy(){
        super.onDestroy();
        // Закрываем подключение и курсор
        db.close();
        userCursor.close();
    }
    @Override
    public void onBackPressed() {
        super.onBackPressed();
        Intent intent = new Intent(getApplicationContext(), MainActivity.class);
        startActivity(intent);
        finish();
    }
    public void delete(long userId){
        db = databaseHelper.getWritableDatabase();
        db.delete(DatabaseHelper.TABLE, "_id = ?", new String[]{String.valueOf(userId)});
        db.close();
    }
    public void save(String name,String dateTime){
        db = databaseHelper.getWritableDatabase();
        ContentValues cv = new ContentValues();
        cv.put(DatabaseHelper.COLUMN_NAME, name);
        cv.put(DatabaseHelper.COLUMN_YEAR, dateTime);

        //if (userId > 0) {
          //  db.update(DatabaseHelper.TABLE, cv, DatabaseHelper.COLUMN_ID + "=" + String.valueOf(userId), null);
        //} else {
            db.insert(DatabaseHelper.TABLE, null, cv);
       // }
        db.close();
    }
    public void saveError()
    {
        save("timur","1212");
        onUpdateListErr();
    }
    public void clearErr()
    {
        if(db.delete(DatabaseHelper.TABLE, null, null)==0) {
            controlEndClearDB();
        }
        else
        {
            onUpdateListErr();
            endClearDB();
        }
    }
    public void endClearDB()
    {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
        dialogBuilder.setTitle(getResources().getString(R.string.delete));
        dialogBuilder.setMessage(getResources().getString(R.string.delete_complete));
        dialogBuilder.setIcon(R.mipmap.alarm);
        dialogBuilder.setCancelable(false);
        dialogBuilder.setPositiveButton(getResources().getString(R.string.ok), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                onBackPressed();
            }
        });
//        dialogBuilder.setNegativeButton("Отменить", new DialogInterface.OnClickListener() {
//            public void onClick(DialogInterface dialog, int whichButton) {
//
//
//            }
//        });
        AlertDialog b = dialogBuilder.create();
        b.show();
    }
    public void controlEndClearDB()
    {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
        dialogBuilder.setTitle(getResources().getString(R.string.delete));
        dialogBuilder.setMessage(getResources().getString(R.string.empty_ls));
        dialogBuilder.setIcon(R.mipmap.alarm);
        dialogBuilder.setCancelable(false);
        dialogBuilder.setPositiveButton(getResources().getString(R.string.ok), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                onBackPressed();
            }
        });
//        dialogBuilder.setNegativeButton("Отменить", new DialogInterface.OnClickListener() {
//            public void onClick(DialogInterface dialog, int whichButton) {
//
//
//            }
//        });
        AlertDialog b = dialogBuilder.create();
        b.show();
    }

}