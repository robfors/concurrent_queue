class ConcurrentQueue
  class Listener
  
    def initialize
      @condition_variable = ConditionVariable.new
      @mutex = Mutex.new
      @popped = false
      @item = nil
    end
    
    def send(item)
      @mutex.synchronize do
        if @popped
          return false
        else
          @item = item
          @popped = true
          @condition_variable.signal
          return true
        end
      end
    end
    
    def add_queue(queue)
      raise unless queue.is_a?(ConcurrentQueue)
      @queues << queue
      nil
    end
    
    def pop(queues)
      queues.each { |queue| queue.add_listener(self) }
      @mutex.synchronize do
        @condition_variable.wait(@mutex) unless @popped
      end
      queues.each { |queue| queue.remove_listener(self) }
      @item
    end
    
  end
end
