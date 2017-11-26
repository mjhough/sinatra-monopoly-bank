require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use UsersController
use AuctionsController
use PropertiesController
use PaymentsController
use Rack::MethodOverride
run ApplicationController