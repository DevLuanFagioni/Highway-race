
local composer = require('composer')

local cena = composer.newScene()

function cena:create( event )
	local grupoJogo = self.view


	-- DECLARAÇÃOS DAS VARIAVEIS PARA TRABALHAR COM POSICIONAMENTO
	local x = display.contentWidth
	local y = display.contentHeight
	local t = (x + y) / 2

	-- DECLARAÇÃO DOS AUDIOS
	local audioClick = audio.loadSound('recursos/audio/click.mp3')
	local audioTransicao = audio.loadSound('recursos/audio/transicao.mp3')
	local audioIniciar = audio.loadSound('recursos/audio/iniciar-corrida.mp3')
	local audioMorte = audio.loadSound('recursos/audio/morte.mp3')

	audio.play( audioIniciar )

	-- DECLARAÇÃO DA FONTE
	local fonte = native.newFont( 'recursos/fontes/fonte1.ttf' )

	-- DECLARAÇÃO DOS GRUPOS
	local jogo = display.newGroup()
	local GUI = display.newGroup()

	local grupoPontuacao = display.newGroup()
	grupoPontuacao.alpha = 0

	local grupoStart = display.newGroup()
	grupoStart.alpha = 1

	grupoJogo:insert( jogo )
	grupoJogo:insert( GUI )
	grupoJogo:insert( grupoPontuacao )


	-- DECLARAÇÃO DA FISICA
	local physics = require('physics')
	physics.setDrawMode( 'normal' )
	physics.start()
	physics.setGravity( 0, 0 )


	-- DECLARACAO DAS VARIAVEIS
	local vidas = 3

	local pontos = 0

	local listaObstaculos = {}


	-- DECLARAÇÃO DE OBJETOS
	local fundo = display.newImageRect(jogo, 'recursos/assets/principal/fundo.png', x, y )
	fundo.x = x*0.5
	fundo.y = y*0.5

	local fundo2 = display.newImageRect(jogo, 'recursos/assets/principal/fundo.png', x, y )
	fundo2.x = x*0.5
	fundo2.y = -y*0.45

	local pistaE = display.newImageRect(jogo, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaE.x = x*0.35
	pistaE.y = y*0.5

	local pistaE2 = display.newImageRect(jogo, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaE2.x = x*0.35
	pistaE2.y = -y*0.45

	local pistaM = display.newImageRect(jogo, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaM.x = x*0.5
	pistaM.y = y*0.5

	local pistaM2 = display.newImageRect(jogo, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaM2.x = x*0.5
	pistaM2.y = -y*0.45

	local pistaD = display.newImageRect(jogo, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaD.x = x*0.65
	pistaD.y = y*0.5

	local pistaD2 = display.newImageRect(jogo, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaD2.x = x*0.65
	pistaD2.y = -y*0.45

	local bandeiraIniciar = display.newImageRect(jogo, 'recursos/assets/principal/Start.png', x*0.45, y*0.1)
	bandeiraIniciar.x = x*0.5
	bandeiraIniciar.y = y*0.7

	local jogador = display.newImageRect(jogo, 'recursos/assets/principal/player.png', pistaM.width*0.9, y*0.09)
	jogador.x = x*0.5
	jogador.y = y*0.85
	physics.addBody(jogador, 'static')
	jogador.id = 'jogadorID'

	local botaoEsquerda = display.newImageRect(GUI, 'recursos/assets/principal/esquerda.png', t*0.08, t*0.15)
	botaoEsquerda.x = x*0.1
	botaoEsquerda.y = y*0.85

	local botaoDireita = display.newImageRect(GUI, 'recursos/assets/principal/direita.png', t*0.08, t*0.15)
	botaoDireita.x = x*0.9
	botaoDireita.y = y*0.85

	local fundoVidas = display.newImageRect(GUI, 'recursos/assets/principal/barra.png', x*0.45, y*0.05 )
	fundoVidas.x = x*0.1
	fundoVidas.y = y*0.08

	local iconeVida1 = display.newImageRect(GUI, 'recursos/assets/principal/vida-cheia.png', t*0.05, t*0.05 ) 
	iconeVida1.x = x*0.06
	iconeVida1.y = fundoVidas.y

	local iconeVida2 = display.newImageRect(GUI, 'recursos/assets/principal/vida-cheia.png', t*0.05, t*0.05 ) 
	iconeVida2.x = x*0.15
	iconeVida2.y = fundoVidas.y

	local iconeVida3 = display.newImageRect(GUI, 'recursos/assets/principal/vida-cheia.png', t*0.05, t*0.05 ) 
	iconeVida3.x = x*0.24
	iconeVida3.y = fundoVidas.y

	local fundoPontos = display.newImageRect(GUI, 'recursos/assets/principal/barra.png', x*0.45, y*0.05 )
	fundoPontos.x = x*0.1
	fundoPontos.y = y*0.14

	local textoPontos = display.newText(GUI, pontos, fundoPontos.x*1.45, fundoPontos.y, fonte, t*0.05 )

	local fundoPontuacao = display.newRect(grupoPontuacao, x*0.5, y*0.5, x, y )
	fundoPontuacao:setFillColor( 0,0,0 )
	fundoPontuacao.alpha = 0.9

	local blocoPontuacao = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Window.png', x*0.8, y*0.6 )
	blocoPontuacao.x = x*0.5
	blocoPontuacao.y = y*0.5

	local tituloPontuacao = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Score.png', x*0.5, y*0.05 )
	tituloPontuacao.x = blocoPontuacao.x
	tituloPontuacao.y = blocoPontuacao.y*0.49

	local botaoPontuacao = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Table.png', x*0.7, y*0.07 )
	botaoPontuacao.x = blocoPontuacao.x
	botaoPontuacao.y = blocoPontuacao.y*1.45

	local botaoPontuacaoTexto = display.newText(grupoPontuacao, 'RECOMECAR', botaoPontuacao.x, botaoPontuacao.y, fonte, t*0.04  )

	local iconePontosVazio1 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_BG.png', t*0.15, t*0.15 )
	iconePontosVazio1.x = blocoPontuacao.x*0.7
	iconePontosVazio1.y = blocoPontuacao.y*1.15

	local iconePontosVazio3 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_BG.png', t*0.15, t*0.15 )
	iconePontosVazio3.x = blocoPontuacao.x*1.3
	iconePontosVazio3.y = blocoPontuacao.y*1.15

	local iconePontosVazio2 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_BG.png', t*0.15, t*0.15 )
	iconePontosVazio2.x = blocoPontuacao.x
	iconePontosVazio2.y = blocoPontuacao.y*1.12

	local iconePontosPrata1 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_Silver.png', t*0.15, t*0.15 )
	iconePontosPrata1.x = blocoPontuacao.x*0.7
	iconePontosPrata1.y = blocoPontuacao.y*1.15
	iconePontosPrata1.alpha = 0

	local iconePontosPrata3 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_Silver.png', t*0.15, t*0.15 )
	iconePontosPrata3.x = blocoPontuacao.x*1.3
	iconePontosPrata3.y = blocoPontuacao.y*1.15
	iconePontosPrata3.alpha = 0

	local iconePontosPrata2 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_Silver.png', t*0.15, t*0.15 )
	iconePontosPrata2.x = blocoPontuacao.x
	iconePontosPrata2.y = blocoPontuacao.y*1.12
	iconePontosPrata2.alpha = 0

	local iconePontosOuro1 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_Gold.png', t*0.15, t*0.15 )
	iconePontosOuro1.x = blocoPontuacao.x*0.7
	iconePontosOuro1.y = blocoPontuacao.y*1.15
	iconePontosOuro1.alpha = 0

	local iconePontosOuro3 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_Gold.png', t*0.15, t*0.15 )
	iconePontosOuro3.x = blocoPontuacao.x*1.3
	iconePontosOuro3.y = blocoPontuacao.y*1.15
	iconePontosOuro3.alpha = 0

	local iconePontosOuro2 = display.newImageRect(grupoPontuacao, 'recursos/assets/pontuacao/Star_Gold.png', t*0.15, t*0.15 )
	iconePontosOuro2.x = blocoPontuacao.x
	iconePontosOuro2.y = blocoPontuacao.y*1.12
	iconePontosOuro2.alpha = 0

	local textoComecar = display.newText(grupoStart, '3', x*0.5, y*0.5 , fonte, t*0.1 )

	local iconeComecarVerde = display.newImageRect(grupoStart, 'recursos/assets/botoes/on.png', t*0.15, t*0.06 )
	iconeComecarVerde.x = x*0.5
	iconeComecarVerde.y = y*0.42

	local iconeComecarVermelho = display.newImageRect(grupoStart, 'recursos/assets/botoes/off.png', t*0.15, t*0.06 )
	iconeComecarVermelho.x = x*0.5
	iconeComecarVermelho.y = y*0.42


	-- DECLARAÇÃO DE FUNCOES
	function comecar()
		timer.performWithDelay( 1000, function()
			textoComecar.text = '2'
		end , 1 )

		timer.performWithDelay( 2000, function()
			textoComecar.text = '1'
		end , 1 )

		timer.performWithDelay( 3000, function()
			textoComecar.text = 'GO'
			iconeComecarVermelho.alpha = 0
		end , 1 )

		timer.performWithDelay( 4000, function()
			grupoStart.alpha = 0

			transition.to(bandeiraIniciar, {
				time = 2000,
				y = y*1.2,
				onComplete = function()
					display.remove(bandeiraIniciar)
				end
			})
		end , 1 )
	end
	comecar()


	function atualizaPontos()
		if (grupoStart.alpha == 0) then
			if (vidas > 0) then
				pontos = pontos + 15
				textoPontos.text = pontos
			end
		end
	end
	timer.performWithDelay( 100, atualizaPontos, 0 )


	function verificaVida()
		if (grupoStart.alpha == 0) then
			if (vidas == 0) then
			iconeVida1.alpha = 0
			iconeVida2.alpha = 0
			iconeVida3.alpha = 0
			grupoPontuacao.alpha = 1
			grupoPontuacao:insert( textoPontos )
			textoPontos.x = x*0.5
			textoPontos.y = blocoPontuacao.y*0.82
			textoPontos.size = t*0.1
			display.remove( jogador )

			elseif (vidas == 1) then
				iconeVida1.alpha = 1
				iconeVida2.alpha = 0
				iconeVida3.alpha = 0

			elseif (vidas == 2) then
				iconeVida1.alpha = 1
				iconeVida2.alpha = 1
				iconeVida3.alpha = 0

			elseif (vidas == 3) then
				iconeVida1.alpha = 1
				iconeVida2.alpha = 1
				iconeVida3.alpha = 1

			end
		end
	end
	Runtime:addEventListener( 'enterFrame', verificaVida )


	function movimentaJogador(event)
		if (grupoStart.alpha == 0) then
			if (vidas > 0) then
				if (event.phase == 'began') then
					if (jogador.x == pistaM.x and event.target == botaoEsquerda) then
						audio.play( audioClick )
						transition.to( jogador, {
							time = 150,
							x = pistaE.x
						})
					
					elseif (jogador.x == pistaM.x and event.target == botaoDireita) then
						audio.play( audioClick )
						transition.to( jogador, {
							time = 150,
							x = pistaD.x
						})
					
					elseif (jogador.x == pistaD.x and event.target == botaoEsquerda) then
						audio.play( audioClick )
						transition.to( jogador, {
							time = 150,
							x = pistaM.x
						})
					
					elseif (jogador.x ~= pistaM.x and  jogador.x ~= pistaD.x and event.target == botaoDireita) then
						audio.play( audioClick )
						transition.to( jogador, {
							time = 150,
							x = pistaM.x
						})
					end
				end
			end
		end
		
	end
	botaoEsquerda:addEventListener( 'touch', movimentaJogador )
	botaoDireita:addEventListener( 'touch', movimentaJogador )


	local velocidadeMapa = 10
	function gerarMapa()
		if (grupoStart.alpha == 0) then
			if (vidas > 0) then
				fundo.y = fundo.y + velocidadeMapa
				fundo2.y = fundo2.y + velocidadeMapa

				if (fundo.y >= y*1.45) then
					fundo.y = -y*0.45
				elseif (fundo2.y >= y*1.45) then
					fundo2.y = -y*0.45
				end

				pistaE.y = pistaE.y + velocidadeMapa
				pistaE2.y = pistaE2.y + velocidadeMapa

				if (pistaE.y >= y*1.45) then
					pistaE.y = -y*0.45
				elseif (pistaE2.y >= y*1.45) then
					pistaE2.y = -y*0.45
				end

				pistaM.y = pistaM.y + velocidadeMapa
				pistaM2.y = pistaM2.y + velocidadeMapa

				if (pistaM.y >= y*1.45) then
					pistaM.y = -y*0.45
				elseif (pistaM2.y >= y*1.45) then
					pistaM2.y = -y*0.45
				end

				pistaD.y = pistaD.y + velocidadeMapa
				pistaD2.y = pistaD2.y + velocidadeMapa

				if (pistaD.y >= y*1.45) then
					pistaD.y = -y*0.45
				elseif (pistaD2.y >= y*1.45) then
					pistaD2.y = -y*0.45
				end
			end
		end
	end
	Runtime:addEventListener( 'enterFrame', gerarMapa )

	local velocidadeCarro = 3000
	function criaObstaculo()
		if (grupoStart.alpha == 0) then
			if (vidas > 0) then
				local obstaculos = {
				'recursos/assets/obstaculos/carro1.png',
				'recursos/assets/obstaculos/carro2.png',
				'recursos/assets/obstaculos/carro3.png',
				'recursos/assets/obstaculos/carro1.png',
				'recursos/assets/obstaculos/carro2.png',
				'recursos/assets/obstaculos/carro3.png'
				}

				local obstaculoAleatorio = math.random(1,6)

				local obstaculo = display.newImageRect(jogo, obstaculos[obstaculoAleatorio], pistaM.width*0.9, y*0.09)
				obstaculo.y = -y*0.2
				obstaculo.rotation = 180
				table.insert( listaObstaculos, obstaculo )
				physics.addBody( obstaculo, 'dynamic' )
				obstaculo.id = 'obstaculoID'

				transition.to(obstaculo, {
					time = velocidadeCarro,
					y = y*1.2,
					onComplete = function()
						for i = #listaObstaculos, 1, -1 do
							table.remove( listaObstaculos, i )
							display.remove( obstaculo )
						end
					end
				})

				local posicaoObstaculo = math.random(1,3)
				if (posicaoObstaculo == 1) then
					obstaculo.x = pistaE.x

				elseif (posicaoObstaculo == 2) then
					obstaculo.x = pistaM.x

				elseif (posicaoObstaculo == 3) then
					obstaculo.x = pistaD.x
				end
			end
		end
		
	end

	local tempoInicial = 1200
	local tempoDiminui = 15000 

	local criarObstaculoTimer = timer.performWithDelay(tempoInicial, criaObstaculo, 0)

	function diminuirTempo()
	    timer.cancel(criarObstaculoTimer)
	    tempoInicial = tempoInicial - 100
	    criarObstaculoTimer = timer.performWithDelay(tempoInicial, criaObstaculo, 0) 
	end

	function atualizaDiminuicao()
		if (tempoInicial >= 600) then
			diminuirTempo()
		end
	end
	timer.performWithDelay(tempoDiminui, atualizaDiminuicao, 0)

	function atualizaVelocidadeCarro()
		if (velocidadeCarro >= 1600) then
			velocidadeCarro = velocidadeCarro - 350
		end
	end
	timer.performWithDelay(tempoDiminui, atualizaVelocidadeCarro, 0)

	function atualizaVelocidadeMapa()
		if (velocidadeMapa <= 25 ) then
			velocidadeMapa = velocidadeMapa + 2.5
		end
	end
	timer.performWithDelay(tempoDiminui, atualizaVelocidadeMapa, 0)


	function reiniciar()
		composer.removeScene( 'cenas.jogo' )
	end

	function recomecar(event)
		if (event.phase == 'began' and grupoPontuacao.alpha == 1) then
			audio.play( audioClick )
			reiniciar()
			composer.gotoScene( 'cenas.iniciar', {time = 300, effect = 'slideRight'} )
		end
	end
	botaoPontuacao:addEventListener( 'touch', recomecar)

	function verificaColisao(event)
		if (vidas > 0) then
			if (event.phase == 'began') then
				if (event.object1.id == 'jogadorID' and event.object2.id == 'obstaculoID') then
					
					audio.play( audioMorte )
					vidas = vidas - 1
					display.remove(event.object2)


					for i = #listaObstaculos, 1, -1 do
						if (listaObstaculos[i] == objt2) then
							table.remove( listaObstaculos, i )
						end
					end
				end
			end
		end
	end
	Runtime:addEventListener('collision', verificaColisao)


	function verificaPontos()
		if (pontos > 2500 and iconePontosPrata2.alpha == 0) then
			iconePontosPrata2.alpha = 1

		elseif (pontos > 5000 and iconePontosPrata1.alpha == 0) then	
			iconePontosPrata1.alpha = 1

		elseif (pontos > 7500 and iconePontosPrata3.alpha == 0) then	
			iconePontosPrata3.alpha = 1

		elseif (pontos > 12000 and iconePontosOuro2.alpha == 0) then	
			iconePontosOuro2.alpha = 1

		elseif (pontos > 18000 and iconePontosOuro1.alpha == 0) then		
			iconePontosOuro1.alpha = 1

		elseif (pontos > 25000 and iconePontosOuro3.alpha == 0) then
			iconePontosOuro3.alpha = 1
		end
	end
	Runtime:addEventListener('enterFrame', verificaPontos)


end
cena:addEventListener( 'create', cena )
return cena