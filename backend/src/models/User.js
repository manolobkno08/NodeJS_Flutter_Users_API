// Import module to create schema.
const { Schema, model } = require('mongoose');

const userSchema = new Schema({
	firstName: String,
	lastName: String,
	// The images will be create as String (address storage)
	avatar: String
});

// Export model object that allow interaction with the application
module.exports = model('User', userSchema);
