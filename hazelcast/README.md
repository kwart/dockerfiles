# Hazelcast Reproducers

## tcp-ip-shutdown

Reproducer for https://github.com/hazelcast/hazelcast/issues/11701

Run 2 nodes (in different consoles):
```bash
docker run -it --rm -p 5555:5701 kwart/hazelcast-reproducers:tcp-ip-shutdown
docker run -it --rm -p 5556:5701 kwart/hazelcast-reproducers:tcp-ip-shutdown
```

In each docker container provide public docker host IP and the public port (see `-p` parameter above).
E.g.

```bash
hz 192.168.1.105 5555
```

and 

```bash
hz 192.168.1.105 5556
```

Groovy shell will be started by this commands. And the `hz` variable is initialized to be a Hazelcast instance.

In one node run:
```java
hz.shutdown();
```

and look into the log of another member if it shows some exceptions.
