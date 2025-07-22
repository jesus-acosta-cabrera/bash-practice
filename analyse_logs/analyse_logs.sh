#!/bin/bash

# Creando un array con los tipos de advertencias
advertencias=("ERROR" "FATAL" "CRITICAL")
logs=$(find . -name "*.log" -mtime -1)
archivoReporte="./report.txt"
echo "" > $archivoReporte

echo "Fecha de ejecucion" | tee -a $archivoReporte

(echo $(date "+Fecha: %d - %m - %Y") && echo $(date "+Tiempo: %H:%M")) | tee -a $archivoReporte

# Especificando el motivo de la siguiente linea de codigo
echo -e "\nArchivos editados en la ultimas 24 horas dentro de este directorio." | tee -a $archivoReporte

# Find logs from files edited on the last 24 hours
echo "directorio base: $(pwd)" | tee -a $archivoReporte
echo $(find . -name "*.log" -mtime -1) | tee -a $archivoReporte

# Especificando region de mensajes para archivo "application"

for file in ${logs[@]}; do
  (echo -ne "\nNotificaciones dentro del archivo " && echo -e $file | cut -d '/' -f 3) | tee -a $archivoReporte
  for str in ${advertencias[@]}; do
    (echo -n "cantidad de mensajes de estado $str: " && grep -wc "$str" $file) | tee -a $archivoReporte
  done
done

ciclo="y"

while [ "t" != "$ciclo" ]
do
  echo -e "Deseas ver los mensajes detallados? (y/n): "
  read detalles

  if [[ "$detalles" == "y" ]] || [[ "$detalles" == "Y" ]]
    then
      for file in ${logs[@]};
        do
          (echo -ne "\nDetalles dentro del archivo " && echo -e $file | cut -d '/' -f 3) | tee -a $archivoReporte
	  for str in ${advertencias[@]};
	    do
	      (echo -ne "\nMensajes de advertencias $str\n") | tee -a $archivoReporte
	      grep -w "$str" $file | tee -a $archivoReporte
	    done
        done
    ciclo="t"
  elif [[ "$detalles" != "n" ]] || [[ "$detalles" != "N" ]]
    then
      echo "Porfavor, ingresa y o n"
  fi
done
