module Enumerable

def my_each
  index = 0
  if block_given?
	  while index != self.length
	    current = self[index]
	    break if current == nil
	    yield current
	    index += 1
	  end
	  self
  else
  	self.to_enum(:my_each)
  end
end

def my_each_with_index
	index = 0
	while index != self.length
		current = self[index]
		yield current, index
		index += 1
	end
	self
end

def my_select
	results = []
	self.my_each do |x|
		results << x if (yield x)
	end
	results
end

def my_all?
	self.my_each do |x|
		return false if !(yield x)
	end
	true
end

def my_any?
	self.my_each do |x|
		return true if (yield x)
	end
	false
end

def my_none?
	self.my_each do |x|
		return false if (yield x)
	end
	true
end

def my_count
	count = 0
	self.my_each do |x|
		count += 1 if (yield x)
	end
	count
end

def my_map
	container = []
	self.my_each do |x|
		container << (yield x)
	end
	container
end

def my_inject(sum = 0)
	self.my_each do |element|
		yield sum, element
		sum += element
	end
	sum
end

def my_map_with_proc(proc)
	container = []
	self.my_each do |x|
		container << proc.call(x)
	end
	container
end


# Must have either one block or one proc or both block and proc. Having neither block nor proc will raise error.
def my_map_with_block_and_proc(proc = nil)
	container = []
	self.my_each do |x|
		if block_given? && proc
			first =  proc.call(x)
			container << yield(first)
		elsif !proc
			container << yield(x)
		elsif !block_given?
			container << proc.call(x)
	end
	end
	container
end


end



#numbers = [33,0,-6,52,335] #Array used for testing
#puts numbers.my_each{b;sh}.inspect
#puts numbers.my_all?{|x| x.is_a? Integer}
#numbers.my_select{|x| x < 1'0}
#puts numbers.my_any?{|x| x == 10}
#puts numbers.my_none?{|x| x == 33}
#puts numbers.my_count{|x| x<10}
#puts numbers.my_map{|x| x+10}.inspect
#puts numbers.my_inject(-15) {|sum, element| sum + element}.inspect

#plusTen = Proc.new do |x|
#	x+10
#end

#puts numbers.my_map_with_proc(plusTen).inspect
#puts numbers.my_map_with_block_and_proc(plusTen){|x| x+10}.inspect