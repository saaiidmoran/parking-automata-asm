__CONFIG _CP_OFF&_WDT_OFF&_PWRTE_ON&_XT_OSC
LIST P=PIC16F84A
INCLUDE <P16F84.INC>
ORG 0
GOTO INICIO
ORG 6

Contador		EQU			22H
Indicador		EQU			23H
UNSEGUNDO		EQU			24H
CONT	EQU	  26H	
CONT2   EQU   27H   
CONT3   EQU   28H
CONT4   EQU   29H

INICIO	bsf		0x03,5;banco 1
		bsf		0x05,0;Entrada
		bsf		0x05,1;entrada
		bcf		0x05,2
		bcf		0x05,3
		bcf		0x06,2
		bcf		0x06,3
		bcf		0x06,4
		bcf		0x06,5
		movlw	b'00000111'
		movwf	0x01				;FUNCION PARA EL TIMER
		bcf		0x03,5;banco 0
		clrf	Contador
		movlw	b'00001010'	
		movwf	Indicador
		
		bcf		0x06,2
		bcf		0x06,3
		bcf		0x06,4
		bcf		0x06,5

DISPONIBILIDAD	MOVLW	.12
				XORWF	Contador,W
				BTFSC	0X03,2
				GOTO	NODISPONIBLES
				GOTO	DISPONIBLES
DISPONIBLES		BSF		0X05,2
				BCF		0X05,3
				GOTO	CHECAENTRADA
NODISPONIBLES	BCF		0X05,2
				BSF		0X05,3
				GOTO	CHECASALIDA

CHECAENTRADA	BTFSC	0X05,0
				GOTO	CHECASISUBE1
				GOTO	CHECASIBAJA1	

CHECASISUBE1	BTFSC	Indicador,0
				GOTO	CHECASALIDA
				GOTO	SUBEPLUMA1

CHECASIBAJA1	BTFSS	Indicador,1
				GOTO	BAJAPLUMA1
				GOTO	CHECASALIDA

SUBEPLUMA1		BSF		0X06,2
				CALL	TIEMPO
				BCF		0X06,2
				BSF		Indicador,0
				BCF		Indicador,1
				GOTO	CHECASALIDA

BAJAPLUMA1		CALL	RETARDO
				BSF		0X06,3
				CALL	TIEMPO
				BCF		0X06,3
				BCF		Indicador,0
				BSF		Indicador,1
				INCF	Contador
				GOTO	CHECASALIDA

CHECASALIDA		BTFSC	0X05,1
				GOTO	CHECASISUBE2
				GOTO	CHECASIBAJA2

CHECASISUBE2	BTFSC	Indicador,2
				GOTO	DISPONIBILIDAD
				GOTO	SUBEPLUMA2

CHECASIBAJA2	BTFSS	Indicador,3
				GOTO	BAJAPLUMA2
				GOTO	DISPONIBILIDAD	

SUBEPLUMA2		BSF		0X06,4
				CALL	TIEMPO
				BCF		0X06,4
				BSF		Indicador,2
				BCF		Indicador,3
				GOTO	DISPONIBILIDAD

BAJAPLUMA2		CALL	RETARDO
				BSF		0X06,5
				CALL	TIEMPO
				BCF		0X06,5
				BCF		Indicador,2
				BSF		Indicador,3
				movlw	.0
				xorwf	Contador,w
				btfss	0x03,2
				goto	deccont
				GOTO	DISPONIBILIDAD

deccont			decf	Contador
				goto	DISPONIBILIDAD

RETARDO ; Retardo de 2s
		movlw d'1'
    	movwf CONT4;
CICLO4	movlw d'100'
		movwf CONT3
CICLO3	movlw d'98'
		movwf CONT2
CICLO2	movlw d'67'
		movwf CONT
CICLO	decfsz CONT,1
		goto CICLO
		decfsz CONT2,1
		goto CICLO2
		decfsz CONT3,1
		goto CICLO3
		decfsz CONT4,1
		goto CICLO4
		Return


TIEMPO			MOVLW	.3
				MOVWF	UNSEGUNDO
REPITE			CALL	Timer50MS
				DECFSZ	UNSEGUNDO,F
				GOTO	REPITE
				RETURN
Timer50MS		movlw	.60
				movwf	0x01
seguir			btfss	0x0B,2
				goto	seguir
				bcf		0x0B,2
				return
				END