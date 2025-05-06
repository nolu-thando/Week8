const express = require('express');
const mysql = require('mysql2');
const app = express();
app.use(express.json());

// Database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'yourpassword',
  database: 'task_manager'
});
db.connect(err => {
  if (err) throw err;
  console.log('Connected to MySQL');
});

// CRUD APIs

// CREATE task
app.post('/tasks', (req, res) => {
  const { user_id, title, description, due_date } = req.body;
  db.query('INSERT INTO tasks (user_id, title, description, due_date) VALUES (?, ?, ?, ?)', 
    [user_id, title, description, due_date], 
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send({ id: result.insertId });
  });
});

// READ all tasks
app.get('/tasks', (req, res) => {
  db.query('SELECT * FROM tasks', (err, results) => {
    if (err) return res.status(500).send(err);
    res.send(results);
  });
});

// UPDATE task
app.put('/tasks/:id', (req, res) => {
  const { title, description, completed } = req.body;
  db.query('UPDATE tasks SET title=?, description=?, completed=? WHERE id=?',
    [title, description, completed, req.params.id],
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send({ updated: result.affectedRows });
  });
});

// DELETE task
app.delete('/tasks/:id', (req, res) => {
  db.query('DELETE FROM tasks WHERE id=?', [req.params.id], (err, result) => {
    if (err) return res.status(500).send(err);
    res.send({ deleted: result.affectedRows });
  });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
