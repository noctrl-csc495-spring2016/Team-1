class DaysController < ApplicationController
  before_action :user_signed_in
  before_action :admin_or_standard
end
