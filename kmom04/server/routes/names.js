/*
* routes/names.js
* return all names in ../data/items.json
*/
var express = require('express');
var router = express.Router();

router.get('/', function (req, res) {
    const items = require('../data/items.json');
    let names = [];

    for (let i = 0; i < items.items.length; i++) {
        names.push(items.items[i].name);
    }

    res.json(names);
});

module.exports = router;
