# Midterm Project - Bullet Time

Inspired by the first-person shooter [Superhot](https://www.google.com/search?q=superhot&oq=superhot&aqs=chrome..69i57.794j0j1&sourceid=chrome&ie=UTF-8), I want to make a side-scrolling shooter where the player can slow down time to dodge bullets and precisely control their character. One of the main features I want to implement is a catchy, high-octane original soundtrack that also slows down when the player slows time.

Journal of progress:

### October 15
Today I began composing the soundtrack for the game and implementing some basic things in Processing. I was able to finish a draft of the soundtrack and get smooth transitions between fast/slow music using the `processing.sound` library. 

Unfortunately I can't find a way to only modify pitch or speed – I have to change both when I change the sound file's `.rate()`. This seems to be true for p5.js as well, so I'll just have to live with it.

### October 18
I polished the soundtrack of the game, adding more variation and tonality so the player doesn't get tired of it. I also ported what I have so far of my project onto p5.js. I realized that this is something I'd want to easily share with others once it's done, which is why I want it to live in a browser window instead of a Processing sketch.

I also did a bit more thinking about what I want the gameplay to be like. I figure it would be interesting for the game to last infinitely, with difficulty scaling automatically as time moves on. I can procedurally generate more and more enemies as the player lives longer. 

Thinking about the visual aesthetic of the game, I want it to match the techno-y, funky vibe of the soundtrack I wrote. I should probably use lots of purples and blues for the color palette, to fit a cyberpunk-esque theme. I also think 8-bit sprites would be a good fit for the game's mood.