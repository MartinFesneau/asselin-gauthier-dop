class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :contact, :cv ]

  def contact
  end

  def cv
  end
end
