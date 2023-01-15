# Becoming a technical tester

As a tester, you span two worlds -- the world of business requirements and the world of software engineering. 

By improving your technical skills you will be able to:

* Add value by finding bugs that are not easily found by just testing via the user interface.
* Provide developers with additional information that will help them debug faster
* Enjoy your work more due to increased understanding of all layers of the system
* Build rapport with developers by sharing a common understanding and technical language

## Technical Skills Covered

* Linux Command Line
* Containers (Docker)
* REST API
* SQL
* CD/CD

## Tools

* GitHub Codespaces
* VSCode IDE (comes with Codespaces)
* Docker and docker compose
* Postman
* Postgres
* pgAdmin
* GitHub Actions (CI/CD)

## Lab Work

We will be using the open source Mealie application in this repo to practice our skills.

## Start application

```
docker compose up
```

## Restore DB

Open another terminal

```
docker exec postgres sh -c "./db_dump/restore_db.sh"
```
