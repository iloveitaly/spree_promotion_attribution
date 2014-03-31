Spree Promotion Attribution
===========================

For attributing promotional discounts to line items instead of to an order.
Important if you are paying royalties.

A `report` method is added to every order calculator which is item and not order
based. Some examples of item based promotions:

* Percent Per Item
* Flat Percent Total

Some examples of a order based promotion:

* Free shipping

TODO
=======

* Specs
* Test rounding problem (possibly use BigDecimal on `1.0` percent calculation)
* Provide line item RABL template for order API

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec

Copyright (c) 2014 Michael Bianco, released under the New BSD License
