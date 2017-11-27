describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage with correct information' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to The Monopoly Bank")
      expect(last_response.body).to include("Instructions")
      expect(last_response.body).to include("New Game")
      expect(last_response.body).to include("Continue Game")
    end

    it "prevents the user from continuing game unless one exists" do
      get '/'
      click_button "continue_game"
      expect(last_response.location).to include("/")
    end

    it "allows the user to continue a game" do
      user_one = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
      user_two = User.create(name: "Bob", username: "bobbrown", password: "Password123", account_number: rand(10**10).to_s)
      payment = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 5000, description: "Mayfair purchase")
      property = Property.create(name: "Mayfair", price: 5000, rent: 500)
      user_one.properties << property
      user_one.save
      property.payments << payment
      property.save

      session[:game_value] = 1
      get '/'
      click_button "continue_game"
      expect(last_response.location).to include("/game")
      expect(last_response.body).to include(user_one.name)
      expect(last_response.body).to include(payment.property.name)
      expect(last_response.body).to include(property.name)
    end
  end

  # it "allows the user to create a new game" do
  #   get "/"
  #   click_button "new_game"
  #   expect(last_response.body).to include("Sign Up")

  #   session[:game_value] = 1
  #   get '/'
  #   click_button "continue_game"
  #   expect(last_response.location).to include("/game")
  #   expect(last_response.body).to include(user_one.name)
  #   expect(last_response.body).to include(payment.property.name)
  #   expect(last_response.body).to include(property.name)
  # end

  # describe "Game Page" do
  #   it "loads the correct game page depending whether a game " do
  #     get "/game"
  #       if game_exists?

  #       elsif

  #       else

  #       end
  #   end
  # end
end