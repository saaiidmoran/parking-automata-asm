# parking-automata-asm
 A program to control a parking lot with the help of PIC microcontrollers programmed in Assembly Language
# Compilación
 Éste programa fué desarrollado con ayuda del IDE MPLAB, para compilarlo (El archivo ProgramaAutomata.asm) se necesita ése IDE y 
 agregarle las librerías del microcontrolador que se desea ocupar, de lo contrario marcará un error.
# Ejecución
  Si desea probar este codigo ya está compilado, unicamente se debe cargar el archivo "ProgramaAutomata.HEX" a un microcontrolador
  PIC16F84A, el diagrama del circuito está incluido en el repositorio (El archivo DiagramaAutomata.pdsprj), abrir con el programa 
  "Proteus" para simular la ejecución.
 # Funcionamiento
  El funcionamiento del programa es muy sencillo, existe un numero limitado de espacios disponibles en el estacionamiento,
  siempre que existan espacios la pluma de entrada se abrirá, cada que un automovil se posicione enfrente de la entrada la pluma 
  de la entrada se abrirá (Con la ayuda de un motorreductor de CD de 3V, puede variarse el tiempo de giro de los motorreductores de las
  plumas ya que éste programa se realizó  para ejecutarse en una maqueta) posteriormente se cierra cuando el automovil salga completamente
  al mismo tiempo que se decrementará el contador de espacios disponibles y  el proceso de salida de un automovil es muy similar,
  el automovil se coloca sobre la salida y la pluma de la salida se abre y después se cierra, una vez que se cierra la pluma de la salida
  se incrementa el contador de espacios en el estacionamiento.
  Si el estacionamiento se llena la pluma de entrada no se abrira de forma que no entre otro automovil.
  La detección del automóvil puede hacerse con sensores inductivos o de presión sobre una plataforma, al final de cuentas se necesita que
  se manden pulsos (1 o 0) para indicar si se acerca un auto a la entrada o salida, en la simulación  se representan mediante switches en   donde, 1 significa que se acercó un automovil a la entrada o salida y 0 significa que no (típico sistema binario).
