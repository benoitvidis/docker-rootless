# Ubuntu 20.01 with non-root user

```
docker run -ti --rm --user $(id -u):$(id -g) vidiben/rootless
```
