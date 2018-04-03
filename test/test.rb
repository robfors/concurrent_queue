require_relative "../lib/concurrent_queue.rb"

Thread::abort_on_exception = true


q1 = ConcurrentQueue.new
q1.push(1)
q1.push(2)
raise unless q1.pop == 1
raise unless q1.pop == 2


q1 = ConcurrentQueue.new
q1.push(1)
q1.push(2)
raise unless ConcurrentQueue.pop(q1) == 1
raise unless ConcurrentQueue.pop([q1]) == 2


q1 = ConcurrentQueue.new
q2 = ConcurrentQueue.new
q1.push(1)
q1.push(2)
q1.push(3)
q2.push(4)
q2.push(5)
q2.push(6)
raise unless ConcurrentQueue.pop([q1,q2]) == 1
raise unless ConcurrentQueue.pop([q1,q2]) == 2
raise unless ConcurrentQueue.pop([q1,q2]) == 3
raise unless ConcurrentQueue.pop([q1,q2]) == 4
raise unless ConcurrentQueue.pop([q1,q2]) == 5
raise unless ConcurrentQueue.pop([q1,q2]) == 6


q1 = ConcurrentQueue.new
q2 = ConcurrentQueue.new
q3 = ConcurrentQueue.new
q1.push(1)
q1.push(2)
q2.push(3)
q2.push(4)
q3.push(5)
q3.push(6)
raise unless ConcurrentQueue.pop([q1,q2,q3]) == 1
raise unless ConcurrentQueue.pop([q1,q2,q3]) == 2
raise unless ConcurrentQueue.pop([q1,q2,q3]) == 3
raise unless ConcurrentQueue.pop([q1,q2,q3]) == 4
raise unless ConcurrentQueue.pop([q1,q2,q3]) == 5
raise unless ConcurrentQueue.pop([q1,q2,q3]) == 6


q1 = ConcurrentQueue.new
q2 = ConcurrentQueue.new
t = Thread.new do
  raise unless ConcurrentQueue.pop([q1,q2]) == 1
  raise unless ConcurrentQueue.pop([q1,q2]) == 2
end
sleep 1
q1.push(1)
q2.push(2)
t.join

q1 = ConcurrentQueue.new
q2 = ConcurrentQueue.new
t1 = Thread.new do
  raise unless ConcurrentQueue.pop([q1,q2]) == 1
  sleep 2
  raise unless ConcurrentQueue.pop([q1,q2]) == 3
end
t2 = Thread.new do
  sleep 1
  raise unless ConcurrentQueue.pop([q1,q2]) == 2
  sleep 2
  raise unless ConcurrentQueue.pop([q1,q2]) == 4
end
q1.push(1)
q1.push(2)
q1.push(3)
q1.push(4)
t1.join
t2.join

puts 'test successful'
