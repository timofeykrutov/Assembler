
	.include "m16def.inc" ; ����������� ���������� ��� ������ � ATmega16
	.list ; ��������� ��������
	.def temp=r16 ; ����������� �������� �������� ��������
	.def k__z=r17
	.def k___=r18
	.def s___=r19
	.def k__p=r20
;--------------------------------------------
	.cseg ; ����� �������� ������������ ����
	.org 0 ; ��������� �������� ������ �� ����
;--------------------------------------------
	ldi temp,0x80 ; ���������� �����������
	out acsr,temp
	;--------------------------------------------
	ldi temp,0xFF ; 0xff --> temp
	out ddrb,temp ; ��������� ���� rb �� ����� (11111111 --> ddrb)
;---------------------------------------------
	ldi temp, 0b101 ; ����������� 1024
	out tccr0, temp
	ldi temp, 135 ; ��������� �������� �������
	out osccal, temp
	ldi temp,low(RAMEND) ; ������������� �����
	out spl,temp
	ldi temp,high(RAMEND)
	out sph,temp
	ldi temp, 0
;---------------------------------------------
line1:
	ldi k__z, 255 // ������������ ����
	ldi k__p, 5  // ������������ �����
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
	out		tcnt0, temp ; 0 --> tcnt0 ��������� �������
ccc0: ; ������ �����
	in		k___, tcnt0 ; ������� ������
	cp		k___, k__z	; �������� k__ � k__z
	brlo	ccc0		; ���� k___<k__z, ���� � ������
	out		tcnt0, temp ; 0 --> tcnt0 ��������� �������
ccc1: ; ������ �����
	in		k___, tcnt0 ; ������� ������
	cp		k___, k__z	; �������� k__ � k__z
	brlo	ccc1		; ���� k___<k__z, ���� � ������
	ret					; ����� ������������ gen
;---------------------------------------------
pause:
	ldi		s___, 0		; 0 --> s___
	out		portb, s___ ; s___ --> pb
	out		tcnt0, temp ; 0 --> tcnt0 ��������� �������
ccc2: ; ������ �����
	in		k___, tcnt0 ; ������� ������
	cp		k___, k__p	; �������� k__ � k2_z
	brlo	ccc2		; ���� k___<k2_z, ���� � ������
	ret					; ����� ������������ pause
	
