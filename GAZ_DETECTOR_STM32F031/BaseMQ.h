#include "hider.h"

#ifndef BaseMQ_H
#define BaseMQ_H
#include <Arduino.h>
// кол-во считываний значений в цикле
#define MQ_SAMPLE_TIMES 5
// задержка после каждого считывания датчика
#define MQ_SAMPLE_INTERVAL 20

        BaseMQ(uint8_t pin);
        BaseMQ(uint8_t pin, uint8_t pinHeater);
        void calibrate();
        void calibrate(float ro);
        void heaterPwrHigh();
        void heaterPwrLow();
        void heaterPwrOff();
        void cycleHeat();
        unsigned char atHeatCycleEnd();
        unsigned char heatingCompleted() const;
        unsigned char coolanceCompleted() const;
        float readRatio() const;
        unsigned char isCalibrated() const {
                return _stateCalibrate;
        };
        float getRo() const {
                return _ro;
        };


        unsigned long readScaled(float a, float b);
        float getRoInCleanAir();
        int getRL();


        unsigned char _heater;
        unsigned char _cooler;
        unsigned char _stateCalibrate;
        unsigned long _prMillis = 0;
        float _ro = 1.0f;
        uint8_t _pin;
        uint8_t _pinHeater;
        float readRs();
        float calculateResistance(int rawAdc);
#endif