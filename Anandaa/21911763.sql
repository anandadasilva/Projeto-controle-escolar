const express = require('express');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const port = 3000;


const db = new sqlite3.Database('bancoananda.db');


db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS disciplina (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, matricula TEXT)");
});


app.use(express.static('public'));


app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});


app.post('/incluir', (req, res) => {
    const nome = "Ananda da Silva";
    const matricula = "21911763";

    db.run("INSERT INTO disciplina (nome, matricula) VALUES (?, ?)", [nome, matricula], (err) => {
        if (err) {
            return console.error(err.message);
        }
        console.log("Registro incluído com sucesso!");
        res.redirect('/');
    });
});


app.get('/exibir', (req, res) => {
    db.all("SELECT * FROM disciplina", [], (err, rows) => {
        if (err) {
            return console.error(err.message);
        }
        res.send(rows);
    });
});


app.delete('/excluir/:id', (req, res) => {
    const id = req.params.id;

    db.run("DELETE FROM disciplina WHERE id = ?", id, (err) => {
        if (err) {
            return console.error(err.message);
        }
        console.log("Registro excluído com sucesso!");
        res.redirect('/');
    });
});


app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});









html

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Página Inicial</title>
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <h1>Dados de Ananda da Silva</h1>
  <table>
    <thead>
      <tr>
        <th>Nome</th>
        <th>Matrícula</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>Ananda Silva</td>
        <td>21911763</td>
      </tr>
    </tbody>
  </table>
  <script src="index.js"></script>
</body>
</html>



css


body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }
  
  h1 {
    text-align: center;
  }
  
  table {
    width: 50%;
    margin: 20px auto;
    border-collapse: collapse;
  }
  
  table, th, td {
    border: 1px solid black;
  }
  
  th, td {
    padding: 10px;
    text-align: center;
  }
  

