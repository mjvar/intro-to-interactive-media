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