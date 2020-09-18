# Assignment 2 - Procedural Map Generation with Voronoi Tessellations

This Processing sketch generates maps (for use in games, Dungeons & Dragons campaigns, etc.) from Voronoi tessellations. This was a really interesting project to work on!

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

