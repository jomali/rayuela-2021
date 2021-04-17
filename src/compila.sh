#! /bin/sh

#===============================================================================
# Script para compilar y ejecutar relatos interactivos programados en Inform 6.
# Herramientas utilizadas:
#
#	<>	inform: Compilador Inform 6
#	<>	game2js: Convierte ficheros Z-code/Glulx a JavaScript
#-------------------------------------------------------------------------------

inform_compiler=./inform
game2js=./game2js.py

inform_path=./libs

#-------------------------------------------------------------------------------

if [ "$1" != "" ]; then
	gameFile=$1
else
	echo -n "Introduce el nombre del archivo (sin la extensión): "
	read gameFile
	echo " "
fi
if [ ! -e "$gameFile.inf" ]; then
	echo "El archivo '$gameFile.inf' no existe."
	exit 1
fi

echo "============================================="
echo "COMPILANDO PARA GLULX…"
echo "---------------------------------------------"
$inform_compiler +include_path=$inform_path -G $gameFile.inf $gameFile.ulx
python $game2js --giload $gameFile.ulx > ../web/stories/$gameFile.ulx.js
rm $gameFile.ulx

exit 0;
