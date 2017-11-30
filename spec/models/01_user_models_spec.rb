describe User do
    describe ".create" do
        it 'creates a new user with expected attributes' do
            user = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
            expect(User.last).to be_instance_of(User)
            expect(User.last.name).to eq("Matt")
            expect(User.last.username).to eq("matthough")
            expect(user.password).to eq("Password123")
            expect(User.last.account_number.length).not_to be(nil)
        end
    end
    describe "password" do
        it 'has a secure password' do
            User.create(name: "test", username: "test", password: "Password123", account_number: rand(10**10).to_s)
            User.create(name: "test2", username: "test2", password: "Password123", account_number: rand(10**10).to_s)
            expect(User.last.password).to eq(nil)
            expect(User.last.password_digest).to be_instance_of(String)
            expect(User.last.password_digest).not_to eq(User.first.password_digest)
        end
    end
    describe "#properties" do
        it 'can assign and access multiple properties' do
            user = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
            property_one = Property.create(name: "Mayfair", price: 5000)
            user.properties << property_one
            property_two = Property.create(name: "Not Mayfair", price: 1000)
            user.properties << property_two
            user.save
            expect(user.properties).to include(property_one)
            expect(user.properties).to include(property_two)
        end
    end 
    describe "#payments" do
        it 'can assign and access multiple payments' do
            user = User.create(name: "Matt", username: "matthough", password: "Password123", account_number: rand(10**10).to_s)
            payment_one = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 4000, description: "Mayfair purchase")
            user.payments << payment_one
            payment_two = Payment.create(payee_account: "9023247561", payer_account: "6583294389", amount: 4000, description: "Not Mayfair purchase")
            user.payments << payment_two
            expect(user.payments).to include(payment_one)
            expect(user.payments).to include(payment_two)
        end
    end 
end