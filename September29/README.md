# Assignment 3 - Object-Oriented Art

This sketch was meant to be a simulation of some kind of alien writing system. To do so, I created a "glyph" object which is a rectangle with 6 points. I then drew each object with a bit of randomness.

<img src="glyphs.png" alt="sample of project" width="400"/>

The piece was inspired by this post from @revdancatt on Instagram:

<img src="inspo.jpg" alt="project inspo" width="400"/>


### Learnings
Using OOP was useful here so I could have a class-based function to draw an individual glyph. After that, it was just a matter of looping through an ArrayList of glyph objects. I used a random variable to draw each line of each shape, and lowered the likelihood of a line being drawn the lower the shape was on the canvas.

I also generated a bit of Perlin noise in the background to add some interest.

Other than that, it was a fairly simple project so I don't have much to write about.
