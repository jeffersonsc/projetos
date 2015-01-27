require 'date'

#base de pesquisa
#http://g1.globo.com/Noticias/Carros/0,,MUL1102658-9658,00-TIRE+DUVIDAS+SOBRE+OS+TIPOS+DE+OLEO+PARA+O+MOTOR+DO+CARRO.html
#http://gridlubrificantes.com.br/dicas-detalhe.php?id=1
#http://www.reidooleomorumbi.com.br/dicas/

#Nomenclatura das variáveis
#@speed_averange_day = Velocidade média por hora / dia(KM/H)
#@km_average_day = Quilometros médio por dia (KM)
#@last_oil_change = Última troca de óleo (data)
#@oil_type = Tipo do óleo || 1 Mineral máximo 5000 KM - 2 Semi-sintético máximo 7000 KM - 3 Sintetico máximo 10000 KM

class	CalculatorOilHealth

	def initialize(km_average_day , last_oil_change , oil_type , speed_averange_day)

		@km_average_day = km_average_day
		@last_oil_change = last_oil_change
		@oil_type = oil_type
		@speed_averange_day = speed_averange_day
	end

	def execute
		date_old = Date.parse(@last_oil_change)
		date_now = Date.today
		oil_total_km = 0.0
		if @oil_type.to_i == 1
			oil_total_km = 5000
		elsif @oil_type.to_i == 2
			oil_total_km = 7000
		elsif @oil_type.to_i == 3
			oil_total_km = 10000
		else
			oil_total_km = 0
		end
		
		if oil_total_km == 0
			puts "Óleo não valido"
			return [nil , "Óleo inválido"]
		else
			puts "Caulculando dias até toca de óleo"
			total_days = (oil_total_km / @km_average_day).to_i

			puts "Verificando pela velocidade média por dia pois diminui a vida util do óleo"
			if @speed_averange_day > 0 and @speed_averange_day <= 20
				total_days -= ((50 * total_days) / 100)
			elsif @speed_averange_day > 20 and @speed_averange_day <= 30
				total_days -= ((40 * total_days) / 100)
			elsif @speed_averange_day > 30 and @speed_averange_day <= 40
				total_days -= ((35 * total_days) / 100)
			elsif @speed_averange_day > 40 and @speed_averange_day <= 60
				total_days -= ((30 * total_days) / 100)
			else
				total_days -= ((20 * total_days) / 100)
			end

			date_aux = (date_now - date_old)
			total_days -= date_aux.to_i
			date_change = (date_now + total_days)

			months_days = calculate_month(date_now , date_change)

			if months_days.nil?
				puts "Crítico sua troca de óleo precisa ser realizada urgentemente"
			else
				msg = ""
				if months_days[0] == 1
					msg << "#{months_days[0]} Mês "
				else
					msg << "#{months_days[0]} Meses "
				end

				if months_days[1] == 1
					msg << "#{months_days[1]} Dia."
				else
					msg << "#{months_days[1]} Dias."
				end
			end
			puts msg
			return["ok" , "#{msg}"]
		end		
	end

	private
	def calculate_month(date_start , date_finish)
		month_range = (date_start..date_finish)		
		if month_range.count > 0
			months = 0
			days = ((date_finish - date_start) - 1 ).to_i

			1.upto(12){|mt|
				aux = 0
				month_range.each{|mr|
					if mt == mr.strftime("%m").to_i
						aux += 1
					end
				}
				if aux == 28 or aux == 29
					months += 1
					days -= aux			
				elsif aux == 30 or aux == 31
					months += 1
					days -= aux			
				end
				aux = 0
			}
			return [months , days]
		else
			return nil
		end		
	end

end