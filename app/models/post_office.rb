class PostOffice < ActionMailer::Base
  
  def order(user, order)
    @recipients  = user.email
    @bcc         = "alesnovotny@me.com"
    @from        = "no-reply@polomino.cz"
    @sent_on     = Time.now
    
    body        :uset => user, :order => order
  end
  
  def signup(user)
      @recipients  = user.email
      @bcc         = "alesnovotny@me.com"
      @from        = "no-reply@polomino.cz"
      # headers         "Reply-to" => "#{email}"
      @subject     = "Registrace uctu"
      @sent_on     = Time.now

      body        :user => user  
  end
end
