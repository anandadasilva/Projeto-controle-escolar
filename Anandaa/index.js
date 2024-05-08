const express = require('express');
const app = express();

app.set("view engine", "ejs");

port = 4000;

const connection = require("./database/database");

connection
.authenticate()
.then(() => {
    console.log("conexão feita com o banco de dados!");
})
.catch((msgErro) => {
    console.log(msgErro);
});

const bodyParser = require("body-parser");

app.listen(port,()=>{ 
console.log(`A aplicação está rodando na porta ${port}`)
});

var salas=[
{sala:"sala1",
numero:1
},

{sala:"sala2",
numero:2
},

{sala:"sala3",
numero:3
},

]


app.get("/salas",(req,res)=>{
res.render("salas",{salas: salas});
});
