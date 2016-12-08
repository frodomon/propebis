class StaticPagesController < ApplicationController
  def home
  	@mainTitle = "Propebis"
    @mainDesc = "Kaihatsu labs"
  end
  def login
  	render layout: 'empty'
  end
  def signup
  	render layout: 'empty'
  end
  def forgot_password
    render layout: 'empty'
  end
end
