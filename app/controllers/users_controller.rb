class UsersController < ApplicationController
	def index
		@fols = User.order('favsme DESC').all
	end

	def show
		@user = User.find(params[:id])
		@targets = @user.targets.order('nfollowers DESC')
	end

	def gettargets #exprimir targets
		@user = User.find(params[:id])
		get_targets(@user)
		redirect_to @user
	end

	def getalltargets
		#users = User.all
		ids = (35..169).to_a
		ids.each do |id|
			get_targets(User.find(id))
		end
		redirect_to targets_path
	end

	def get_targets(user) #internal
		max_attemps = 3
		num_attempts = 0
		begin
		  	num_attempts += 1
			followers = T.followers(user.uid).take(20)
		rescue Twitter::Error::TooManyRequests => error
		  if num_attempts <= max_attemps
		        sleep error.rate_limit.reset_in
		    retry
		  else
		    raise
		  end
		rescue Twitter::Error::Unauthorized
		end
		if !followers.nil?
			followers.each do |f|
				num_attempts = 0
				begin
				  num_attempts += 1
				  user.targets.create(uid: f.id, name: f.name, screen_name: f.screen_name, nfollowers: f.followers_count, nfriends: f.friends_count, nfavorites: f.favorites_count, ntweets: f.tweets_count)
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
				end
			end
		end
	end
end
