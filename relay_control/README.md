The purpose of this project is to program the Basys3 to act as a relay control for the IoT Power Relay II. The Basys3 digitizes the analog output from a Terranova 926A pressure gauge controller and analyzes the input. If the input voltage is less than 0.5V, the Basys3 provides the 3.3V logic needed to the Power Relay II. If at any point the voltage rises above 0.5V (equivalent to ~500mTorr on the controller), the 3.3V is cut - causing the auto-lock valve to close and prevent any turbo pump anomaly.

The Seven Segment Display Codes and some more details can be found here: https://digilent.com/reference/programmable-logic/basys-3/demos/xadc

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/relay_control.png)

![Fail](https://github.com/brady-ryan/basys3_fpga/blob/main/images/relay.jpg)