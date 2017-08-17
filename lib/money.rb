class Config
	attr_reader :default_currency, :conversions
	def initialize(currency, conversion)
		@default_currency = currency
		@conversions = conversion
	end
end

class Money < Config
	attr_reader :amount, :currency
	@@configure = [	Config.new("EUR", { 'USD' => 1.11, 'Bitcoin' => 0.0047 } ),
					Config.new("USD", { 'EUR' => (1/1.11), 'Bitcoin' => (0.0047/1.11) } ),
					Config.new("Bitcoin", { 'USD' => (1.11/0.0047), 'EUR' => (1/0.0047) } )]

	def initialize(value, name)
		if value.is_a? Numeric
			@amount = value 
		else
			raise "No es posible instanciar el objeto, #{value} es un #{value.class}, 
				debe ser un numero Ej: 50 , 5.05"
		end
		if name.is_a? String
			@@configure.each do |config|
				if config.default_currency == name
					@currency = name 
				else
					raise "El parametro #{name} no se encuentra en la configuracion"
				end
			end

		else
			raise "No es posible instanciar el objeto, #{name} es un #{name.class}, 
				debe ser un numero Ej: 50 , 5.05"
		end
	end

	def self.configure
		@@configure
	end
end


# Money.configure.each do |config|
# 	puts "config.default_currency #{config.default_currency }
# 	config.conversion = { \n"
# 	config.conversions.each do |key, value|
# 		puts "#{key} => #{value}"
# 	end
# 	puts "}"
# # end
# a = Money.new(50,"aa")
# puts a.currency