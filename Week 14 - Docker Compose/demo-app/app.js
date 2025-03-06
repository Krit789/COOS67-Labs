const express = require('express');
const mysql = require('mysql2/promise');
const path = require('path');
const methodOverride = require('method-override');
const app = express();

// Environment variables
const PORT = process.env.PORT || 3000;
const DB_HOST = process.env.DB_HOST || 'localhost';
const DB_USER = process.env.DB_USER || 'root';
const DB_PASSWORD = process.env.DB_PASSWORD || 'password';
const DB_NAME = process.env.DB_NAME || 'task_manager';

// Middlewares
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(methodOverride('_method'));

// View engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Database connection pool
let pool;

// Initialize database and tables
async function initDatabase() {
  try {
    // First create a connection without database to create it if needed
    const tempPool = mysql.createPool({
      host: DB_HOST,
      user: DB_USER,
      password: DB_PASSWORD,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    });

    // Create database if it doesn't exist
    await tempPool.query(`CREATE DATABASE IF NOT EXISTS ${DB_NAME}`);
    await tempPool.end();

    // Create connection pool with database
    pool = await mysql.createPool({
      host: DB_HOST,
      user: DB_USER,
      password: DB_PASSWORD,
      database: DB_NAME,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    });

    // Create tasks table if it doesn't exist
    await pool.query(`
      CREATE TABLE IF NOT EXISTS tasks (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        status ENUM('pending', 'in-progress', 'completed') DEFAULT 'pending',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    `);

    console.log('Database and tables initialized successfully');
  } catch (error) {
    console.error('Error initializing database:', error);
    process.exit(1);
  }
}

// Routes
app.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM tasks ORDER BY created_at DESC');
    res.render('index', { tasks: rows, title: 'Task Manager' });
  } catch (error) {
    console.error('Error fetching tasks:', error);
    res.status(500).render('error', { 
      message: 'Error fetching tasks', 
      error: { status: 500, stack: error.stack } 
    });
  }
});

// Create task form
app.get('/tasks/new', (req, res) => {
  res.render('new', { title: 'Create New Task' });
});

// Create task
app.post('/tasks', async (req, res) => {
  try {
    const { title, description, status } = req.body;
    await pool.query(
      'INSERT INTO tasks (title, description, status) VALUES (?, ?, ?)',
      [title, description, status || 'pending']
    );
    res.redirect('/');
  } catch (error) {
    console.error('Error creating task:', error);
    res.status(500).render('error', { 
      message: 'Error creating task', 
      error: { status: 500, stack: error.stack } 
    });
  }
});

// View task details
app.get('/tasks/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM tasks WHERE id = ?', [req.params.id]);
    if (rows.length === 0) {
      return res.status(404).render('error', { 
        message: 'Task not found', 
        error: { status: 404 } 
      });
    }
    res.render('show', { task: rows[0], title: rows[0].title });
  } catch (error) {
    console.error('Error fetching task:', error);
    res.status(500).render('error', { 
      message: 'Error fetching task', 
      error: { status: 500, stack: error.stack } 
    });
  }
});

// Edit task form
app.get('/tasks/:id/edit', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM tasks WHERE id = ?', [req.params.id]);
    if (rows.length === 0) {
      return res.status(404).render('error', { 
        message: 'Task not found', 
        error: { status: 404 } 
      });
    }
    res.render('edit', { task: rows[0], title: 'Edit Task' });
  } catch (error) {
    console.error('Error fetching task for edit:', error);
    res.status(500).render('error', { 
      message: 'Error fetching task for edit', 
      error: { status: 500, stack: error.stack } 
    });
  }
});

// Update task
app.put('/tasks/:id', async (req, res) => {
  try {
    const { title, description, status } = req.body;
    await pool.query(
      'UPDATE tasks SET title = ?, description = ?, status = ? WHERE id = ?',
      [title, description, status, req.params.id]
    );
    res.redirect(`/tasks/${req.params.id}`);
  } catch (error) {
    console.error('Error updating task:', error);
    res.status(500).render('error', { 
      message: 'Error updating task', 
      error: { status: 500, stack: error.stack } 
    });
  }
});

// Delete task
app.delete('/tasks/:id', async (req, res) => {
  try {
    await pool.query('DELETE FROM tasks WHERE id = ?', [req.params.id]);
    res.redirect('/');
  } catch (error) {
    console.error('Error deleting task:', error);
    res.status(500).render('error', { 
      message: 'Error deleting task', 
      error: { status: 500, stack: error.stack } 
    });
  }
});

// Initialize database and start server
async function startServer() {
  await initDatabase();
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}

startServer();