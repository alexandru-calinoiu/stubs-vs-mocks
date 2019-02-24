require_relative "spec/spec_helper"

class Payment
  attr_accessor :total_cents

  def initialize(payment_gateway, logger)
    @payment_gateway = payment_gateway
    @logger = logger
  end

  def save
    response = @payment_gateway.charge(total_cents)
    @logger.record_payment(response[:payment_id])
  end
end

class PaymentGateway
  def charge(total_cents)
    puts "This will hit stripe, bad"
    { payment_id: rand(100) }
  end
end

class Logger
  def record_payment(payment_id)
    puts "Payment id: #{payment_id}"
  end
end

describe Payment do
  it "records the payment" do
    payment_gateway = PaymentGateway.new
    logger = Logger.new

    payment = Payment.new(payment_gateway, logger)
    payment.total_cents = 42
    payment.save
  end
end
