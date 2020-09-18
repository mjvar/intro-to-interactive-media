# Assignment 2 - Procedural Map Generation with Voronoi Tessellations

This Processing sketch generates maps (for use in games, Dungeons & Dragons campaigns, etc.) from Voronoi tessellations. This was a really interesting project to work on!

### INSTRUCTIONS:
Click on the map to draw a rough shape;
press ENTER to generate the map.

## Development Process

### 1. Voronoi Tessellations

To start, what is a Voronoi tessellation? Essentially, it's a plane partitioned into regions based on any given point's closeness to a given set of objects. For the purposes of this project, I randomly plotted points on the canvas, and generated Voronoi tessellations from those:

<img src="voronoi-euclidean.png" alt="voronoi diagram" width="400"/>

### 2. Generating Land

Now that we have our Voronoi diagram, we can select certain tiles from it to use as "land"! The reason this is nice is because instead of just drawing, say, a regular circle, a Voronoi diagram introduces some irregularity on shape borders. This makes the map a bit more realistic.

For this sketch, I drew an imaginary circle in the center of the canvas. Then, any of the Voronoi tiles whose points fell within that circle counted as "land". Here's what that selection would look like:

<img src="land-restriction.png" alt="land tiles" width="400"/>

### 3. Prettifying

We now have quasi-realistic borders for our imaginary island, but it doesn't look much like an island. We can fix that by drawing the land tiles in green:

<img src="land-viz.png" alt="land visualization" width="400"/>

One thing to note about this project is that I didn't generate the points for the Voronoi diagram entirely randomly. Instead, I drew them in an even grid, then agitated them slightly to add more variation. In fact, we can see how the "smoothness" of the island borders changes based on how fine the grid is! Here's an example where I drew points in an 8x8 grid, which is much rougher:

<img src="dotdim8.png" alt="8x8 grid" width="400"/>

And here's what the map looks like with a 50x50 grid, which is much more granular:

<img src="dotdim50.png" alt="50x50 grid" width="400"/>

### 4. Map Features

We can now add more variation and character to our maps. First, I introduced a bit of randomness so that some "land" tiles would be converted to water tiles (like lakes or ponds!) and some water tiles would be converted to tiny offshore islands. That gives us this result:

<img src="random-water-islands.png" alt="8x8 grid" width="400"/>

Next, I want to fix the textures to resemble an actual map. For this feature, I used Perlin noise, which is a noise function built into Processing that is very useful for generating textures.

<img src="perlin-noise.png" alt="textures using Perlin noise" width="400"/>

### 5. Interactivity

I wanted to give the user some control over the map that was generated. To do this, I let the user plot a certain number of points. These points would be used as a rough basis for the shape of the island (i.e. which tiles would be selected as "land"). This was the result:



### 6. Manhattan Distance Calculation

I was still a little unhappy with the map shapes, so I looked into using Manhattan distance calculation rather than Euclidean for the Voronoi diagram. In short, this constrained all edges to 8 directions. I think the result looks a bit cleaner:


### Conclusion

Overall, I'm pretty happy with how this project turned out! If I spent more time on it I could definitely refine a lot of the features, and maybe add more terrain variation (biomes/rivers/elevation). Given that I made most of it in an afternoon, though, I'm pleased with the end result.

More samples:
<img src="final-1.png" alt="sample of final output" width="400"/>
<img src="final-2.png" alt="sample of final output" width="400"/>

Learning resources:
[Voronoi Diagrams and Procedural Map Generation](https://www.youtube.com/watch?v=3G5d8ob_Lfo)
[Polygon Map Generation for Games](http://www-cs-students.stanford.edu/~amitp/game-programming/polygon-map-generation/)
[Worley Noise with Daniel Shiffman](https://www.youtube.com/watch?v=4066MndcyCk&t=28s)
