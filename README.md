
Build:

    docker build -t gamepublisher .
    docker run -ti --rm -p 8080:8080 gamepublisher

Test:

    ./test.sh

