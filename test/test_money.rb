require 'minitest/autorun'
require 'money'

class MoneyTest < Minitest::Test

  def setup
    @fifty_eur = Money.new(50, 'EUR')
    @twenty_dollars = Money.new(20, 'USD')
  end

  def test_amount
    assert_equal 50, 
    @fifty_eur.amount
  end

  def test_currency
    assert_equal "EUR", 
    @fifty_eur.currency
  end

  def test_inspect
    assert_equal "50 EUR", 
    @fifty_eur.inspect
  end

  def test_sum
    assert_equal "68.02 EUR", 
    @fifty_eur + @twenty_dollars
  end

  def test_subtraction
    assert_equal "31.98 EUR", 
    @fifty_eur - @twenty_dollars
  end

  def test_division
    assert_equal "25 EUR", 
    @fifty_eur / 2
  end

  def test_multiplication
    assert_equal "60 USD", 
    @twenty_dollars * 3
  end

  def test_equal_true
    assert_equal true, 
    @twenty_dollars == Money.new(20, 'USD')
  end

  def test_equal_false
    assert_equal false, 
    @twenty_dollars == Money.new(30, 'USD')
  end

  def test_equal_true2
    @fifty_eur_in_usd = @fifty_eur.convert_to('USD')
    assert_equal true, 
    @fifty_eur_in_usd == @fifty_eur
  end


  def test_greater_than
    assert_equal true, 
    @twenty_dollars > Money.new(5, 'USD')
  end

  def test_less_than
    assert_equal true, 
    @twenty_dollars < @fifty_eur
  end
end