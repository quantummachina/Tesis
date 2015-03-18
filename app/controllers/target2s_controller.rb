class Target2sController < ApplicationController
	def index
		#@targets = Target2.order('ffr DESC').where('f2f > ? AND f2f < ? AND nfavorites > ?',0.3,2,1)
		@targets = Target2.order('f2f DESC').where('f2f < ? AND spamed = ?',100,false)
	end

	def get_target2s		#a partir de id 1440
		targets = Target.where('since > 0')
		targets.each do |target|
			if target.id > 1440
				max_attemps = 3
				num_attempts = 0
				begin
					num_attempts += 1
					f = T.followers(target.uid).take(3).last
					if !f.nil? && Target2.find_by_uid(f.id).nil?
						target.target2s.create(uid: f.id, name: f.name, screen_name: f.screen_name, nfollowers: f.followers_count, nfriends: f.friends_count, nfavorites: f.favorites_count, ntweets: f.tweets_count, since: (Time.now - f.created_at).to_i, nlisted: f.listed_count, utcoffset: f.utc_offset)
					end
				rescue Twitter::Error::TooManyRequests => error
				  if num_attempts <= max_attemps
				        sleep error.rate_limit.reset_in
				    retry
				  else
				    raise
				  end
				rescue Twitter::Error::Unauthorized
				rescue Twitter::Error::Forbidden => error
				rescue Twitter::Error::NotFound
				end
			end
		end
		redirect_to root_path
	end

	def spam
		ts = Target2.where('f2f < ? AND spamed = ?',100,false)
		max_attemps = 3
		ts.each do |t|
			num_attempts = 0
			begin
			  num_attempts += 1
				tuit = T.user_timeline(t.uid, count:1).first
				
				#if !tuit.nil?
					pointer = tuit.id-1
					if (tuit.text.first(2) == 'RT')||(tuit.text.first(1) == '@')
						tuit = T.user_timeline(t.uid, count:1, max_id: pointer).first
						
						pointer = tuit.id-1
						if (tuit.text.first(2) == 'RT')||(tuit.text.first(1) == '@')
							tuit = T.user_timeline(t.uid, count:1, max_id: pointer).first
							
							pointer = tuit.id-1
							if (tuit.text.first(2) == 'RT')||(tuit.text.first(1) == '@')
								tuit = T.user_timeline(t.uid, count:1, max_id: pointer).first
								
								pointer = tuit.id-1
								if (tuit.text.first(2) == 'RT')||(tuit.text.first(1) == '@')
									tuit = T.user_timeline(t.uid, count:1, max_id: pointer).first
									
									pointer = tuit.id-1
								end
							end
						end
					end
					T.favorite(tuit)
				#end
				t.update_attributes(spamed: true)
				sleep (100*rand)
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
				t.update_attributes(spamed: true)
			end
		end
		redirect_to targets_path
	end
end
