# Development Notes

## Tables
* Users
  * name
  * username
  * password

* Transactions
  * timestamp
  * payee
  * payer
  * amount
  * description
  * property_id
  * auction_id

* Properties
  * name
  * price
  * rent for each level (eg. 2 houses, 1 hotel etc)
  * user_id
  * auction_id

* Auctions
  * Property name
  * Time
  * Retail price

* UserTransactions
  * user_id
  * transaction_id

## Relationships
* Users <> Transactions = Many to Many
* Users have many properties
* Properties belong to a user
* Properties have many transactions 
* Transactions have one property
* Properties belong to an auction
* Transactions belong to a transaction

## Pages
* Index - not accessible if game in progress
  * Welcome and create game options/instructions
  * New game/sign up/sign in/continue game

* Game - not accessible if no game in progress
  * All game information
  * Links to all players - shows their balance and number of properties
  * Link to transaction log
  * 'My account' link

* Show (user information) - not accessible if no game in progress
  * Shows users properties, transactions and balance

* Transactions
  * Transaction log

* Transactions/new
  * Make a new payment to another user with bank account number

* Auctions/new
  * Submit auction information.
  * Clicking start button redirects to auction page

* Auction
  * Has a timer that counts down
  * Users submit bids by entering the bid form with their bid
  * Shows bids and winning user