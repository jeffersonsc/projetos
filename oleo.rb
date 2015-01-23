require "date"
require "time"

#base de pesquisa
#http://g1.globo.com/Noticias/Carros/0,,MUL1102658-9658,00-TIRE+DUVIDAS+SOBRE+OS+TIPOS+DE+OLEO+PARA+O+MOTOR+DO+CARRO.html
#http://gridlubrificantes.com.br/dicas-detalhe.php?id=1
#http://www.reidooleomorumbi.com.br/dicas/

puts "=============================== TESTE DE VALIDAÇÃO DE TROCA DE ÓLEO ================================="

#Nomenclatura das variáveis
#vm = Velocidade média (KM/H)
#kmd = Quilometros médio por dia (KM)
#tkm = Total de quilometros no mês (KM)
#uto = Última troca de óleo (data)
#tkr = Total de Quilometros rodados (KM)
#tdo = Total de duração do óleo (KM)
#td = Total de dias para troca de óleo
#dt_troca = Data da pŕoxima troca
#tpo = Tipo do óleo || 1 Mineral máximo 5000 KM - 2 Semi-sintético máximo 7000 KM - 3 Sintetico máximo 10000 KM

vm = 80
kmd = 0
tkm = 900
uto = "23-01-2015"
tkr = 12000
tdo = 0
dt_troca = ""
tpo = 3
td = 0.0

puts "Caulculando qilometragem média por dia"
kmd = (tkm / 30)
puts "#{kmd} KM média p/ dia"

puts "Verificando tipo de óleo"
if tpo > 0 and tpo == 1
	tdo = 5000
elsif tpo > 0 and tpo == 2
	tdo = 7000
elsif tpo > 0 and tpo == 3
	tdo = 10000
else
	puts "Tipo de óleo inválido"
end
puts "#{tdo} KM máxima de duraçao do óleo"

puts "Caulculando dias até toca de óleo"
td = (tdo/kmd)

puts "Verificando pela velocidade média por dia diminui o consumo"
if vm > 0 and vm <= 20
	td = td - ((50 * td) / 100)
elsif vm > 20 and vm <= 30
	td = td - ((40 * td) / 100)
elsif vm > 30 and vm <= 40
	td = td - ((35 * td) / 100)
elsif vm > 40 and vm <= 60
	td = td - ((30 * td) / 100)
else
	td = td - ((20 * td) / 100)
end

puts "==== td #{td}"

date_old = Date.parse(uto)
date_now = Date.today
dt_aux = (date_now - date_old)
td = td - dt_aux.to_i
dt_troca = (date_now + td)

#calcular os meses
month_count = date_now..dt_troca
mes = 0
dia = td

1.upto(12){|month|
	aux = 0
	month_count.each{|mc|
		if month == mc.strftime("%m").to_i
			aux += 1
		end
	}

	if aux == 28
		mes += 1
		dia -= aux
	elsif aux == 29
		mes += 1
		dia -= aux
	elsif aux == 30
		mes += 1
		dia -= aux
	elsif aux == 31
		mes += 1
		dia -= aux
	end
	aux = 0
}
dia -= 1
dt_troca = dt_troca.strftime("%d/%m/%Y")

msg = ""
if mes > 1
	msg << "#{mes} meses "
else
	msg << "#{mes} mes "
end
if dia == 0
	msg "."
elsif dia > 1	
	msg << "e #{dia} dias."
else
	msg << "e #{dia} dia."
end

puts "Data da última troca #{uto}, próxima troca estimada em #{dt_troca}, falta de #{td} dias / #{msg}"
