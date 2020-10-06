// Matthew Varona - October 6, 2020
// A visualization of flights I've taken throughout my life.
// Mouse over any circle (a "location") to highlight its connections
// and see a list of all flights you've taken to or from that location.

let flights;
let flightObjects = [];

function windowResized() {
	// Adjust canvas height to window height
	resizeCanvas(windowWidth, windowHeight);
}

function preload() {
	// Load .csv into table before showing page
	flights = loadTable("flight_data.csv","csv","header");
}

function setup() {
	// Adjust canvas height to window height
	canvas = createCanvas(windowWidth, windowHeight);

	// Load flight data from table to objects
	// Had to be done in setup because
	// doing it in preload() broke it
	loadFlights();
}

function draw() {
	background(32, 32, 64);

	// Display flights
	displayAll();
}