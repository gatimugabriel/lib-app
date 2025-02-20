# Book Lending Application

## Overview
This application is built using Ruby on Rails


![Homepage](/app/assets/images/Screenshot_1.png)
![Details](/app/assets/images/book_details.png)
![Borrowings](/app/assets/images/loans.png)
![User Hisotry](/app/assets/images/borrower_history.png)

## Table of Contents
- [Book Lending Application](#book-lending-application)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Architecture](#architecture)
- [Setup \& Installation](#setup--installation)
  - [Prerequisites](#prerequisites)
    - [Ruby \& Rails Versions used](#ruby--rails-versions-used)
    - [Other Dependencies](#other-dependencies)
  - [Setup](#setup)
    - [Step 1: Clone the Repository](#step-1-clone-the-repository)
    - [Step 2: Install Dependencies](#step-2-install-dependencies)
    - [Step 3: Configure Environment Variables](#step-3-configure-environment-variables)
    - [Step 4: Database Setup](#step-4-database-setup)
    - [Step 5: Start the Rails Server](#step-5-start-the-rails-server)
- [Tests](#tests)
    - [Running Tests](#running-tests)
- [Contributing](#contributing)
    - [🛠️ How to Contribute](#️-how-to-contribute)
- [License](#license)



## Features
- **Books Management**  - Create, View, Update, Delete
- **Borrow books** - each book has a specified duration.
- **Return books** & calculate penalties for overdue returns.
- **View borrowing history** for each book/borrower.

## Architecture
This project follows the **MVC pattern** and uses **ERB templates** for the frontend.


[//]: # (![Architecture Diagram]&#40;docs/images/architecture.png&#41;)






# Setup & Installation
## Prerequisites
### Ruby & Rails Versions used
- **Ruby**: `3.4.1`
- **Rails**: `8.0.1`

### Other Dependencies
- **Bundler** (for managing gems)
- **PostgreSQL** 

## Setup

### Step 1: Clone the Repository
```sh
git clone https://github.com/gatimugabriel/lib-app.git
cd lib-app
```

### Step 2: Install Dependencies
Run the following to install all required gems:
```sh
bundle install
```

### Step 3: Configure Environment Variables
Create a ```.env``` file in project root, then checkout [this example](/env.example) for what variables you need to populate it with

### Step 4: Database Setup
Then, create and migrate the database:
```sh
rails db:create db:migrate
```

If you need seed data, run:
```sh
rails db:seed
```

### Step 5: Start the Rails Server
```sh
rails server
```
Visit `http://localhost:3000` in your browser.



# Tests
<!-- This project includes **RSpec tests** for models and controllers.

### Step 1: Install RSpec
```sh
rails generate rspec:install
```

### Step 2: Run the Tests
```sh
rspec
```

To run tests for a specific model or controller:
```sh
rspec spec/models/book_spec.rb
rspec spec/controllers/books_controller_spec.rb
``` -->

### Running Tests
```sh
./bin/rails test
```

To run tests for a specific model or controller:
```sh
./bin/rails test app/controllers/books_controller_test.rb
```


# Contributing
### How to Contribute
1. Fork the repo.
2. Create a feature branch:
   ```sh
   git checkout -b some-cool-feature
   ```
3. Make your changes.
4. Run tests:
   ```sh
   ./bin/rails test
   ```
5. Commit and push:
   ```sh
   git commit -m "Added new feature"
   git push origin feature-name
   ```
6. Open a pull request.


# License
This project is **MIT licensed**.

