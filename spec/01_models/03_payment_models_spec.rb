describe Payment do 
    describe ".create" do
        it 'creates a new payment with expected attributes' do
            Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 4000, description: "Mayfair purchase")
            expect(Payment.last).to be_instance_of(Payment)
            expect(Payment.last.payee_account).to eq("1234567890")
            expect(Payment.last.payer_account).to eq("0987654321")
            expect(Payment.last.amount).to eq(4000)
            expect(Payment.last.description).to eq("Mayfair purchase")
        end
    end

    describe "#property" do
        it 'can assign and access a property' do
            payment = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 5000, description: "Mayfair purchase")
            property = Property.new(name: "Mayfair", price: 5000, rent: 500)
            payment.property = property
            payment.save
            expect(Payment.last.property).to eq(property)
        end
    end 

    describe "#auction" do
        it 'can assign and access an auction' do
            payment = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 4000, description: "Mayfair purchase")
            auction = Auction.create(time_limit: 30)
            payment.auction = auction
            payment.save
            expect(Payment.last.auction).to eq(auction)
        end
    end 

    describe "#users" do
        it 'can assign and access multiple users' do
            payment = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 4000, description: "Mayfair purchase")
            user_one = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
            payment.users << user_one
            user_two = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
            payment.users << user_two
            payment.save
            expect(Payment.last.users).to include(user_one)
            expect(Payment.last.users).to include(user_two)
        end
    end 
end