#include <SPI.h>
#include <Ethernet.h>
#include <ArduinoRS485.h> 
#include <ArduinoModbus.h>
//#include <Adafruit_Sensor.h>
#include "DHT.h"

byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
byte ip[] = {10,12,1,200};
byte subnet[] = {255,255,255,0};
byte gateway[] = {10,12,1,0};
byte dns[] = {8,8,8,8};

EthernetServer Eth(503);
ModbusTCPServer Mts;
DHT dht(2,DHT11);

void setup() 
{
  Ethernet.init(10); 
  pinMode(4,OUTPUT);
  digitalWrite(4,HIGH);
  Serial.begin(9600);
  //Ethernet.begin(mac, ip);
  Ethernet.begin(mac, ip, subnet, gateway, dns);
  delay(1000);
  Serial.println(Ethernet.localIP());
  dht.begin();
  Eth.begin();
  Mts.begin();
  Mts.configureHoldingRegisters(0x01,2);
}

void loop() 
{
  static uint16_t temp,hum;
  hum=dht.readHumidity();
  temp=dht.readTemperature();
  Serial.println(hum);
  Serial.println(temp);
  delay(100);
  Serial.println(Ethernet.localIP());
  
  Mts.holdingRegisterWrite(0x01,temp);
  Mts.holdingRegisterWrite(0x02,hum);
  EthernetClient client = Eth.available();
  
  if (client) 
  {
    Serial.println("new client");
    Mts.accept(client);
    while (client.connected()) 
    {
      Mts.poll();
      delay(1000);
      jToS();
     }
  
  }  
  
}
void jToS()
{
  
}
