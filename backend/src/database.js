const mongoose = require("mongoose");

async function connect() {
	// Async query
	await mongoose.connect('mongodb://localhost/node_tutorial', {
		// Don't show warnings on screen
		useNewUrlParser: true,
	});
	console.log('Database: Connected');
}

// Export DB function
module.exports = { connect };
