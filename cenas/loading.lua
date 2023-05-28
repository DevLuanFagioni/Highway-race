local composer = require('composer')

local cena = composer.newScene()

function cena:create( event )
	local grupoLoading= self.view


end
cena:addEventListener( 'create', cena )
return cena