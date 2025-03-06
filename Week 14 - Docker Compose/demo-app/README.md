# Express.js EJS CRUD Application with Docker

This is a simple CRUD (Create, Read, Update, Delete) application built with Express.js, EJS templating engine, and MariaDB/MySQL database. The application is containerized using Docker and Docker Compose.

## Features

- Full CRUD operations for task management
- Auto-initializing database schema
- Responsive UI with Bootstrap
- Docker containerization for easy deployment

## Project Structure

```
.
├── app.js              # Main application entry point
├── docker-compose.yml  # Partial Docker Compose configuration
├── Dockerfile          # Docker image configuration
├── package.json        # Node.js dependencies
├── public/             # Static assets (if any)
└── views/              # EJS templates
    ├── partials/       # Reusable template parts
    │   ├── header.ejs
    │   └── footer.ejs
    ├── edit.ejs        # Task edit form
    ├── error.ejs       # Error page
    ├── index.ejs       # Task list page
    ├── new.ejs         # New task form
    └── show.ejs        # Task details page
```

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

1. Clone the repository:

```bash
git clone <repository-url>
cd express-ejs-crud-demo
```

2. Start the application with Docker Compose:

```bash
docker-compose up
```

3. Access the application:

Open your browser and navigate to http://localhost:3000

## Development

If you want to run the application in development mode with automatic restarting:

```bash
# Start the containers
docker-compose up -d

# Access the app container
docker-compose exec app sh

# Inside the container, run npm in dev mode
npm run dev
```

## Database Schema

The application automatically creates a `tasks` table with the following schema:

```sql
CREATE TABLE IF NOT EXISTS tasks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  status ENUM('pending', 'in-progress', 'completed') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
```

## Stopping the Application

To stop the running containers:

```bash
docker-compose down
```

To stop and remove all containers, networks, and volumes:

```bash
docker-compose down -v
```
## License

MIT