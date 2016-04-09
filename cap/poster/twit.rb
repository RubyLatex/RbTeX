client.search("#", result_type: 'recent', lang: 'en').take(10).each do |tweet|
    ntw = tweet.text.gsub('#','\\#')
    ntw = ntw.gsub('_','\\_')
    ntw = ntw.gsub('&','\\&')
    ntw = ntw.gsub('$','\\$')
    Tex.print ntw
    Tex.print ""
end
Tex.print tweetString
