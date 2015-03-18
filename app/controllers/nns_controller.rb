class NnsController < ApplicationController
	def base
	end
	def train1
		tinput = File.foreach("app/assets/data/train1 inputs.nns").map { |line| line.split(' ').map{ | x| x.to_i} }
		toutput = File.foreach("app/assets/data/train1 outputs.nns").map { |line| line.split(' ').map{ | x| x.to_i} }
		#toutput = File.read("app/assets/data/train1 outputs.nns")

		train = RubyFann::TrainData.new(inputs: tinput, desired_outputs: toutput)
  		jackie = RubyFann::Standard.new(num_inputs: 6, hidden_neurons: [5], num_outputs: 1)
		jackie.train_on_data(train, 1000, 10, 0.01) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
		#outputs = fann.run([0.3, 0.2, 0.4])  
		
		@output =[]
		tinput.each do |t|
			@output << jackie.run(t)
		end
		#@output1 = jackie.run([10598, 11440, 39379, 122458, 159234541, 83, 0])
		#@output2 = jackie.run([1325, 1855, 434, 1352, 25872789, 1, 0])
		#@output3 = jackie.run([4779, 3745, 3, 259, 17918149, 0, -10800])

	end
end
