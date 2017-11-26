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

* Properties
  * name
  * price
  * rent for each level (eg. 2 houses, 1 hotel etc)

* UserTransactions
  * user_id
  * transaction_id

## Relationships
* Users <> Transactions = Many to Many
* Users have many properties
* Properties belong to a user
* Properties have many transactions 
* Transactions have one property

## Pages
