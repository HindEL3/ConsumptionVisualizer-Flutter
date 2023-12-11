# sauv2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Here are some images that showcase my Flutter Application 
 ![scr3](https://github.com/HindEL3/ConsumptionVisualizer-Flutter/assets/153544537/5bcc5dab-2dbb-4d21-8a69-7a5ab4db374e)
![scr2](https://github.com/HindEL3/ConsumptionVisualizer-Flutter/assets/153544537/0f793046-da57-434d-a92f-e534b377f3ad)
![dd](https://github.com/HindEL3/ConsumptionVisualizer-Flutter/assets/153544537/9aae1587-68c6-4e14-b93c-cf46e37a235a)

 You'll find a schema & C++ code snippet for a small program designed to detect memory leaks during installation .
 ![installation](https://github.com/HindEL3/ConsumptionVisualizer-Flutter/assets/153544537/53780712-3da4-49ef-a70c-7f0c2f2569fe)

**For leak detection, we consider the following steps based on the work of an agent from RADEM (Autonomous Authority for Water and Electricity Distribution in Meknes):
1/ Record water consumption for each day between 2:00 AM and 6:00 AM.
2/ If the consumption exceeds a limit of MAX1 liters or if the consumption recorded during this period (2:00 AM-6:00 AM) over three consecutive days exceeds MAX2 (MAX2 < MAX1), then a leak is reported.
Code:
#include <Arduino.h>
#include <DS3231.h>
#include <Wire.h>
#include <SPI.h> //for the SD card module
#include <SD.h> // for the SD card
#include <RTClib.h>
// Create a file to store the data
File myFile;
// RTC
RTC_DS3231 rtc;
volatile int flow_frequency; // Measures flow sensor pulses
// Calculated litres/hour
float vol = 0.0,l_minute,D1,D2,D3;
unsigned char flowsensor = 2; // Sensor Input
unsigned long currentTime;
unsigned long cloopTime;
void flow () // Interrupt function
{
 flow_frequency++;
}
bool Leak;
const int chipSelect = 4; 
void setup()
{
 pinMode(flowsensor, INPUT);
 digitalWrite(flowsensor, HIGH); // Optional Internal Pull-Up
 Serial.begin(9600);
 
 attachInterrupt(digitalPinToInterrupt(flowsensor), flow, RISING); // Setup Interrupt
16
 
 currentTime = millis();
 cloopTime = currentTime;
 if(! rtc.begin()) {
 Serial.println("Couldn't find RTC");
 while (1);
 }
 else {
 // following line sets the RTC to the date & time this sketch was compiled
 rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
 }
 
 
 // setup for the SD card
 Serial.print("Initializing SD card...");
 if(!SD.begin(chipSelect)) {
 Serial.println("initialization failed!");
 return;
 }
 Serial.println("initialization done.");
 
 //open file
 myFile=SD.open("DATA.txt", FILE_WRITE);
 // if the file opened ok, write to it:
 if (myFile) {
 Serial.println("File opened ok");
 // print the headings for our data
 myFile.println("Date,Time,Leak,Daily Consumption,Daily Consumption(2AM-6AM),Monthly 
Consumption");
 }
 myFile.close();
17
}
int PreHour,PreTS,PreMonth,PreDay;
int MonthlyConsumption,SpecificHourConsumption,DailyConsumption;
void loop ()
{
 currentTime = millis();
 // Every second, calculate and print litres/hour
 if(currentTime >= (cloopTime + 1000))
 {
 cloopTime = currentTime; // Updates cloopTime
 if(flow_frequency != 0){
 // Pulse frequency (Hz) = 7.5Q, Q is flow rate in L/min.
 l_minute = (flow_frequency / 7.5); // (Pulse frequency x 60 min) / 7.5Q = flowrate in L/hour
 
 l_minute = l_minute/60;
 
 vol = vol +l_minute;
 
 flow_frequency = 0; // Reset Counter
 Serial.print( vol); // Print litres/hour
 Serial.println(" L");
 }
 else {
 Serial.println(" flow rate = 0 ");
 
 }
 }
 DateTime now = rtc.now(); 
 if(now.hour()!=PreHour)
 {
 MonthlyConsumption=vol+MonthlyConsumption;
 DailyConsumption=vol+DailyConsumption;
 if (now.hour()>=2 && now.hour()<=6)

{
 SpecificHourConsumption=vol+SpecificHourConsumption;
 
 }
 logging();
 PreHour=now.hour();
 }
 if(now.month()!=PreMonth)
 {
 MonthlyConsumption=0;
 PreMonth=now.month();
 }
 if(now.day()!=PreDay)
 {
 if( D1>6.0 && D2>6.0 && D3>6.0) //Consumption is more than 6 L for consecutive 3 days 
setting leak TRUE
 {
 Leak=true; 
 }
 else false;
 D3=D2;
 D2=D1;
 D1=SpecificHourConsumption;
 DailyConsumption=0;
 SpecificHourConsumption=0;
 PreDay=now.day();
 }
}
void logging() {
 DateTime now = rtc.now();
 myFile = SD.open("DATA.txt", FILE_WRITE);

 if (myFile) {
 myFile.print(now.year(), DEC);
 myFile.print('/');
 myFile.print(now.month(), DEC);
 myFile.print('/');
 myFile.print(now.day(), DEC);
 myFile.print(',');
 myFile.print(now.hour(), DEC);
 myFile.print(':');
 myFile.print(now.minute(), DEC);
 myFile.print(':');
 myFile.print(now.second(), DEC);
 myFile.print(",");
 myFile.print(Leak);
 myFile.print(",");
 myFile.print(DailyConsumption);
 myFile.print(",");
 myFile.print(SpecificHourConsumption);
 myFile.print(",");
 myFile.print( MonthlyConsumption);
 }
 Serial.print(now.year(), DEC);
 Serial.print('/');
 Serial.print(now.month(), DEC);
 Serial.print('/');
 Serial.println(now.day(), DEC);
 Serial.print(now.hour(), DEC);
 Serial.print(':');
 Serial.print(now.minute(), DEC);
 Serial.print(':');
 Serial.println(now.second(), DEC);

 myFile.close();
 delay(1000); 
}

 

