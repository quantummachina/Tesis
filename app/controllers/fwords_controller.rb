class FwordsController < ApplicationController
	def index
		@words = Fword.order(n: :desc).all
	end
	def split_words
		Ftweet.all.each do |tweet|
			tweet.text.split.each do |word|
				w = Fword.find_by_s(word)
				if w.nil?
					Fword.create(s: word, n: 1)
				else
					nn = w.n + 1
					w.update_attributes(n: nn)
				end
			end
		end
		redirect_to fwords_path
	end
end
