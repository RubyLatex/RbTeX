# \begin{rbtex}
    require "wolfram-alpha"
    options = {"format"=>"plaintext"}
    client = WolframAlpha::Client.new "23R7YP-YPKJ8A45GX", options
    response = client.query "derivative of sin x"
    # response.each do |pod|
    #     puts pod.title
    # end
    tell = response.find {|pod| pod.title == "Derivative"}
    puts tell.subpods[0].plaintext
    # tell.subpods.each {|sp| puts sp.plaintext}


    # Tex.print(Tex.imath(tell.subpods[0].plaintext))
# \end{rbtex}
