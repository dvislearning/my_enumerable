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
end