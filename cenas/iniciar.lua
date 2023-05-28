local composer = require('composer')

local cena = composer.newScene()

function cena:create( event )
	local grupoIniciar = self.view

	local x = display.contentWidth
	local y = display.contentHeight
	local t = (x + y) / 2


	local musicas = {
		'recursos/audio/musica1.mp3',
		'recursos/audio/musica2.mp3',
		'recursos/audio/musica3.mp3'
	}
	local musicaAleatoria = math.random( 1,3 )
	local musica = audio.loadStream( musicas[musicaAleatoria] )

	audio.play( musica, {channel = 32, onClomplete = function()
		audio.play( musica, {channel = 32} )
	end} )
	audio.setVolume( 0.2, {channel = 32} )

	local audioTransicao = audio.loadSound('recursos/audio/transicao.mp3')

	local fonte = native.newFont( 'recursos/fontes/fonte1.ttf' )

	local fundo = display.newImageRect(grupoIniciar, 'recursos/assets/principal/fundo.png', x, y )
	fundo.x = x*0.5
	fundo.y = y*0.5

	local pistaE = display.newImageRect(grupoIniciar, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaE.x = x*0.35
	pistaE.y = y*0.5

	local pistaM = display.newImageRect(grupoIniciar, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaM.x = x*0.5
	pistaM.y = y*0.5

	local pistaD = display.newImageRect(grupoIniciar, 'recursos/assets/principal/estrada.png', x*0.15, y )
	pistaD.x = x*0.65
	pistaD.y = y*0.5

	local jogador = display.newImageRect(grupoIniciar, 'recursos/assets/principal/player.png', x*0.13, y*0.1)
	jogador.x = x*0.5
	jogador.y = y*0.85

	local sombra = display.newRect(grupoIniciar, x*0.5, y*0.5, x, y )
	sombra:setFillColor( 0,0,0 )
	sombra.alpha = 0.8

	local toque = display.newImageRect(grupoIniciar, 'recursos/assets/botoes/touch.png', t*0.1, t*0.1 )
	toque.x = x*0.5
	toque.y = y*0.5
	toque:setFillColor( 1, 1, 1 )

	local texto = display.newText(grupoIniciar, 'toque para jogar', x*0.5, y*0.4, fonte, t*0.05 )

	local podeTocar = false

	timer.performWithDelay( 500, function()
		podeTocar = true
	end, 1 )

	function toque(event)
		if (podeTocar == true) then
			if (event.phase == 'began') then
				composer.gotoScene( 'cenas.jogo', {time = 300, effect = 'slideLeft'} )
				audio.play( audioTransicao )
			end
		end
	end
	sombra:addEventListener( 'touch', toque )

end
cena:addEventListener( 'create', cena )
return cena