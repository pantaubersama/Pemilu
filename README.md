# README
## Pemilu 
#### Modules : Lini Masa, Pendidikan Politik, Lapor, Hitung

##### Setup
- `git clone git@git.extrainteger.com:pantau-group/API/pemilu.git`
- setup your database (postgresql)
- create env variable files (.env.development , .env.test)
    - `.env.development`
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=pemilu_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5432"
    RAILS_MAX_THREADS="5"
```

 - `.env.test` 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=pemilu_test
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5432"
    RAILS_MAX_THREADS="5"
```
   
- `$ bundle install`
- `$ rails db:create db:migrate`
- `$ rails s`
- go to [`http://localhost:3000/doc`](http://localhost:3000/doc)

#### make sure all success installed
- [`http://localhost:3000/linimasa/v1/infos`](http://localhost:3000/linimasa/v1/infos)
- [`http://localhost:3000/pendidikan_politik/v1/infos`](http://localhost:3000/pendidikan_politik/v1/infos)
- [`http://localhost:3000/lapor/v1/infos`](http://localhost:3000/lapor/v1/infos)
- [`http://localhost:3000/hitung/v1/infos`](http://localhost:3000/hitung/v1/infos)
