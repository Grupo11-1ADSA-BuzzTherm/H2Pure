var database = require("../database/config");

function buscarEsteirasPorEmpresa(empresaId) {

  instrucaoSql = `select * from esteira a where fkEmpresa = ${empresaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  instrucaoSql = `insert into (descricao, fkEmpresa) esteira values (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarEsteirasPorEmpresa,
  cadastrar
}
