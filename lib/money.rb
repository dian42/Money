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
				next unless config.default_currency == name
				@currency = name 
				return
			end
			raise "El parametro #{name} no se encuentra en la configuracion"
		else
			raise "No es posible instanciar el objeto, #{name} es un #{name.class}, 
				debe ser un string Ej: \"EUR\" , \"USD\", \"Bitcoin\""
		end
	end

	def inspect
		"#{@amount} #{@currency}"
	end

	def convert_to(name)
		if name.is_a? String
			@@configure.each do |config| 
				next unless config.default_currency == currency

				@amount = config.conversions[name] * @amount
				@currency = name 

				return self
			end
			raise "El parametro #{name} no se encuentra en la configuracion"
		else
			raise "No es posible realizar la conversion  de #{@currency} a #{name} este no se encuentra en la configuracion
				Ej: \"EUR\" , \"USD\", \"Bitcoin\""
		end
	end

	def +(x)
		unless x.currency == @currency
			@@configure.each do |config| 

				return "#{@amount + config.conversions[@currency] * x.amount} #{@currency}"  if config.default_currency == x.currency	
			end
		end
		return "#{@amount + x.amount} #{@currency}" 
	end

	def -(x)
		unless x.currency == @currency
			@@configure.each do |config| 

				return "#{@amount - config.conversions[@currency] * x.amount} #{@currency}"  if config.default_currency == x.currency	
			end
		end
		return "#{@amount = x.amount} #{@currency}"
	end

	def /(x)
		return "#{@amount / x} #{@currency}"
	end

	def *(x)
		return "#{@amount * x} #{@currency}"
	end

	def ==(x)
		if not x.currency == @currency
			@@configure.each do |config| 
				return ( config.default_currency == x.currency and @amount == (x.amount * config.conversions[@currency]) )
			end
		end
		return ( x.amount == @amount )
		
	end

	def >(x)
		if not x.currency == @currency
			@@configure.each do |config| 
				return ( config.default_currency == x.currency and @amount > (x.amount * config.conversions[@currency]) )
			end
		end
		return ( @amount > x.amount )
		
	end

	def <(x)
		if not x.currency == @currency
			@@configure.each do |config| 
				return ( config.default_currency == x.currency and @amount < (x.amount * config.conversions[@currency]) )
			end
		end
		return ( @amount < x.amount )
		
	end

	def self.configure
		@@configure
	end
end
