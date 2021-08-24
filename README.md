# Alpine 3.14 with non-root user

```
docker run -ti --rm --user $(id -u):$(id -g) vidiben/rootless
```
