docker build -t seraspbian:latest .
docker run --rm -v $(pwd):/seraspbian/ --workdir=/seraspbian/ --entrypoint ./run.sh seraspbian:latest
