import java.io.*;
import net.tinyos.message.*;
public class DemoApp implements MessageListener{
	MoteIF mote1;
	MoteIF mote2;
	MoteIF mote3;
	PrintStream outputFile = null;
	public DemoApp(){
		try{
			mote1 = new MoteIF();
			mote1.registerListener(new DemoAppMsgL(), this);
			mote2 = new MoteIF();
			mote2.registerListener(new DemoAppMsgH(), this);
			mote3 = new MoteIF();
			mote3.registerListener(new DemoAppMsgT(), this);
		}catch(Exception e){}
	}
	public void messageReceived(int dest, Message m){
		try{
			DemoAppMsgL msg = (DemoAppMsgL)m;
			int output = (msg.get_lReading());
			System.out.println("Light: " + output);
		}catch(Exception e){
			try{
				DemoAppMsgH msg = (DemoAppMsgH)m;
				int output = (msg.get_hReading());
				System.out.println("Humidity: " + output);
			}catch(Exception ex){
				DemoAppMsgT msg = (DemoAppMsgT)m;
				int output = (msg.get_tReading());
				System.out.println("Temperature: " + output);
			}
		}
	}
}
