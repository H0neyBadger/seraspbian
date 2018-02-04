cd ./docker
docker build -t seraspbian:latest .
cd ..
docker run --rm -v $(pwd):/seraspbian/ --workdir=/seraspbian/ --entrypoint ./run.sh seraspbian:latest
