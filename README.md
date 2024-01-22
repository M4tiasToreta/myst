# Run in development

This project has a docker compose structure provided for development. Install docker and docker compose and, after cloning the directory, run:

```
docker compose build # to build development docker image
docker compose run --rm web bin/rails db:setup # to setup database
docker compose up # to get the application up and running
```

if you want to access bash and checkout the tests I developed
```
docker compose run --rm web bash # to get into docker bash
bundle exec rspec
```
