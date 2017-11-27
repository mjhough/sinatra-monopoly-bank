describe Auction do 
    describe ".create" do
        it 'creates a new auction with expected attributes' do
            Auction.create(time_limit: 30)
            expect(Auction.last).to be_instance_of(Auction)
            expect(Auction.last.time_limit).to eq(30)
        end
    end 
    describe "#property" do
        it 'can assign and access a property' do
            auction = Auction.create(time_limit: 30)
            property = Property.create(name: "Mayfair", price: 5000, rent: 500)
            auction.property = property
            auction.save
            expect(Auction.last.property).to eq(property)
        end
    end 
    describe "#payment" do
        it 'can assign and access a payment' do
            auction = Auction.create(time_limit: 30)
            payment = Payment.create(payee_account: "1234567890", payer_account: "0987654321", amount: 4000, description: "Mayfair purchase")
            auction.payment = payment
            auction.save
            expect(Auction.last.payment).to eq(payment)
        end
    end 
end