#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

char auth[] = "3dae0c0845c149e8a73b6bdd0bcfcd21";

char ssid[] = "Amena iphone";
char pass[] = "1234abcd";

int enA= D5;
int in1 = D4;
int in2 = D3;

int enB= D6;
int in3 = D2;
int in4 = D1;

void forward ()
{
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH);
}
void backward ()
{
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
}
void left ()
{
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
}
void right ()
{
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH);
}
void Stop ()
{
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);
}

BLYNK_WRITE(V1) 
{
  int x = param[0].asInt();
  int y = param[1].asInt();

  if (x>255 && x<768 && y>768 && y<1024) forward();
  else if (x>255 && x<768 && y>=0 && y<255) backward();
  else if (x>768 && x<1024 && y>255 && y<768) left();
  else if (x>=0 && x<255 && y>255 && y<768) right();
  else Stop();
}

void setup()
{
  Serial.begin(115200);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);
  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);
  digitalWrite(enA, HIGH);
  digitalWrite(enB, HIGH);
  Blynk.begin(auth, ssid, pass);
}

void loop()
{
  Blynk.run();
}
