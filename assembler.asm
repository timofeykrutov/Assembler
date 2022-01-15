; Replace with your application code
start:
    /*inc r16
    rjmp start*/
	.include "m16def.inc"	; подключение библиотеки для работы с ATmega16
	.list					; включение листинга
	.def temp=r16			; определение главного рабочего регистра
	.def cmp_=r17
	.def t___=r18
	.def tmr_=r19
	.def res_=r20
	;--------------------------------------------
	.cseg					; выбор сегмента программного кода
	.org 0					; установка текущего адреса на ноль
	;--------------------------------------------
	ldi temp, 0x80			; выключение компаратора
	out acsr, temp
	;--------------------------------------------
	ldi temp, 0x00			; 0 --> temp
	out ddra, temp			; Назначаем порт ra на ввод (00000000 --> ddra)
	ldi temp, 0xFF			; 0 --> temp
	out ddrb, temp			; Назначаем порт rb на вывод (11111111 --> ddrb)
	out ddrd, temp			; Назначаем порт rd на вывод (11111111 --> ddrd)
	;---------------------------------------------
	ldi temp, 0b101			; Предделение 1024
	out tccr0, temp
	ldi temp, 137			; Коррекция тактовой частоты
	out osccal, temp
	ldi temp, low(RAMEND)	 	; инициализация стека
	out spl, temp
	ldi temp, high(RAMEND)
	out sph, temp
	ldi temp, 0xFF
	;---------------------------------------------
	out portb, temp			; 1 --> pb
	out tcnt0, temp			; 0 --> tcnt0 Обнуление таймера
read:
	ldi temp, 0x00			; 0 --> temp
	out portb, temp			; 0 --> pb
	in cmp_, pina
	cp cmp_, temp
	breq discharge
	in res_, tcnt0			; считали таймер
	jmp read
discharge:
	in t___, tcnt0			; считали таймер
	ldi temp, 0xFF			; 1 --> temp
	out portb, temp			; temp --> pb
loop:
	in tmr_, tcnt0
	cp t___, tmr_
	breq loop
	ldi temp, 0x00			; 0 --> temp
	out tcnt0, temp			; 0 --> tcnt0 Обнуление таймера
	out portb, temp			; 0 --> pb
	out portd, res_			; res_ --> pd
	jmp read