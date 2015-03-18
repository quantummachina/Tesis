class TargetsController < ApplicationController
	def index
		#@targets = Target.order('f2f DESC').where('f2f > ? AND f2f < ? AND nfavorites > ?',0.3,2,1)
		@targets = Target.order('f2f DESC').where('f2f < ? AND spamed = ?',100,false)
	end

	def data
		@targets = Target.where('f2f > ? AND f2f < ? AND nfavorites > ? AND since > ?',0.3,2,1,0)
	end

	def b4NN
		ts = Target.all
		max_attemps = 3
		ts.each do |t|
			num_attempts = 0
			begin
			  num_attempts += 1
				tu = T.user(t.screen_name)
				since = (Time.now - tu.created_at).to_i
				nlisted = tu.listed_count
				utcoffset = tu.utc_offset
				t.update_attributes(since: since, nlisted: nlisted, utcoffset: utcoffset)
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
			rescue Twitter::Error::NotFound => error
			  if num_attempts <= max_attemps
			  else
			    raise
			  end
			rescue Twitter::Error::Forbidden => error
			  if num_attempts <= max_attemps
			  else
			    raise
			  end
			end
		end
		redirect_to targets_path
	end

	def spam
		ts = Target.where('f2f < ? AND spamed = ?',100,false)
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
				sleep (20*rand)
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

	def clean
		ts = Target.all
		ts.each do |t|
			if t.screen_name == 'thisisunity'
				t.delete
			end
			if !User.find_by_uid(t.uid).nil?
				t.delete
			end
		end
		ts.each do |t|
			tts = Target.where('uid = ?',t.uid)
			tts.each do |tt|
				if tt.id != t.id
					tt.delete
				end
			end
		end
		redirect_to targets_path
	end
end
