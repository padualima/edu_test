# Ranking of Deputies' spending

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## About the current test
Our challenge is to analyze some data made available by the Chamber of Deputies regarding the expenses of parliamentarians. The idea is to find out who, from your state, has the most and show off by spending those main expenses!

Have you heard of CEAP? The Quota for the Exercise of Parliamentary Activity, defrays the principal's expenses, such as airline tickets and cell phone bill. Some reimbursed, as with the Post Office, and others are paid by automatic debit, such as the purchase of tickets. In the case of reimbursement, Members have three months to present receipts. The unused monthly amount accumulates throughout the year. For this reason, in some months the amount spent may be higher than the monthly average. (Source: [Portal of the Chamber of Deputies](https://www2.camara.leg.br/transparencia/acesso-a-informacao/copy_of_perguntas-frequentes/cota-para-o-exercicio-da-atividade-parlamentar)). Through the transparency portal, we have access to these expenses and we can know how and where they are spending.

## Result of Lean Inception
Here the [Documentation](https://drive.google.com/file/d/1ro5lDbXB15_xWtG_17dE7VrH8Yc1ff10/view?usp=sharing) made available of the result of the Lean Inception for the development of the APP.

### Result Pitch!
<img width="1438" alt="index" src="https://user-images.githubusercontent.com/31924649/202854471-d14f26cb-7324-4256-933c-2968bc7ef29c.png">





## Get Started!

### Docker (recommended)
Make sure you have Docker and Docker-Compose installed on your machine!

But, if you haven't installed it yet, I recommend the links below for installation using Ubuntu 20.04:

  * Install Docker: [Click here!](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-pt)

  * Install Docker-compose: [Click here!](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-pt)

Inside the project directory:

Run to build the docker image:
```
docker-compose up --build
```

In other terminal, create and run the database migrations with the command:
```
docker-compose run --rm app bundle exec rails db:create db:migrate
```

Now, whenever you want to go up the App, run the docker container:
```
docker-compose up
```

**If you want to run the tests**::
```
docker-compose run --rm app bundle exec rspec spec
```

### Ruby on Rails
Given that you have the Ruby(3.0.4), Rails(7.0.4) and DB PostgreSQL versions installed:

Inside the project directory:

Run the command below to copy the `.env`, and yo will have to change PostgreSQL credentials with based on your local credentials!

```
cp .env.sample .env
```

Install the gems
```
bundle install
```

Creating and migrating database:
```
rails db:create
rails db:migrate
```

Go up the application:
```
bin/dev
```

**If you want to run the tests**:
```
bundle exec rspec spec
```

## Who to use
After go up Application, now with the domain localhost http://localhost:3000 you will have access to the **root_path** application.

## License

MIT

**Free Software, Hell Yeah!**
