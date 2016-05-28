require 'spec_helper'
require 'my_enumerable'

describe 'my_enumerable' do
	before :each do
		@sample_array = [8,6,7,5,3,0,9]
		@temp_array = []
	end

	describe '#my_each' do
		context 'without block' do
			it 'returns enumerable when no block is passed' do
				expect(@sample_array.my_each).to be_an_instance_of(Enumerator)
			end
		end

		context 'with block' do
			it 'throws NameError when inapporiate block is passed' do
				expect{ gibberish }.to raise_error(NameError)
			end
			
			it 'returns original object after execution of block' do
				expect(@sample_array.my_each {|num| num*3}).to eql(@sample_array)
			end

			it 'returns an empty array when passed an empty array' do
				expect(@temp_array.my_each {|num| num*3}).to eql([])
			end

			it 'returns original object containing hashes and other arrays after execution of block' do
				@sample_array = [[8,6,7,5,3,0,9], "John Adams", {:Montana => "Helena"}]
				expect(@sample_array.my_each {|obj| obj}).to eql([[8,6,7,5,3,0,9], "John Adams", {:Montana => "Helena"}])
			end

			it 'performs action specified in block on each element of passed in object' do
				@sample_array.my_each {|num| @temp_array << num*2}
				expect(@temp_array).to eql([16,12,14,10,6,0,18])
			end			
		end
	end
	describe '#my_each_with_index' do
		context 'without block' do
			it 'returns enumerable when no block is passed' do
				expect(@sample_array.my_each_with_index).to be_an_instance_of(Enumerator)
			end
		end

		context 'with block' do			
			it 'returns original object after execution of block' do
				expect(@sample_array.each_with_index {|num| num*3}).to eql(@sample_array)
			end

			it 'returns an empty array when passed an empty array' do
				expect(@temp_array.each_with_index {|num| num*3}).to eql([])
			end

			it 'goes through each element of array as value' do
				@sample_array.my_each {|value, index| @temp_array << value}
				expect(@temp_array).to eql([8,6,7,5,3,0,9])
			end

			it 'goes through each element and keeps track of its index position' do
				@sample_array.my_each_with_index {|value, index| @temp_array << index}
				expect(@temp_array).to eql([0,1,2,3,4,5,6])
			end
			it 'is able to perform operations on both valus and index as the same time' do
				@sample_array.my_each_with_index {|value, index| @temp_array << value * index}
				expect(@temp_array).to eql([0,6,14,15,12,0,54])
			end						
		end
	end
	describe '#my_select' do
		context 'without block' do
			it 'returns enumerable when no block is passed' do
				expect(@sample_array.my_select).to be_an_instance_of(Enumerator)
			end
		end

		context 'with block' do			
			it 'returns an empty array when passed an empty array' do
				expect(@temp_array.my_select {|num| num == 3}).to eql([])
			end

			it 'returns empty array when none of the block conditions are satisfied' do
				expect(@sample_array.my_select {|num| num < -1}).to eql([])
			end
			it 'returns array with all values that satisfy conditions in block' do
				expect(@sample_array.my_select {|num| num < 5}).to eql([3,0])
			end			
		end
	end
	describe '#my_any?' do
		context 'without block' do
			it 'returns enumerable when no block is passed' do
				expect(@sample_array.my_any?).to be_an_instance_of(Enumerator)
			end
		end

		context 'with block' do			
			it 'returns false when passed an empty array' do
				expect(@temp_array.my_any? {|num| num == 3}).to eql(false)
			end
			it 'returns true if atleast one of the block conditions are satisfied' do
				expect(@sample_array.my_any? {|num| num == 3}).to eql(true)
			end
			it 'returns false if none of the block conditions are not satisfied' do
				expect(@sample_array.my_any? {|num| num < -1}).to eql(false)
			end			
		end
	end
	describe '#my_count' do
		context 'without block' do
			it 'returns enumerable when no block is passed' do
				expect(@sample_array.my_count).to be_an_instance_of(Enumerator)
			end
		end

		context 'with block' do			
			it 'returns 0 when passed an empty array' do
				expect(@temp_array.my_count {|num| num == 3}).to eql(0)
			end
			it 'returns number of elements in array when no condition is given in block' do
				expect(@sample_array.my_count {|num| num}).to eql(7)
			end
			it 'returns number of elements in array that satisfy condition given in block' do
				expect(@sample_array.my_count {|num| num < 5}).to eql(2)
			end			
		end
	end
	describe '#my_inject' do
		context 'without block' do
			it 'returns enumerable when no block is passed' do
				expect(@sample_array.my_inject).to be_an_instance_of(Enumerator)
			end
		end

		context 'with block' do			
			it 'uses sum to keep running total of values' do
				expect(@sample_array.my_inject {|sum, value| sum + value}).to eql(38)
			end
			it 'uses sum to keep running total of values when passed an optional initial value to inject' do
				expect(@sample_array.my_inject(12) {|sum, value| sum + value}).to eql(50)
			end						
		end
	end		
end