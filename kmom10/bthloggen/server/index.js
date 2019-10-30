/*
* vlinux
* kmom10
*/

const express = require('express');
const app = express();

const port = 1337;

//Req routes
const home = require('./routes/home');
const data = require('./routes/data');

const bodyParser = require("body-parser"); //Handle spaces and ÅÄÖ

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

/* ROUTES  */
app.use('/', home);
app.use('/home', home);
app.use('/data', data);

app.listen(port, () => console.log('Server is now running and listening on: ', port));
