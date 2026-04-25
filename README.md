# resturent

## MySQL setup

Create the database and users table:

```sql
CREATE DATABASE IF NOT EXISTS resturent;
USE resturent;

CREATE TABLE IF NOT EXISTS users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Login and signup flow

- `signup.jsp` posts to `/signup` and inserts new users into MySQL.
- `login.jsp` posts to `/login` and authenticates against MySQL users.
- Successful login redirects to `success.jsp` and stores `userEmail` in session.

## Compile command

From project root (`webapps/resturent`):

```powershell
javac -cp "lib/servlet-api.jar;WEB-INF/lib/mysql-connector-j-9.6.0.jar" -d WEB-INF/classes src/util/DBUtil.java src/servlet/LoginServlet.java src/servlet/SignupServlet.java
```
