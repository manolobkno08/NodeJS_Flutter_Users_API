// Initiallize server
const app = require('./app');

// Import database module
const { connect } = require('./database');

async function main() {
	try {
		// Database connection
		await connect();
		// Express connection : await server take few minutes before to start
		await app.listen(4000);
		console.log('Server on port 4000: Connected');
	} catch (error) {
		console.log("Couldn't connect to database/Server");
		console.error(error.message);
	}
}

main();
