package com.example.sultanov.timur.btinkubator;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class SplashActivity extends Activity {
   /** Обработчик onCreate вызывается один раз, в момент
         создания экземпляра activity. */
   Intent intent;
        @Override
        public void onCreate(Bundle savedInstanceState)
        {
            super.onCreate(savedInstanceState);
            //setTheme(R.style.Theme_Transparent);
            setContentView(R.layout.activity_splash);

            Thread logoTimer = new Thread()
            {
                public void run()
                {
                    try
                    {
                        int logoTimer = 0;
                        while(logoTimer < 3000)
                        {
                            sleep(100);
                            logoTimer = logoTimer +100;
                        };
                        intent = new Intent(getApplicationContext(), MainActivity.class);
                        startActivity(intent);
                    }
                    catch (InterruptedException e)
                    {
                        // TODO: автоматически сгенерированный блок catch.
                        e.printStackTrace();
                    }
                    finally
                    {
                        finish();
                    }
                }
            };
            logoTimer.start();
        }
    }