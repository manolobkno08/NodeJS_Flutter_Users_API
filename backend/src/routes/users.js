// Import express module to create routes
const { Router } = require('express');
const router = Router();

// Calling db models
const User = require('../models/User')
// Import faker module that allow create mock data
const { faker } = require('@faker-js/faker');

// Define root route
router.get('/api/users', async (req, res) => {
	// Return all users contained on database
	const users = await User.find();
	handleObject(users);
	res.json({ users: users });
});

const handleObject = (users) => {
	// Through object
	//console.log(users);
	// for (item in users) {
	// 	console.log(users[item].firstName);
	// }
	// for (item of users) {
	// 	console.log(item.firstName);
	// }
	users.forEach(element => {
		console.log(element.firstName);
	});
}

// Define route that allow create new users
router.get('/api/users/create', async (req, res) => {
	for (let i = 0; i < 5; i++) {
		await User.create({
			firstName: faker.name.firstName(),
			lastName: faker.name.lastName(),
			avatar: faker.image.avatar()
		});
	}
	res.json({ message: '5 Users was created' });
});

// Export object
module.exports = router;
