#include "DemoApp.h"

configuration DemoAppC{}
implementation{
	components DemoP, MainC, LedsC;
	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	components new TimerMilliC() as Timer2;
	components new HamamatsuS10871TsrC() as LightSensor;
	components new SensirionSht11C() as HumiditySensor;
	components new SensirionSht11C() as TemperatureSensor;
	components new AMSenderC(AM_L_MESSAGE) as LightSend, new AMReceiverC(AM_L_MESSAGE) as LightReceive; // light
	components new AMSenderC(AM_H_MESSAGE) as HumiditySend, new AMReceiverC(AM_H_MESSAGE) as HumidityReceive; // humidity
	components new AMSenderC(AM_T_MESSAGE) as TemperatureSend, new AMReceiverC(AM_T_MESSAGE) as TemperatureReceive; // temperature
	components SerialActiveMessageC as SerialC;
	components ActiveMessageC;
	
	DemoP.Boot -> MainC;
	DemoP.LightRead -> LightSensor;
	DemoP.HumidityRead -> HumiditySensor.Humidity;
	DemoP.TemperatureRead -> TemperatureSensor.Temperature;
	DemoP.RadioControl -> ActiveMessageC;
	DemoP.LightSend -> LightSend;
	DemoP.HumiditySend -> HumiditySend;
	DemoP.TemperatureSend -> TemperatureSend;
	DemoP.LightReceive -> LightReceive;
	DemoP.HumidityReceive -> HumidityReceive;
	DemoP.TemperatureReceive -> TemperatureReceive;
	DemoP.Packet -> ActiveMessageC;
	DemoP.SerialControl -> SerialC;
	DemoP.SerialAMSendLight -> SerialC.AMSend[AM_L_MESSAGE];
	DemoP.SerialAMSendHumidity -> SerialC.AMSend[AM_H_MESSAGE];
	DemoP.SerialAMSendTemperature -> SerialC.AMSend[AM_T_MESSAGE];
	DemoP.SerialPacketLight -> SerialC;
	DemoP.SerialPacketHumidity -> SerialC;
	DemoP.SerialPacketTemperature -> SerialC;
	DemoP.Leds -> LedsC;
	DemoP.Timer0 -> Timer0;
	DemoP.Timer1 -> Timer1;
	DemoP.Timer2 -> Timer2;
}
