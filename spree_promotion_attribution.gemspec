# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_promotion_attribution'
  s.version     = '1.3.5'
  s.summary     = 'Attribute promotional discounts to line items instead of to an order'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Michael Bianco'
  s.email     = 'mike@cliffsidemedia.com'
  s.homepage  = 'http://github.com/iloveitaly/spree_promotion_attribution'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3.5'

  s.add_development_dependency 'capybara', '1.1'
  s.add_development_dependency 'factory_girl_rails', '1.7.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '2.12.0'
  s.add_development_dependency 'sqlite3'
end
