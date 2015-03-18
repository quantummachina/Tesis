class StaticPagesController < ApplicationController
	def home
		
	end
	def d4e
		#.order('nfavorites DESC').where('f2f > ? AND f2f < ? AND nfavorites > ?',0.3,2,1)
		@targets = Target.where('spamed = ?',true)
		@target2s = Target2.where('spamed = ?',true)
		#@targets = Target.all
		#@target2s = Target2.all
	end

	def NNs
		
	end

	def favs
		me = 40276177 #YO
		us = User.all
		max_attemps = 3

		us.each do |u|
			#FAVS
			num_attempts = 0
			begin
			  num_attempts += 1

			  c_f = 0
			  favs = T.favorites(u.uid)
			  favs.each do |f|
			  	if f.user.id == me
			  		c_f += 1
			  	end
			  end
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

			#UPDATE
			u.update_attributes(favsme:c_f)
		end

		redirect_to users_path

	end

	def rets
		me = 40276177 #YO
		us = User.all
		max_attemps = 3
		
		idpointer = T.retweets_of_me(count: 1).first.id 
		totalretuits = 0

		#until totalretuits >= 300
		num_attempts = 0
			begin
				num_attempts += 1
				rets = T.retweets_of_me(count: 200)#, max_id: idpointer)AQUI y luego sumar 10			
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
			#idpointer = rets.last.id-1
				#totalretuits = totalretuits + 10
			rets.each do |r|
				num_attempts = 0
				begin
					num_attempts += 1
			  		ruids = T.retweeters_ids(r.id)
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

			  	ruids.each do |ruid|
			  		u = User.find_by_uid(ruid)
			  		if !u.nil?
			  			u.update_attributes(retsme: u.retsme+1)
			  		end
			  	end
			end

		#end

		redirect_to users_path
	end

	def fixnils
		us = User.all
		us.each do |u|
			if u.uid.nil?
				u.update_attributes(uid: 0)
			end
			if u.name.nil?
				u.update_attributes(name: '')
			end
			if u.screen_name.nil?
				u.update_attributes(screen_name: '')
			end
			if u.description.nil?
				u.update_attributes(description: '')
			end
			if u.location.nil?
				u.update_attributes(location: '')
			end
			if u.nfollowers.nil?
				u.update_attributes(nfollowers: 0)
			end
			if u.nfriends.nil?
				u.update_attributes(nfriends: 0)
			end
			if u.nfavorites.nil?
				u.update_attributes(nfavorites: 0)
			end
			if u.ntweets.nil?
				u.update_attributes(ntweets: 0)
			end

		end
		
	end

	def buildfollowers
		max_attemps = 3
		num_attempts = 0
		begin
		  num_attempts += 1
		  myF = T.followers('thisisunity')
		rescue Twitter::Error::TooManyRequests => error
		  if num_attempts <= max_attemps
		        sleep error.rate_limit.reset_in
		    retry
		  else
		    raise
		  end
		end

		myF.each do |tu|
			num_attempts = 0
			begin
				num_attempts += 1
				#crear registro
				tuid = tu.id
				tuname = tu.name
				tuscreenname = tu.screen_name
				tudescription = tu.description
				tulocation = tu.location
				tufollouerscount = tu.followers_count
				tufriendscount = tu.friends_count
				tufavoritescount = tu.favorites_count
				tutuitscount = tu.tweets_count
				User.create(uid: tuid, name: tuname, screen_name: tuscreenname, description: tudescription, location: tulocation, nfollowers: tufollouerscount, nfriends: tufriendscount, nfavorites: tufavoritescount, ntweets: tutuitscount)
			rescue Twitter::Error::TooManyRequests => error
				if num_attempts <= max_attemps
		        	sleep error.rate_limit.reset_in
				    retry
				else
				    raise
				end
			end
		end

		@tuF = User.all

	end



	def getloyals
		tuLF = [] #tuiter user Loyal Follouers
		tu = T.user('rodrigotellom') #tuiter user
		tuF = T.followers('rodrigotellom') #tuiter user Follouers

		tuF.each do |follouer| #sacar Loyals (dio favorite en sus ultimos 20 al user)
			#obtener favoritos de ese seguidor
			favs = T.favorites(follouer.id) #20
			favs.each do |f|
				if f.user.id == tu.id
					tuLF <<  follouer  #agregar a lista
					break
				end
			end
		end

		#lista de follouers y loyals
		@loyals = tuLF
	end

	def test
		#doc = Docx::Document.open('test.doc')
	end
	def download
		send_file 'temp.txt'
		sleep 30
		File.delete 'temp.txt'
	end
end
#usuarios que han dado favorite a alguien fiel a ti, es m[as probable que te den follow si les das favorite]