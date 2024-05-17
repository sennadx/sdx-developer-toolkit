#!/bin/bash

# Dummy Shell Script

# Constants
PROJECT_NAME="MyAwesomeProject"
PROJECT_DIR="$HOME/$PROJECT_NAME"

# Functions
create_project_dir() {
  mkdir -p "$PROJECT_DIR"
  echo "Created project directory: $PROJECT_DIR"
}

clone_repo() {
  git clone https://github.com/your-org/your-repo.git "$PROJECT_DIR"
  echo "Cloned repository to: $PROJECT_DIR"
}

create_hello_file() {
  echo "Hello from my shell script!" > "$PROJECT_DIR/hello.txt"
  echo "Created hello.txt file."
}

# Main Script
create_project_dir
clone_repo
create_hello_file

echo "Script completed successfully!"
