require 'thread'

require_relative "concurrent_queue/listener.rb"

class ConcurrentQueue
  
  def self.pop(arg)
    arg = [arg] if arg.is_a?(ConcurrentQueue)
    unless arg.is_a?(Array) && arg.all? { |queue| queue.is_a?(ConcurrentQueue) }
      raise ArgumentError, 'must pass array of ConcurrentQueues'
    end
    queues = arg
    listener = Listener.new
    listener.pop(queues)
  end
  
  def initialize
    @listeners = []
    @mutex = Mutex.new
    @queue = Array.new
  end
  
  def pop
    self.class.pop(self)
  end
  
  def push(item)
    @mutex.synchronize do
      @queue.push(item)
      notify
    end
    nil
  end
  
  def length
    @mutex.synchronize { @queue.length }
  end
  
  def add_listener(listener)
    @mutex.synchronize do
      @listeners << listener
      notify if @queue.any?
    end
    nil
  end
  
  def remove_listener(listener)
    @mutex.synchronize do
      @listeners.delete(listener)
    end
    nil
  end
  
  private
  
  def notify
    @listeners.each do |listener|
      item = @queue.first
      was_accepted = listener.send(item)
      if was_accepted
        @queue.shift
        break
      end
    end
    nil
  end
  
end
