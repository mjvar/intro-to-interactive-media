# Assignment 4 - Personal Flight Visualization

An interactive visualization of all the flights I've ever taken.

<img src="sample.gif" width="500">

### Process
Any individual "flight" has an origin, destination, and year of travel. I used a class called `Flight` to represent these, which made coding the interactive part a lot easier.

Since this is a personal dataset, I manually made the CSV. I then loaded each entry of the CSV into `Flight` objects and displayed each.

When you mouse over any particular location, it shows any flights you've taken to or from that location and highlights those connections.

I initially wanted to overlay these on a map, but with all the different kinds of map projections, coordinate systems, and varying screen sizes I realized it would be pretty messy. Instead, I went for this more deconstructed, minimalist look. I think it still says a lot of interesting things about my flight history – it looks pretty horizontal, because I haven't much been to South America or Africa. Most of my flights come from Manila (go figure since I lived there for 18 years). It's kind of nostalgic to see all my flight data in front of me, a visual history of my adventures.

One annoying little quirk of p5.js is that when running a sketch locally, you can't load files (like CSVs or images) within p5 without running a local web server. Thankfully, this was easy to do using a Chrome browser extension.

I also had to set the text display to align left or right depending on where the mouse is on the screen. I think this is an interesting example of how there are lots of tiny quality-of-life improvements you can make to a data visualization that might not be very flashy or noticeable in the final product, but are still important so that the data is communicated clearly.

I also had a cool idea for a website where anyone can plot out their own flight history. When I have time, I'll definitely turn this into a full-fledged webapp people can use for their own flights. I didn't quite have time to develop it over the weekend since I would have to work with some sort of geocoding API (LocationIQ is free and looks like a good choice for when I do this in the future), develop a backend for the geocoder to communicate with the visualization, probably settle on a particular map projection and coordinate system to display an actual world map, and host it on Heroku. For now, though, I enjoyed visualizing my own personal flight data, and I'm glad I have somewhere to start when I finish the full website in the future.