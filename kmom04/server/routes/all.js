/*
* routes/all.js
* return ./data/items.json
*/

var express = require('express');
var router = express.Router();

const items = require('../data/items.json');


router.get('/', function (req, res) {
    // console.log(items);
    res.json(items);
});


module.exports = router;
