# Profile
ZooKeeper simple guide.

# Specification
  * Install ZooKeeper
    * [*Download*](https://www-eu.apache.org/dist/zookeeper/)
    * Unpack file, and configure `ZOOKEEPER_HOME` to start easily
    * Rename `./conf/zoo_sample.cfg` to `zoo.cfg`
    * Configure log directory in `zoo.cfg`, for example `dataDir=C:/zookeeper-log`
  * Start
    * `./bin/` CMD `zkserver`