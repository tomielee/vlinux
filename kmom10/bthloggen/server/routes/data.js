/*
* routes/data/
* /data?ip=<ip>	Visa raderna som innehåller <ip>.
* /data?url=<url>	Visa raderna som innehåller <url>.
*/
var express = require('express');
var router = express.Router();

const file = require('../../data/log.json');

router.use(function(req, res, next) {
    console.log("/data is up");
    next();
});

function returnData(req, res) {
    var data = req.data;

    res.json(data);
}
/*eslint no-trailing-spaces: [2, { "skipBlankLines": true }]*/
function getData(req, res, next) {
    var urlInput;
    let log = file;
    let allres = [];
    let content = [];
 
    if (Object.keys(req.query).length > 0) {
        for (var propName in req.query) {
            if (req.query.hasOwnProperty(propName)) {
                urlInput = req.query;
                let reg = new RegExp(req.query[propName], "g");

                log.forEach(element => {
                    // console.log(element[propName], " = ", reg)
                    if (element[propName].match(reg)) {
                        allres.push(element);
                    }
                    content = allres;
                });
            }
        }
    } else {
        content = log;
    }

    req.data = {
        query: urlInput,
        result: content,
        allresult: allres
    };

    return next();
}
/*
* Route for data/
*/
router.get('/', getData, returnData );

module.exports = router;
