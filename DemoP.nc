#include <stdio.h>
#include <string.h>

module DemoP{
	uses interface Boot; //needed to start
	uses interface Timer<TMilli> as Timer0; //1 sec timer
	uses interface Timer<TMilli> as Timer1; //2 sec timer
	uses interface Timer<TMilli> as Timer2; //3 sec timer
	uses interface Read<uint16_t> as LightRead; //light data
	uses interface Read<uint16_t> as HumidityRead; //humidity data
	uses interface Read<uint16_t> as TemperatureRead; //temperature data
	uses interface SplitControl as RadioControl; //Radio
	uses interface AMSend as LightSend; //Radio
	uses interface Receive as LightReceive; //Radio
	uses interface AMSend as HumiditySend; //Radio
	uses interface Receive as HumidityReceive; //Radio
	uses interface AMSend as TemperatureSend; //Radio
	uses interface Receive as TemperatureReceive; //Radio
	uses interface Packet; //Radio
	uses interface SplitControl as SerialControl; //PC
	uses interface Packet as SerialPacketLight; //PC
	uses interface AMSend as SerialAMSendLight; //PC
	uses interface Packet as SerialPacketHumidity; //PC
	uses interface AMSend as SerialAMSendHumidity; //PC
	uses interface Packet as SerialPacketTemperature; //PC
	uses interface AMSend as SerialAMSendTemperature; //PC
	uses interface Leds;
}
implementation{
	message_t lbuf;
	message_t *lreceivedBuf;
	message_t hbuf;
	message_t *hreceivedBuf;
	message_t tbuf;
	message_t *treceivedBuf;
	task void LightreadSensor();
	task void LightsendPacket();
	task void HumidityreadSensor();
	task void HumiditysendPacket();
	task void TemperaturereadSensor();
	task void TemperaturesendPacket();
	task void sendSerialPacketLight();
	task void sendSerialPacketHumidity();
	task void sendSerialPacketTemperature();
	event void Boot.booted(){
		call RadioControl.start();//start both radios
		if(TOS_NODE_ID == 2){
			call SerialControl.start();//start the PC
		}
	}
	event void RadioControl.startDone(error_t err){
		if(TOS_NODE_ID == 1){
			call Timer0.startPeriodic(1000);
			call Timer1.startPeriodic(2000);
			call Timer2.startPeriodic(3000);
		}
	}
	event void Timer0.fired(){
		post LightreadSensor();
	}
	event void Timer1.fired(){
		post HumidityreadSensor();
	}
	event void Timer2.fired(){
		post TemperaturereadSensor();
	}
	event void RadioControl.stopDone(error_t err){}
	event void SerialControl.startDone(error_t err){}
	event void SerialControl.stopDone(error_t err){}
	task void LightreadSensor(){
		if(call LightRead.read()!=SUCCESS){
			post LightreadSensor();
		}
	}
	task void HumidityreadSensor(){
		if(call HumidityRead.read()!=SUCCESS){
			post HumidityreadSensor();
		}
	}
	task void TemperaturereadSensor(){
		if(call TemperatureRead.read()!=SUCCESS){
			post TemperaturereadSensor();
		}
	}
	event void LightRead.readDone(error_t err, uint16_t value){
		if(err!=SUCCESS){
			post LightreadSensor();
		}else{
			l_message_t *payload =(l_message_t *)call Packet.getPayload(&lbuf, sizeof(l_message_t));
			payload -> lReading = value;
			post LightsendPacket();
		}
	}
	event void HumidityRead.readDone(error_t err, uint16_t value){
		if(err!=SUCCESS){
			post HumidityreadSensor();
		}else{
			h_message_t *payload =(h_message_t *)call Packet.getPayload(&hbuf, sizeof(h_message_t));
			payload -> hReading = value;
			post HumiditysendPacket();
		}
	}
	event void TemperatureRead.readDone(error_t err, uint16_t value){
		if(err!=SUCCESS){
			post TemperaturereadSensor();
		}else{
			t_message_t *payload =(t_message_t *)call Packet.getPayload(&tbuf, sizeof(t_message_t));
			payload -> tReading = value;
			post TemperaturesendPacket();
		}
	}
	task void LightsendPacket(){
		if(call LightSend.send(2, &lbuf,sizeof(l_message_t))!=SUCCESS){
			post LightsendPacket();
		}
		call Leds.led0Toggle();
	}
	task void HumiditysendPacket(){
		if(call HumiditySend.send(2, &hbuf,sizeof(h_message_t))!=SUCCESS){
			post HumiditysendPacket();
		}
		call Leds.led1Toggle();
	}
	task void TemperaturesendPacket(){
		if(call TemperatureSend.send(2, &tbuf,sizeof(t_message_t))!=SUCCESS){
			post TemperaturesendPacket();
		}
		call Leds.led2Toggle();
	}
	event void LightSend.sendDone(message_t *msg, error_t err){
		if(err!=SUCCESS){
			post LightsendPacket();
		}
	}
	event void HumiditySend.sendDone(message_t *msg, error_t err){
		if(err!=SUCCESS){
			post HumiditysendPacket();
		}
	}
	event void TemperatureSend.sendDone(message_t *msg, error_t err){
		if(err!=SUCCESS){
			post TemperaturesendPacket();
		}
	}
	event message_t *LightReceive.receive(message_t *msg, void* payload, uint8_t len){
			l_message_t * demoPayload = (l_message_t *)payload;
			call Leds.led0Toggle();
			lreceivedBuf = msg;
			post sendSerialPacketLight();
			return msg;
	}
	event message_t *HumidityReceive.receive(message_t *msg, void* payload, uint8_t len){
		h_message_t * demoPayload = (h_message_t *)payload;
		call Leds.led1Toggle();
		hreceivedBuf = msg;
		post sendSerialPacketHumidity();
		return msg;
	}
	event message_t *TemperatureReceive.receive(message_t *msg, void* payload, uint8_t len){
		t_message_t * demoPayload = (t_message_t *)payload;
		call Leds.led2Toggle();
		treceivedBuf = msg;
		post sendSerialPacketTemperature();
		return msg;
	}
	task void sendSerialPacketLight(){
		if(call SerialAMSendLight.send(AM_BROADCAST_ADDR, lreceivedBuf, sizeof(l_message_t))!=SUCCESS){
			post sendSerialPacketLight();
		}
		call Leds.led0Toggle();
	}
	task void sendSerialPacketHumidity(){
		if(call SerialAMSendHumidity.send(AM_BROADCAST_ADDR, hreceivedBuf, sizeof(h_message_t))!=SUCCESS){
			post sendSerialPacketHumidity();
		}
		call Leds.led1Toggle();
	}
	task void sendSerialPacketTemperature(){
		if(call SerialAMSendTemperature.send(AM_BROADCAST_ADDR, treceivedBuf, sizeof(t_message_t))!=SUCCESS){
			post sendSerialPacketTemperature();
		}
		call Leds.led2Toggle();
	}
	event void SerialAMSendLight.sendDone(message_t* ptr, error_t err){
		if(err!=SUCCESS){
			post sendSerialPacketLight();
		}
	}
	event void SerialAMSendHumidity.sendDone(message_t* ptr, error_t err){
		if(err!=SUCCESS){
			post sendSerialPacketHumidity();
		}
	}
	event void SerialAMSendTemperature.sendDone(message_t* ptr, error_t err){
		if(err!=SUCCESS){
			post sendSerialPacketTemperature();
		}
	}
}
