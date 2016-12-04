class StaticPagesController < ApplicationController
  def home
  	@mainTitle = "Propebis"
    @mainDesc = "Kaihatsu labs"
  end
  def login
  	render layout: false
  end
  def signup
  	render layout: false
  end
  def forgot_password
    render layout: false
  end
end
