#!/bin/bash -x

echo "--- CRUD ---"

curl -w "\n\n" --url http://localhost:8080/games \
    -H "Content-Type: application/json" \
    -d '{"id":"1234","price":12.34,"publisher":{"id":"ABCD","name":"myself","siret":5555,"phone":"11-11-11-11"},"releaseDate":"2019-04-15T00:00:00.000Z","tags":["A","B","C"],"title":"toto"}'
curl -w "\n\n" --url http://localhost:8080/games
curl -w "\n\n" --url http://localhost:8080/games/1234
curl -w "\n\n" --url http://localhost:8080/games/1234/publisher

curl -w "\n\n" --url http://localhost:8080/games/1234 -X DELETE
curl -w "\n\n" --url http://localhost:8080/games
curl -w "\n\n" --url http://localhost:8080/games/1234
curl -w "\n\n" --url http://localhost:8080/games/1234/publisher

echo "--- update process ---"

curl -w "\n\n" --url http://localhost:8080/games \
    -H "Content-Type: application/json" \
    -d '{"id":"1234","price":12.34,"publisher":{"id":"ABCD","name":"myself","siret":5555,"phone":"11-11-11-11"},"releaseDate":"2019-04-15T00:00:00.000Z","tags":["A","B","C"],"title":"toto"}'
curl -w "\n\n" --url http://localhost:8080/games \
    -H "Content-Type: application/json" \
    -d '{"id":"5678","price":12.34,"publisher":{"id":"ABCD","name":"myself","siret":5555,"phone":"11-11-11-11"},"releaseDate":"2018-04-15T00:00:00.000Z","tags":["A","B","C"],"title":"toto"}'
curl -w "\n\n" --url http://localhost:8080/games \
    -H "Content-Type: application/json" \
    -d '{"id":"9876","price":12.34,"publisher":{"id":"ABCD","name":"myself","siret":5555,"phone":"11-11-11-11"},"releaseDate":"2017-04-15T00:00:00.000Z","tags":["A","B","C"],"title":"toto"}'

curl -w "\n\n" --url http://localhost:8080/update -X POST

curl -w "\n\n" --url http://localhost:8080/games
