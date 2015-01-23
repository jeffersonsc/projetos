require "date"

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
tpo = 1
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
puts "#{tdo} KM máxima"

puts "Caulculando dias até toca de óleo"
td = (tdo/kmd)

puts "Verificando pela velocidade média por dia diminui o consumo"
if vm > 0 and vm < 20
	td = td - ((50 * td) / 100)
elsif vm > 20 and vm < 30
	td = td - ((40 * td) / 100)
elsif vm > 30 and vm < 40
	td = td - ((35 * td) / 100)
elsif vm > 40 and vm < 60
	td = td - ((30 * td) / 100)
else
	td = td - ((20 * td) / 100)
end

date_now = Date.parse(uto)
dt_troca = (date_now + td)
dt_troca = dt_troca.strftime("%d/%m/%Y")

puts "Data da última troca #{uto}, próxima troca estimada em #{dt_troca}, total de #{td} dias ou #{td / 30} meses."
