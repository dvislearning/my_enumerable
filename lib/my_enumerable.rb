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
	if block_given?
		index = 0
		while index != self.length
			current = self[index]
			yield current, index
			index += 1
		end
		self
	else
		self.to_enum(:my_each_with_index)
	end
end

def my_select
	if block_given?
		results = []
		self.my_each do |x|
			results << x if (yield x)
		end
		results
	else
		self.to_enum(:my_select)
	end
end

def my_all?
	if block_given?
		self.my_each do |x|
			return false if !(yield x)
		end
		true
	else
		self.to_enum(:my_all?)
	end
end

def my_any?
	if block_given?
		self.my_each do |x|
			return true if (yield x)
		end
		false
	else
		self.to_enum(:my_any?)
	end
end

def my_none?
	if block_given?
		self.my_each do |x|
			return false if (yield x)
		end
		true
	else
		self.to_enum(:my_none?)
end

def my_count
	if block_given?
		count = 0
		self.my_each do |x|
			count += 1 if (yield x)
		end
		count
	else
	self.to_enum(:my_count)	
end

def my_map
	if block_given?
		container = []
		self.my_each do |x|
			container << (yield x)
		end
		container
	else
		self.to_enum(:my_map)	
end

def my_inject(sum = 0)
	if block_given?
		self.my_each do |element|
			yield sum, element
			sum += element
		end
		sum
	else
		self.to_enum(:my_inject)	
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
#puts numbers.my_each_with_index{ |num,index| puts index }.inspect
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