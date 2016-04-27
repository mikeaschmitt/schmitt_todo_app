require './app.rb'

# Video.create(:link => 'google.com',
#              :author => 'Mike Schmitt',
            #  :description => 'This is my really cool video!')

# Comment.create(:video_id => 1, 
#               :author => 'David Edwards',
#               :body => 'David\'s Body')

Video.create(:link => 'youtube.com',
             :author => 'Mike',
             :description => 'This is my really cool video! #2')
             
Comment.create(:video_id => 2, 
              :author => 'David Edwards Too',
              :body => 'Mike\'s Body!')