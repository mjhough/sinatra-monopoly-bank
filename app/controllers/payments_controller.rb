class PaymentsController < ApplicationController

    get "/payments/send" do
        @user = current_user
        erb :"/payments/send"
    end
end