# Hazelcast with Groovy shell

This image contains the all-in-one Hazelcast IMDG in a Groovy shell.

Why to use this?
* You can play with Hazelcast in a nice environment.
  * use code completion
  * no need to compile your java commands

## Run it

Default `run` command starts a `bash` environment.

```bash
docker run -it --rm kwart/hazelcast-groovysh
```

Once the container is started you can use `hzMember` or `hzClient` call to start a new member/client:

```bash
hzMember
```

Groovy shell will be started by the commands and the `hz` variable is initialized to be a new Hazelcast instance.

## Play with it

Put the java code directly into the `groovysh` command prompt:

```java
map = hz.getMap("test")
map.put("a", 1)
map.size()

hz.shutdown()
```
