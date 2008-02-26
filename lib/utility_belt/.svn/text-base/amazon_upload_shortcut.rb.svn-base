# S3 (http://amazon.rubyforge.org/)
%w{aws/s3 cgi platform}.each {|lib| require lib}

module UtilityBelt
  module AmazonUploadShortcut
    def aws_upload(bucket,filename)
      AWS::S3::Base.establish_connection!(:access_key_id => ENV['AMAZON_ACCESS_KEY_ID'], 
                                          :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY'])
      AWS::S3::S3Object.store(filename, open(filename), bucket, :access => :public_read)
      url = "http://s3.amazonaws.com/#{bucket}/#{filename}".gsub(/ /, "%20")
      Clipboard.write(url) if Clipboard.available?
      url
    end
  end
end
    
class Object
  include UtilityBelt::AmazonUploadShortcut
end if Object.const_defined? :IRB

# a quick note: the "google" command uses CGI.escape, but the URLs produced by CGI.escape
# don't seem to succeed here, in practice. this may differ by OS and/or browser. Let me
# know if you see something weird -- the Utility Belt mailing list is here:
#
# http://rubyforge.org/mailman/listinfo/utilitybelt-tinkering
