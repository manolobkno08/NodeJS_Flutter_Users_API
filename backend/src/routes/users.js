// Import express module to create routes
const { Router } = require('express');
const router = Router();

// Calling db models
const User = require('../models/User')
// Import faker module that allow create mock data
const { faker } = require('@faker-js/faker');

// GET Users
router.get('/api/users', async (req, res) => {
	const users = await User.find();
	// handleObject(users);
	res.json({ users: users });
});

// const handleObject = (users) => {
// 	// Through object
// 	//console.log(users);
// 	// for (item in users) {
// 	// 	console.log(users[item].firstName);
// 	// }
// 	// for (item of users) {
// 	// 	console.log(item.firstName);
// 	// }
// 	users.forEach(element => {
// 		console.log(element.firstName);
// 	});
// }

// Create new users
router.get('/api/users/create/:count', async (req, res) => {
	c = Number(req.params.count);
	console.log(c);
	for (let i = 0; i < c; i++) {
		await User.create({
			firstName: faker.name.firstName(),
			lastName: faker.name.lastName(),
			avatar: faker.image.avatar()
		});
	}
	res.json({ message: `${c} Users was created` });
});

// Delete Users
router.delete('/api/users/delete', async (req, res) => {
	try {
		await User.deleteMany();
		res.json({ message: 'Users were deleted successfully' });
	} catch (error) {
		console.log(error);
	}
});

// Export object
module.exports = router;
