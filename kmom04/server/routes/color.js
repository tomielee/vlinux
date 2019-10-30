/*
* routes/color/:color.js
* return all chilis in a :color
*/
var express = require('express');
var router = express.Router();

const file = require('../data/items.json');

router.get('/', function (req, res) {
    let items = file.items;
    let allcolors = [];

    function onlyUnique(value, index, self) {
        return self.indexOf(value) === index;
    }

    for (let i = 0; i < items.length; i++) {
        items[i].color.forEach(c => {
            allcolors.push(c);
        });
    }

    let uniquecolors = allcolors.filter(onlyUnique);
    let data = {
        msg: "Choose a color in the url /color/your-choice-of-color",
        colors: `Colors available are: ${uniquecolors}`
    };

    res.json(data);
});

router.get('/:color', function (req, res) {
    const urlcolor = req.params.color;
    let items = file.items;
    let plants = [];
    let data;

    for (let i = 0; i < items.length; i++) {
        items[i].color.map((c) => {
            if (c.toLowerCase() === urlcolor) {
                plants.push(items[i].name);
            }
        });
    }

    data = {
        plants: plants
    };

    res.json(data);
});

module.exports = router;
