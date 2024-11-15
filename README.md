# REAL TIME COLLAB

## Description

REAL TIME COLLAB is a web application built with Ruby on Rails that allows users to manage documents, comments, and tasks efficiently. The application utilizes Devise for authentication and JWT for secure API access.

## Features

- **User Authentication**: Users can sign up, log in, and manage their accounts using Devise.
- **JWT Authentication**: Secure API access using JSON Web Tokens (JWT) for stateless authentication.
- **Document Management**: Users can create, read, update, and delete documents.
- **Comments**: Users can add comments to documents for collaboration and feedback.
- **Task Management**: Users can create and manage tasks associated with documents.
- **Shared Documents**: Users can share documents with other users and manage access.


## Technologies Used

- Ruby on Rails
- Devise for authentication
- JWT for token-based authentication
- PostgreSQL for the database


## Installation

To set up the project locally, follow these steps:

1. **Clone the repository**:

   ```bash
   git clonehttps://github.com/peterdgreat/real-time-collab-api
   cd real-time-collab-api
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Set up the database**:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Set environment variables**:

   Create a `.env` file in the root directory and add the following:

   ```bash
   DEVISE_JWT_SECRET_KEY=your_secret_key_here
   ```

5. **Start the server**:

   ```bash
   rails server
   ```

6. **Access the application**: Open your browser and go to `http://localhost:3000`.

## Usage

- **Sign Up**: Users can create an account by navigating to the sign-up page.
- **Log In**: After signing up, users can log in to access their dashboard.
- **Manage Documents**: Users can create, edit, and delete documents from their dashboard.
- **Add Comments**: Users can add comments to documents for collaboration.
- **Manage Tasks**: Users can create and manage tasks associated with their documents.


