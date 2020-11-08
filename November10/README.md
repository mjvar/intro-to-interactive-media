# November 10 Production Assignment – Siren

Using a potentiometer, a button, two single-color LEDS, and a multicolor LED, I made a simple siren like one might see on an ambulance or police car. (Low GIF framerate limits make the fast blinking hard to see, but it's there!)

<image src="siren.gif" width="500px">

The siren alternates flashing the red and blue LEDS, while the multicolor LED oscillates between red and blue. Pushing the button turns it on or off, while turning the knob changes the flashing speed.

The main challenge was neatly routing so many wires and resistors for the lights part (since the multicolor LED essentially counts as 3 LEDs). Also, I had to figure out logic for the button to work as a toggle instead of only changing when held. While making it I actually spent 15 minutes trying to fix a problem where the LEDs weren't turning on, until I realized that the LEDs just weren't connected to ground. Oops!

Schematic:

<image src="schematic.jpg" width="500px">