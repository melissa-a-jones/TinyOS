# TinyOS
A tinyOS sensor project.

Programming Assignment (480I/580I Spring 2020)

In every second, Sensor 1 (Network ID = 1) measures the ambient light intensity, transmits a
packet which carries the light reading to Sensor 2 (Network ID = 2), and toggles the onboard red
LED after finish the transmission.
In every two seconds, Sensor 1 measures the humidity, transmits a packet which carries the
humidity reading to Sensor 2, and toggles the onboard green LED after finish the transmission.
In every three seconds, Sensor 1 measures the temperature, transmits a packet which carries the
temperature reading to Sensor 2, and toggles the onboard blue LED after finish the transmission.
Sensor 2 toggles the red LED when receiving a light reading and forwards the data to the
computer.
Sensor 2 toggles the green LED when receiving a humidity reading and forwards the data to the
computer.
Sensor 2 toggles the blue LED when receiving a temperature reading and forwards the data to
the computer.
Computer displays the readings in a terminal.

Additional Requirements:
1. Please define three kinds of packets and use different kinds of packets to carry different
kinds of data.
2. Please use one implementation for both Sensor 1 and Sensor 2

3. Please provide comments for each function block and a readme on how to compile and
run your code
