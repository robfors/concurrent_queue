# ConcurrentQueue
This is a Ruby gem that can be used to listen to multiple queues concurrently and return the value of the first queue to have an item pushed to it.

# Install
`gem install concurrent_queue`

# Documentation
You can use `ConcurrentQueue` instances as you would the core `Queue` instances. However, only the methods `pop`, `push` and `length` have been implemented. If you want to use this gem and you need more of the core methods feel free to submit a pull request or simply open an issue.

The `ConcurrentQueue` class also offers a new method `pop`. Call this with a `ConcurrentQueue` instance or `Array` of `ConcurrentQueue` instances and it will listen to all the queues simultaneously. It will immediately return a pre existing item found in any of the queues if found, otherwise it will reutrn the first item pushed to any of the queues. Just like regular queues, the order of items in each individual queue is preserved, however, if a pre existing item is found it will be popped from the earliest queue in the array you provide.

# Example
```ruby
require 'concurrent_queue'

q1 = ConcurrentQueue.new
q2 = ConcurrentQueue.new

t1 = Thread.new do
  puts ConcurrentQueue.pop([q1,q2])
  sleep 2
  puts ConcurrentQueue.pop([q1,q2])
end

t2 = Thread.new do
  sleep 1
  puts ConcurrentQueue.pop([q1,q2])
  sleep 2
  puts ConcurrentQueue.pop([q1,q2])
end

sleep 0.5
q1.push(1)
q1.push(2)
q2.push(3)
q2.push(4)
t1.join
t2.join
```
