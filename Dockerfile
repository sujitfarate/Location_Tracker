- name: Build and Push Docker image
  uses: docker/build-push-action@v4
  with:
    context: ./app
    file: ./app/Dockerfile
    push: true
    tags: shwetatiwari501/myapp:latest
