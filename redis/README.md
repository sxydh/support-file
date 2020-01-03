# Profile
Redis common commands.

# Specification
 * Base
   ```bash
   #Clear the screen
   192.168.18.161:6379> clear
   
   #Client
   192.168.18.161:6379> client list
 
   #Connect
   redis-cli -h 127.0.0.1 -p 6379
   127.0.0.1:6379> auth "redis"
   ```
 
 * Auth
   ```bash
   #Password remove
   127.0.0.1:6379> config set requirepass ""
 
   #Password set
   127.0.0.1:6379> config set requirepass "redis"
   ```
 
 * Set
   ```bash
   #String
   127.0.0.1:6379> set "test" "test" EX 1800
   ```
 
 * Get
   ```bash
   #Show keys by pattern
   192.168.18.161:6379> keys "your pattern here"
 
   #SCAN cursor [MATCH pattern] [COUNT count], return value is an array of two values: the first value is the new cursor to use in the next call, the second value is an array  of elements; since in the second call the returned cursor is 0, the server signaled to the caller that the iteration finished, and the collection was completely explored;  starting an iteration with a cursor value of 0, and calling SCAN until the returned cursor is 0 again is called a full iteration.
   127.0.0.1:6379> scan 0
 
   #Hash value
   127.0.0.1:6379> hgetall "system"
 
   #String value
   192.168.18.161:6379> get "\xac\xed\x00\x05t\x00'7eed6a60e24246c585dba15a5f404dad_STATUS"
 
   #Type
   192.168.18.161:6379> type "\xac\xed\x00\x05t\x00'7eed6a60e24246c585dba15a5f404dad_STATUS"
   ```
 
 * Delete
   ```bash
   #String
   127.0.0.1:6379> del "test"
 
   #all
   127.0.0.1:6379> flushall
   ```
  
  * EVAL [*EN*](https://redis.io/commands/eval) [*Chinese*](http://redisdoc.com/script/eval.html)