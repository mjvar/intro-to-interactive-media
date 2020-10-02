# Assignment 4 - Personal Flight Visualization

An interactive visualization of all the flights I've ever taken.

<img src="sample.gif" width="500">

### Process
Since this is a personal dataset, I manually made the CSV. I then loaded that CSV into `Flight` objects and displayed each.

When you mouse over any particular location, it shows any flights you've taken to or from that location.

I initially wanted to overlay these on a map, but with all the different kinds of map projections and varying screen sizes I realized it would be pretty messy. Instead, I went for this more deconstructed, minimalist look. I think it still says a lot of interesting things about my flight history – it looks pretty horizontal, because I haven't much been to South America or Africa. Most of my flights come from Manila (go figure since I lived there for 18 years). It's kind of nostalgic to see all my flight data in front of me, a visual history of my adventures.

One annoying little quirk of p5.js is that when running a sketch locally, you can't load files (like CSVs or images) within p5 without running a local web server. Thankfully, this was easy to do using a Chrome browser extension.

I also had a cool idea for a website where anyone can plot out their own flight history. When I have time, I'll definitely turn this into a full-fledged webapp people can use for their own flights.