/*
* vlinux
*/

const express = require('express');
const app = express();

const port = 1337;

//Req routes
const home = require('./routes/home');
const all = require('./routes/all');
const names = require('./routes/names');
const color = require('./routes/color');

const bodyParser = require("body-parser"); //Handle spaces and ÅÄÖ

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

/* ROUTES  */
app.use('/', home);
app.use('/all', all);
app.use('/names', names);
app.use('/color', color);

// app.get('/', (req, res) => res.send('hello from inside Docker! Changing content '));
app.get('/new', (req, res) => res.send('And this is a new page '));

app.listen(port, () => console.log('Example app som listen on port: ', port));
