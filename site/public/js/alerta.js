var alertas = [];

function obterdados(idEsteira) {
    fetch(`/medidas/tempo-real/${idEsteira}`)
        .then(resposta => {
            if (resposta.status == 200) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar(resposta, idEsteira);
                });
            } else {
                console.error(`Nenhum dado encontrado para o id ${idEsteira} ou erro na API`);
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do esteira p/ gráfico: ${error.message}`);
        });

}

function alertar(resposta, idEsteira) {
    var temp = resposta[0].temperatura;

    var grauDeAviso = '';

    var limites = {
        muito_quente: 23,
        quente: 22,
        ideal: 20,
        frio: 10,
        muito_frio: 5
    };

    var classe_temperatura = 'cor-alerta';

    if (temp >= limites.muito_quente) {
        classe_temperatura = 'cor-alerta perigo-quente';
        grauDeAviso = 'perigo quente'
        grauDeAvisoCor = 'cor-alerta perigo-quente'
        exibirAlerta(temp, idEsteira, grauDeAviso, grauDeAvisoCor)
    }
    else if (temp < limites.muito_quente && temp >= limites.quente) {
        classe_temperatura = 'cor-alerta alerta-quente';
        grauDeAviso = 'alerta quente'
        grauDeAvisoCor = 'cor-alerta alerta-quente'
        exibirAlerta(temp, idEsteira, grauDeAviso, grauDeAvisoCor)
    }
    else if (temp < limites.quente && temp > limites.frio) {
        classe_temperatura = 'cor-alerta ideal';
        removerAlerta(idEsteira);
    }
    else if (temp <= limites.frio && temp > limites.muito_frio) {
        classe_temperatura = 'cor-alerta alerta-frio';
        grauDeAviso = 'alerta frio'
        grauDeAvisoCor = 'cor-alerta alerta-frio'
        exibirAlerta(temp, idEsteira, grauDeAviso, grauDeAvisoCor)
    }
    else if (temp <= limites.muito_frio) {
        classe_temperatura = 'cor-alerta perigo-frio';
        grauDeAviso = 'perigo frio'
        grauDeAvisoCor = 'cor-alerta perigo-frio'
        exibirAlerta(temp, idEsteira, grauDeAviso, grauDeAvisoCor)
    }

    var card;

    if (document.getElementById(`temp_esteira_${idEsteira}`) != null) {
        document.getElementById(`temp_esteira_${idEsteira}`).innerHTML = temp + "°C";
    }

    if (document.getElementById(`card_${idEsteira}`)) {
        card = document.getElementById(`card_${idEsteira}`)
        card.className = classe_temperatura;
    }
}

function exibirAlerta(temp, idEsteira, grauDeAviso, grauDeAvisoCor) {
    var indice = alertas.findIndex(item => item.idEsteira == idEsteira);

    if (indice >= 0) {
        alertas[indice] = { idEsteira, temp, grauDeAviso, grauDeAvisoCor }
    } else {
        alertas.push({ idEsteira, temp, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards();
}

function removerAlerta(idEsteira) {
    alertas = alertas.filter(item => item.idEsteira != idEsteira);
    exibirCards();
}

function exibirCards() {
    alerta.innerHTML = '';

    for (var i = 0; i < alertas.length; i++) {
        var mensagem = alertas[i];
        alerta.innerHTML += transformarEmDiv(mensagem);
    }
}

function transformarEmDiv({ idEsteira, temp, grauDeAviso, grauDeAvisoCor }) {

    var descricao = JSON.parse(sessionStorage.ESTEIRAS).find(item => item.id == idEsteira).descricao;
    return `
    <div class="mensagem-alarme">
        <div class="informacao">
            <div class="${grauDeAvisoCor}">&#12644;</div> 
            <h3>${descricao} está em estado de ${grauDeAviso}!</h3>
            <small>Temperatura ${temp}.</small>   
        </div>
        <div class="alarme-sino"></div>
    </div>
    `;
}

function atualizacaoPeriodica() {
    JSON.parse(sessionStorage.ESTEIRAS).forEach(item => {
        obterdados(item.id)
    });
    setTimeout(atualizacaoPeriodica, 5000);
}
