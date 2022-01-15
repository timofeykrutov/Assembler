
	.include "m16def.inc" ; подключение библиотеки для работы с ATmega16
	.list ; включение листинга
	.def temp=r16 ; определение главного рабочего регистра
	.def k__z=r17
	.def k___=r18
	.def s___=r19
	.def k__p=r20
;--------------------------------------------
	.cseg ; выбор сегмента программного кода
	.org 0 ; установка текущего адреса на ноль
;--------------------------------------------
	ldi temp,0x80 ; выключение компаратора
	out acsr,temp
	;--------------------------------------------
	ldi temp,0xFF ; 0xff --> temp
	out ddrb,temp ; Назначаем порт rb на вывод (11111111 --> ddrb)
;---------------------------------------------
	ldi temp, 0b101 ; Предделение 1024
	out tccr0, temp
	ldi temp, 135 ; Коррекция тактовой частоты
	out osccal, temp
	ldi temp,low(RAMEND) ; инициализация стека
	out spl,temp
	ldi temp,high(RAMEND)
	out sph,temp
	ldi temp, 0
;---------------------------------------------
line1:
	ldi k__z, 255 // длительность ноты
	ldi k__p, 5  // длительность паузы
	ldi s___, 0x01			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x01			; 2 --> s___
	rcall gen
	rcall pause


	ldi s___, 0x02			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x02			; 2 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x02			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x02		; 2 --> s___
	rcall gen
	rcall pause

	ldi s___, 0x04			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x01			; 2 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x01			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x01			; 2 --> s___
	rcall gen
	rcall pause
line2:
	ldi s___, 0x02			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x02			; 2 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x02			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x02			; 2 --> s___
	rcall gen
	rcall pause

	ldi s___, 0x04			; 1 --> s___
	rcall gen
	rcall gen
	rcall pause
	ldi s___, 0x08			; 2 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x04			; 1 --> s___
	rcall gen
	rcall pause
	

	ldi s___, 0x10			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x10			; 2 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x10			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x10			; 2 --> s___
	rcall gen
	rcall pause

//-----------------------------------------
line3:
	ldi s___, 0x04			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x04			; 2 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x08			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x04			; 2 --> s___
	rcall gen
	rcall pause


	ldi s___, 0x10			; 2 --> s___
	rcall gen
	rcall gen
	rcall pause
	ldi s___, 0x10			; 1 --> s___
	rcall gen
	rcall pause
	ldi s___, 0x10			; 2 --> s___
	rcall gen
	rcall pause

    ldi s___, 0x01			; 2 --> s___
	rcall gen
	rcall gen

	rcall pause
	rcall pause




;---------------------------------------------
gen:
	out		portb, s___ ; s___ --> pb
	out		tcnt0, temp ; 0 --> tcnt0 Обнуление таймера
ccc0: ; повтор цикла
	in		k___, tcnt0 ; считали таймер
	cp		k___, k__z	; сравнили k__ и k__z
	brlo	ccc0		; если k___<k__z, ушли в начало
	out		tcnt0, temp ; 0 --> tcnt0 Обнуление таймера
ccc1: ; повтор цикла
	in		k___, tcnt0 ; считали таймер
	cp		k___, k__z	; сравнили k__ и k__z
	brlo	ccc1		; если k___<k__z, ушли в начало
	ret					; конец подпрограммы gen
;---------------------------------------------
pause:
	ldi		s___, 0		; 0 --> s___
	out		portb, s___ ; s___ --> pb
	out		tcnt0, temp ; 0 --> tcnt0 Обнуление таймера
ccc2: ; повтор цикла
	in		k___, tcnt0 ; считали таймер
	cp		k___, k__p	; сравнили k__ и k2_z
	brlo	ccc2		; если k___<k2_z, ушли в начало
	ret					; конец подпрограммы pause
	
