describe Property do 
    describe ".create" do
        it 'creates a new property with expected attributes' do
            Property.create(name: "Mayfair", price: 5000, rent: 500)
            expect(Property.last).to be_instance_of(Property)
            expect(Property.last.name).to eq("Mayfair")
            expect(Property.last.price).to eq(5000)
            expect(Property.last.rent).to eq(500)
        end
    end

    describe "#payments" do
        it 'can assign and access multiple payments' do
            property = Property.create(name: "Mayfair", price: 5000, rent: 500)
            payment_one = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 4000, description: "Mayfair purchase")
            property.payments << payment_one
            payment_two = Payment.create(payee_account: "9023247561", payer_account: "6583294389", amount: 4000, description: "Not Mayfair purchase")
            property.payments << payment_two
            expect(property.payments).to include(payment_one)
            expect(property.payments).to include(payment_two)
        end
    end  

    describe "#auction" do
        it 'can assign and access an auction' do
            property = Property.create(name: "Mayfair", price: 5000, rent: 500)
            auction = Auction.create(time_limit: 30)
            property.auction = auction
            property.save
            expect(Property.last.auction).to eq(auction)
        end
    end 

    describe "#user" do
        it 'can assign and access a user' do
            property = Property.create(name: "Mayfair", price: 5000, rent: 500)
            user = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
            property.user = user
            property.save
            expect(Property.last.user).to eq(user)
        end
    end 
end