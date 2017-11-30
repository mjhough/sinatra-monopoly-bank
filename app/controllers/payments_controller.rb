class PaymentsController < ApplicationController

    get "/payments" do
        @users = User.where(game_id: current_game.id)
        @payments = Payment.where(game_id: current_game.id)
        erb :"payments/index"
    end

    get "/payments/send" do
        if logged_in?
            @users = User.where(game_id: current_game.id)
            @user = current_user
            erb :"/payments/send"
        else
            redirect "/login"
        end
    end

    post "/payments/send" do
        payee_account = params[:payment][:payee_account]
        payment_amount = params[:payment][:amount].to_i
        payer = current_user

        if sufficient_balance?(payment_amount)
            @users = User.where(game_id: current_game)

            if !is_bank?(payee_account)
                pay_to = @users.detect {|user| user.account_number == payee_account}
            else
                pay_to = User.find_by(name: "Bank")
            end

            if params[:payment].all? {|param, value| !value.empty?}
                if !params[:property][:name].empty?
                    property = Property.find_or_create_by(name: params[:property][:name])
                    property.price = payment_amount
                    property.user = payer
                    property.game = current_game
                    property.save
                end
                if !pay_to.nil? && pay_to != payer
                    payment = Payment.create(params[:payment])
                    payment.property = property if property
                    payment.users << payer
                    payment.users << pay_to
                    payment.game = current_game
                    payment.save
                    pay_to.balance += payment_amount
                    pay_to.save
                    payer.balance -= payment_amount
                    payer.save
                    redirect "/game"
                else
                    flash[:error] = "No such payee with that account number."
                    redirect "/payments/send"
                end
            else
                flash[:error] = "Please complete all required fields."
                redirect "/payments/send"
            end
        else
            flash[:error] = "You're too broke to go splashing that amount of cash."
            redirect "/payments/send"
        end
    end
end