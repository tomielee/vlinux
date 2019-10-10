/*
* routes/home.js
* return all routes
*/
var express = require('express');
var router = express.Router();

const dirTree = require("directory-tree");
const routesTreeFiltered = dirTree("./routes", { attributes: ['type', 'extension', 'size'] });

router.get('/', function (req, res) {
    const data = routesTreeFiltered;

    res.json(data);
});


module.exports = router;
