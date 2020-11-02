# Alpine 3.12 with non-root user

```
docker run -ti --rm --user $(id -u):$(id -g) vidiben/rootless
```
