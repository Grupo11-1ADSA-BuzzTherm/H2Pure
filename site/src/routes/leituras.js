var express = require("express");
var router = express.Router();

var leituraController = require("../controllers/leituraController");

router.get("/ultimas/:id", function (req, res) {
    leituraController.buscarUltimasLeituras(req, res);
});

router.get("/tempo-real/:id", function (req, res) {
    leituraController.buscarLeiturasEmTempoReal(req, res);
})

module.exports = router;