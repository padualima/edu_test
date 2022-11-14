# Ranking of Deputies' spending

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## About the current test
Our challenge is to analyze some data made available by the Chamber of Deputies regarding the expenses of parliamentarians. The idea is to find out who, from your state, has the most and show off by spending those main expenses!

Have you heard of CEAP? The Quota for the Exercise of Parliamentary Activity, defrays the principal's expenses, such as airline tickets and cell phone bill. Some reimbursed, as with the Post Office, and others are paid by automatic debit, such as the purchase of tickets. In the case of reimbursement, Members have three months to present receipts. The unused monthly amount accumulates throughout the year. For this reason, in some months the amount spent may be higher than the monthly average. (Source: [Portal of the Chamber of Deputies](https://www2.camara.leg.br/transparencia/acesso-a-informacao/copy_of_perguntas-frequentes/cota-para-o-exercicio-da-atividade-parlamentar)). Through the transparency portal, we have access to these expenses and we can know how and where they are spending.

## Result of Lean Inception
Here the [Documentation](https://docs.google.com/document/d/12Rltk_ESFDbCa1BctZe_0zn9rVdvejU7U2sWA-kt36E/edit?usp=sharing) made available of the result of the Lean Inception for the development of the APP.

## Get Started!

Inside the project directory:

Run the command below to copy the `.env`, and yo will have to change PostgreSQL credentials with based on your local credentials!

```
cp .env.sample .env
```

### Ruby on Rails
Given that you have the Ruby(3.0.4), Rails(7.0.4) and DB PostgreSQL versions installed:

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
After go up Application, now with the domain localhost http://localhost:3000 you will have access to the root_path application.

## License

MIT

**Free Software, Hell Yeah!**
