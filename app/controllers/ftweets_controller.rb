class FtweetsController < ApplicationController
	def index
		@tweets = Ftweet.all
		#@tweets = T.user_timeline('funkalab', count: 20)
	end
	def get_tweets
		num_attempts = 0
		max_attemps = 3
		cursor = 0
		tweets = T.user_timeline('funkalab')
		while tweets.count > 1
			cursor = tweets.last.id
			tweets[0..18].each do |tweet|
				Ftweet.create(tid: tweet.id, text: tweet.text)
			end
			begin #Clutch
			 	num_attempts += 1
				tweets = T.user_timeline('funkalab', max_id: cursor)
			rescue Twitter::Error::TooManyRequests => error
			  if num_attempts <= max_attemps
			        sleep error.rate_limit.reset_in
			    retry
			  else
			    raise
			  end
			rescue Twitter::Error::Unauthorized
				if num_attempts <= max_attemps
			  else
			    raise
			  end
			rescue Twitter::Error::NotFound
			rescue  NoMethodError
			end
		end
		redirect_to ftweets_path
	end
end
