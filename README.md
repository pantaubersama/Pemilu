# README
## sorry no doc, need help call me at `namakukingkong@gmail.com`

##### Setup
- `git clone git@github.com:namakukingkong/pokemon_api.git`
- `cd pokemon_api`
- `rails g rename:into <new_name>`
- `cd ../<new_name>`
- setup ur database (postgresql)
- create env variable files (.env.development , .env.test)
    - .env.development 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=pokeon_api_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5433"
    RAILS_MAX_THREADS="5"
```

 - .env.test 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=pokeon_api_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5433"
    RAILS_MAX_THREADS="5"
```
   
- `$ bundle install`
- `$ rails db:create db:migrate`
- `$ rails s`
- go to `http://localhost:3000/doc`

##### What do you get
- rails API
- postgres using uuid
- grape with modular arch
- API versioning
- respec (factory_bot, shulda_matcher,faker)
- examples :) `http://localhost:3000/doc`
- etc
