// create server service by Express module
const express = require('express');
const app = express();
// import morgan module - show obtained requests
const morgan = require('morgan');
app.use(morgan('dev'));

// import cors module that allow external connections to my server
const cors = require('cors');
app.use(cors('cors'));

// import route module from users
app.use(require('./routes/users'));

module.exports = app;
