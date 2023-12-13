var leituraModel = require("../models/leituraModel");

function buscarUltimasLeituras(req, res) {

    var id = req.params.id;

    console.log(`Recuperando as ultimas leituras`);

    leituraModel.buscarUltimasLeituras(id).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas leituras.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function buscarLeiturasEmTempoReal(req, res) {

    var id = req.params.id;

    console.log(`Recuperando leituras em tempo real`);

    leituraModel.buscarLeiturasEmTempoReal(id).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas leituras.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarUltimasLeituras,
    buscarLeiturasEmTempoReal

}