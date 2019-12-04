# oreka-build

### Starting
```
vagrant up
vagrant ssh
```


### Building
```
./build.sh
```


### Packaging
```
cd distribution
./make-orkaudio-deb.sh
```

### Running

```
##start
sudo svc -u /etc/service/orkaudio
# service orkaudio start

##stop
sudo svc -d /etc/service/orkaudio
# service orkaudio stop

```

