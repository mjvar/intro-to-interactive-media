// Diameter for circles of airport
const diameter = 70;

// Class for any given flight.
// Contains origin and destination coordinates,
// origin and destination names, and year of travel.
class Flight{
	constructor(x1, y1, x2, y2, from, to, year){
		this.x1 = x1;
		this.x2 = x2;
		this.y1 = y1;
		this.y2 = y2;
		this.from = from;
		this.to = to;
		this.year = year;
		this.mouseOver = false;
	}

	// Draw origin, destination, and line for this flight
	drawFlight(){
		push();
		// Change alpha or stroke based on mouse over
		let alpha = this.mouseOver ? 255 : 50;
		let weight = this.mouseOver ? 2 : 1;
		noFill();
		stroke(255, 190, 105,alpha*2);
		strokeWeight(weight);
		line(this.x1, this.y1, this.x2, this.y2);

		strokeWeight(3);
		stroke(255, 99, 99);
		fill(255, 99, 99, alpha/2);
		ellipse(this.x1, this.y1, diameter, diameter);
		ellipse(this.x2, this.y2, diameter, diameter);
		pop();
	}

	// Checks if mouse is in circle
	checkMouse(){
		if(dist(mouseX, mouseY, this.x1, this.y1) < diameter/2 || dist(mouseX, mouseY, this.x2, this.y2) < diameter/2) {
			this.mouseOver = true;
		} else {
			this.mouseOver = false;
		}
	}
}

// Load flights from table into objects
function loadFlights() {
	for (let x = 0; x < flights.getRowCount(); x++){
		flightObjects[x] = new Flight(
			// Here we map the latitude and longitude
			// to stay within the canvas
			map(flights.getColumn("from_lon")[x],
				-180,180,0,width),
			map(flights.getColumn("from_lat")[x],
				-10,70,height,0),
			map(flights.getColumn("to_lon")[x],
				-180,180,0,width),
			map(flights.getColumn("to_lat")[x],
				-10,70,height,0),
			flights.getColumn("from_name")[x],
			flights.getColumn("to_name")[x],
			flights.getColumn("year")[x]);
	}
}

// Displays all flight data
function displayAll() {
	// info is the array of flights that are
	// currently being moused over
	let info = [];
	for(let x = 0; x < flights.getRowCount(); x++) {
		// Every frame, check if each flight is being moused over
		flightObjects[x].checkMouse();
		flightObjects[x].drawFlight();
		if(flightObjects[x].mouseOver) {
			append(info, flightObjects[x]);
		}
	}

	// Have a single string for all flight data
	// to be shown in this frame
	let displayText = "";
	for(let x = 0; x < info.length; x++) {
		// Construct a line of format
		// "Manila -> Abu Dhabi, 2020"
		displayText += info[x].from
			+ " -> " + info[x].to
			+ ", " + info[x].year + "\n";
	}

	// Display text
	noStroke();
	fill(84, 56, 100);
	textSize(30);

	// Change text align based on position of circle
	if(mouseX > width/2){
		textAlign(RIGHT, BOTTOM);
	} else {
		textAlign(LEFT, BOTTOM);
	}
	text(displayText, mouseX, mouseY);
	fill(255);
	text(displayText, mouseX-2, mouseY-2);
}