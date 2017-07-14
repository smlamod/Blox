.model small
.386
.stack 128
locals __
.data

org 000h
;SCORES
inbuff db 11
		db ?
		db 11 dup (?)
		
crtplayr db 10 dup (0)
;crtplayr db 'Anonmouse'
;crtscore db '500'
crtscore db 3 dup (0)
		
name1 db ' ',9 dup (?)
name2 db ' ',9 dup (?)
name3 db ' ',9 dup (?)
name4 db ' ',9 dup (?)
name5 db ' ',9 dup (?)

scor1 db ' ',3 dup (?)
scor2 db ' ',3 dup (?)
scor3 db ' ',3 dup (?)
scor4 db ' ',3 dup (?)
scor5 db ' ',3 dup (?)

nul db 10 dup(0)

spoint dw name1,scor1,name2,scor2,name3,scor3,name4,scor4,name5,scor5
tmpoint dw ?

mes1 db "Scores are Unavailable"
len1 dw $-mes1
mes2 db "HIGHSCORE!"
len2 dw $-mes2
mes3 db "             NOTE: scores.txt is missing, expect score reset"
len3 dw $-mes3
mes4 db "USERNAME: "
len4 dw $-mes4
mes5 db "YOU LOST!"
len5 dw $-mes5
mes6 db "[ENTER A KEY]"
len6 dw $-mes6
mes7 db "FINAL SCORE"
len7 dw $-mes7

str1 db "BLOX Instructions"
sln1 dw $-str1
str2 db "Blox is a quasi 3D puzzle game that involes a rectangular block to 'fit'"  
sln2 dw $-str2
str3 db "itself into a field to reach a destination."
sln3 dw $-str3 
str4 db "A BLOX can assume 3 orientations: Upright, Lying forwards or backwards."
sln4 dw $-str4 
str5 db "To move (and effectively orient the BLOX) use the UP, DN, LFT and RHT "
sln5 dw $-str5 
str6 db "keys or point and click the LEFT MOUSE BUTTON in the immediate vicinity"
sln6 dw $-str6 
str7 db "of the blox and translate it to movement. "
sln7 dw $-str7 
str8 db "To win the game reach the gold tile in an Upwards position, scoring is "
sln8 dw $-str8
str9 db "dependent in with the total points left and time elapsed. ENJOY!"
sln9 dw $-str9



;FILESTREAM
path db "scores.txt",0
hand dw ?
buff db 100 dup (?)


;PIXEL WRITE
xcord dw ?
ycord dw ?
xcoor dw ?
ycoor dw ?
horzl dw ?
draws db ?
colour db ?
colour1 db ?
colour2 db ?
pcolr db 0fh 

;LEVELS
lvls dw 18 DUP (0H),20H,30H,50H, 6 DUP (0H)
lvl1 dw 0H,0H,0H,0H,0H,0H,0100H,01D0H,03F0H,01F8H,01B8H,0014H,4H,84H,188H,198H,1B8H,1FCH,1D4H,0C2H,2H,0H,0H,0H,0H,0H,0H
lvl2 dw 0H,0H,0H,0H,20H,30H,60H,60H,0E8H,01CH,18H,0CH,28H,3CH,68H,34H,38H,5CH,0F8H,0E8H,80H,40H,0C0H,0C0H,80h,0H,0H
lvl3 dw 0H,0H,0H,0H,0H,0H,0H,0H,0H,1F0H,3F0H,3EEH,30EH,10EH,22CH,234H,530H,3B0H,7E0H,3E0H,200H,0H,0H,0H,0H,0H,0H
lvl4 dw 0H,0H,0H,0H,0H,0H,0H,180H,380H,180H,3C0H,140H,0A0H,0B6H,1FEH,0DEH,0D4H,0C4H,0CCH,4EH,0EH,06H,04H,0H,0H,0H,0H
lvl5 dw 0H,0H,0H,0H,28H,3CH,38H,5CH,0C8H,0CCH,0C8H,4CH,168H,1F4H,1E8H,0B8H,110H,100H,140H,0E0H,0C0H,0C0H,60H,30H,70H,30H,20H
ar_strtrow db 20,22,16,20,6
ar_strtcol db 1,6,4,3,4
ar_endrow db 8,6,13,9,24
ar_endcol db 8,6,2,7,5
lvlpoint dw lvl1,lvl2,lvl3,lvl4,lvl5

crtlvl dw ?
colitr dw ?

;SPECIAL COORDINATES
endrow dw ?
endcol dw ?
crtrow dw ? ;stores current row #
crtcol dw ? ;stores current col #
crtwrd dw ? ;stores the word itself
crtort dw 0 ;stores the current orientaion, 0 UP 1 DN_FW 2 DN_BK
looph  dw ?
loopv  dw ?

tmplvl dw ?
tmprow dw ?
tmpcol dw ?
tmport dw ?
isokmov db ? ;check if valid move
enable dw ?	 ;game's sentinel value
			 ;bit 0, set if quit
			 ;bit 1, set if win
			 ;bit 2, set if loose
			 ;bit 3, set if startscreen
			 ;bit 4, set if enter
			 ;bit 5, set if scores.txt is unavailable
			 ;bit 6, set if other file error
			 ;bit 7, set if highscore
;TEST COORDINATES FOR MOUSE
tstm dw ?
			;bit 0, set if x0 is neg
			;bit 1, set if y0 is neg
refx0 dw ? ;reference coordinates
refy0 dw ?

mcorx dw ? 	;store real mouse coordinates
mcory dw ?


;SCROING
scorestr dw 64h
scorebuf db '--'
scorebuf0 dw ?

timestr dw 0h
minstr db '00'
minstr0 dw ?
secstr db '00'
secstr0 dw ?

sc1 db 30h
sc2 db 30h
sc3 db 30h

strpoint db 'POINTS: '
lenpnt dw $-strpoint
strtime db 	'TIMER: '
lentim dw $-strtime

;LOOP VARIABLES
row dw ?
col dw ?

;SETTINGS
bsclr equ 00h ;base colour
acnt1 equ 01h ;accent colour 1 dark
acnt2 equ 09h ;accent colour 2 dark

.code
main proc 
	mov ax,@data
	mov ds,ax
	mov es,ax
	
	
startmain:
	call start
	call initscore
	bt enable,0
	jc quitblox
	mov enable,0
	
	cmp crtort,0
	je lvlstrt
	cmp crtort,1
	je showscore
	cmp crtort,2
	je quitblox
	
showscore:
	;HIGHSCORE PROCEDURES
	call cls
	call fread
	
	bt enable,5
	jc ferror
	
	call parse
	call scorescreen
	jmp exitscore
	
ferror:
	lea bp,mes1
	mov bl,04h
	mov cx,len1
	mov dh,12
	mov dl,28
	call disp
	
exitscore:
	mov ax,0
	int 16h
	jmp startmain

lvlstrt:
	call initscore
	call cls
	
	lea bp,str1
	mov bl,0fh
	mov cx,sln1
	mov dh,2
	mov dl,4
	call disp
	
	lea bp,str2
	mov bl,0fh
	mov cx,sln2
	mov dh,4
	mov dl,4
	call disp
	
	lea bp,str3
	mov bl,0fh
	mov cx,sln3
	mov dh,5
	mov dl,4
	call disp
	
	lea bp,str4
	mov bl,0fh
	mov cx,sln4
	mov dh,7
	mov dl,4
	call disp
	
	mov ax,11
	mov bx,2
	call calccoord
	call drawblox_up
	
	mov ax,11
	mov bx,4
	call calccoord
	call drawblox_downfwd
	
	mov ax,11
	mov bx,7
	call calccoord
	call drawblox_downbck
	
	lea bp,str5
	mov bl,0fh
	mov cx,sln5
	mov dh,17
	mov dl,4
	call disp
	
	lea bp,str6
	mov bl,0fh
	mov cx,sln6
	mov dh,18
	mov dl,4
	call disp
	
	lea bp,str7
	mov bl,0fh
	mov cx,sln7
	mov dh,19
	mov dl,4
	call disp
	
	lea bp,str8
	mov bl,0fh
	mov cx,sln8
	mov dh,21
	mov dl,4
	call disp

	lea bp,str9
	mov bl,0fh
	mov cx,sln9
	mov dh,22
	mov dl,4
	call disp
	
	bt enable,5
	jnc movealong
	
	lea bp,mes3
	mov bl,04
	mov cx,len3
	mov dh,26
	mov dl,4
	call disp
	
movealong:
	
	lea bp,mes4
	mov bl,03h
	mov cx,len4
	mov dh,24
	mov dl,29
	call disp
	

	
	mov ah,0ah
	lea dx,inbuff
	int 21h
	
	lea si,inbuff + 1 
	mov cl, [ si ] 
    mov ch, 0   
	
	inc si
	lea di,crtplayr
	rep movsb
	
begingame:
	mov cx,1	;level select
lvlloop:
	call cls
	mov tmplvl,cx
	call initlevel
	
	call loadlevel
	mov ax,crtrow
	mov bx,crtcol
	call calccoord
	call drawblox_up
	call mastmov
	
	;check if quit
	bt enable,0
	jc endblox
	
	call mastscore
	
	;check if loose
	bt enable,2
	jc startmain
	
	inc cx
	cmp cx,6
	jge startmain
	jmp lvlloop
	
endblox:
	mov ax,0
	int 16h

quitblox:
	mov ah,4ch
	int 21h
main endp

;-->Initialize scores.txt
initscore proc
	call fread
	
	bt enable,5
	jc exitinit
	
	call parse
exitinit:
	ret
initscore endp

;-->master score procedure
mastscore proc
	pusha
	
	mov pcolr,03h
	mov ax,231
	mov bx,211
	mov loopv,105
	mov looph,177
	call drawpixel
	
	mov pcolr,00h
	mov ax,235
	mov bx,215
	mov loopv,97
	mov looph,169
	call drawpixel
	
	
	bt enable,2 		;DO NOT COMPUTE SCORE IF LOSER
	jnc contmastscore
	
	lea bp,mes5
	mov bl,0fh
	mov cx,len5
	mov dh,15
	mov dl,36
	call disp
	
	jmp quitmastmov
contmastscore:
	call calcscore
	
	call ishigh
	bt enable,7
	jnc nohigh
	
	call chghigh
	call store
	call fwrite
	
	lea bp,mes2
	mov bl,0fh
	mov cx,len2
	mov dh,14
	mov dl,36
	call disp
	
	jmp defaultout
	
nohigh:	
	lea bp,mes7
	mov bl,0fh
	mov cx,len7
	mov dh,14
	mov dl,35
	call disp
	
defaultout:	
	lea bp,crtscore
	mov bl,0fh
	mov cx,3
	mov dh,16
	mov dl,39
	call disp

quitmastmov:
	lea bp,mes6
	mov bl,0fh
	mov cx,len6
	mov dh,18
	mov dl,34
	call disp
	
	mov ax,0
	int 16h
	popa
	ret
mastscore endp


;-->Calculate totalscore
; calculates actual scores from time and points remainning
;returns: scorestr = final score value
calcscore proc
	pusha
	xor dx,dx
	
	cmp timestr,45
	jle mtier1
	cmp timestr,90
	jle mtier2
	cmp timestr,120
	jle mtier3
	cmp timestr,240
	jle mtier4
	jmp mtier5

mtier1:
	mov cl,0ah
	mov dx,timestr
	sub dx,45
	not dx
	inc dx
	
	jmp cnscore
mtier2:
	mov cl,8
	jmp cnscore
mtier3:
	mov cl,6
	jmp cnscore
mtier4:
	mov cl,5
	jmp cnscore
mtier5:
	mov cl,3

cnscore:
	mov ax,scorestr
	mul cl
	add ax,dx
	mov scorestr,ax
	call pscore
	
	popa
	ret
calcscore endp

;-->Open,Read and close scores.txt
fread proc
	pusha
	mov ah,3dh
	mov al,2h
	lea dx,path
	int 21h
	
	jc fileerror
	mov hand,ax
	
	mov ah,3fh
	mov bx,hand
	lea dx,buff
	int 21h
	
	mov ah,3eh
	mov bx,hand
	int 21h
	

	jmp exitfread

fileerror:
	btc enable,5
exitfread:
	popa
	ret
fread endp


;-->Write Buff into scores.txt
fwrite proc
	pusha
	mov ah,3ch
	mov cx,3h
	lea dx,path
	int 21h
	
	jc __fileerror
	mov hand,ax
	
	mov ah,40h
	mov bx,hand
	mov cx,100
	lea dx,buff
	int 21h
	
	
	mov ah,3eh
	mov bx,hand
	int 21h
	popa
	ret
__fileerror:
	btc enable,6
	popa
	ret
fwrite endp


;-->print scorescreen
scorescreen proc

	mov pcolr,0fh

	mov ax,5
	mov bx,2
	call calccoord
	mov dx,003h
	sub bx,5
	call drawtile
	
	mov ax,9
	mov bx,2
	call calccoord
	mov dx,003h
	sub bx,12
	call drawtile
	
	mov ax,13
	mov bx,2
	call calccoord
	mov dx,003h
	sub bx,18
	call drawtile
	
	mov ax,17
	mov bx,2
	call calccoord
	mov dx,003h
	sub bx,27
	call drawtile
	
	mov ax,21
	mov bx,2
	call calccoord
	mov dx,003h
	sub bx,35
	call drawtile
	
	;1
	mov ax,165
	mov bx,129
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,168
	mov bx,131
	mov loopv,7
	mov looph,2
	call drawpixel
	
	mov ax,165
	mov bx,138
	mov loopv,2
	mov looph,7
	call drawpixel
	
	;2
	mov ax,164
	mov bx,177
	mov loopv,2
	mov looph,7
	call drawpixel
	
	mov ax,171
	mov bx,180
	mov loopv,2
	mov looph,2
	call drawpixel
	
	mov ax,167
	mov bx,182
	mov loopv,2
	mov looph,4
	call drawpixel
	
	mov ax,164
	mov bx,184
	mov loopv,1
	mov looph,7
	call drawpixel
	
	mov ax,164
	mov bx,185
	mov loopv,2
	mov looph,2
	call drawpixel
	
	mov ax,164
	mov bx,187
	mov loopv,2
	mov looph,9
	call drawpixel
	
;3
	mov ax,165
	mov bx,228
	mov loopv,2
	mov looph,7
	call drawpixel
	
	mov ax,172
	mov bx,230
	mov loopv,3
	mov looph,2
	call drawpixel

	mov ax,167
	mov bx,232
	mov loopv,3
	mov looph,5
	call drawpixel
	
	mov ax,172
	mov bx,234
	mov loopv,3
	mov looph,2
	call drawpixel
	
	mov ax,165
	mov bx,237
	mov loopv,2
	mov looph,7
	call drawpixel
	
;4
	mov ax,164
	mov bx,276
	mov loopv,9
	mov looph,3
	call drawpixel

	mov ax,169
	mov bx,276
	mov loopv,11
	mov looph,2
	call drawpixel		

	mov ax,167
	mov bx,283
	mov loopv,2
	mov looph,2
	call drawpixel

	mov ax,171
	mov bx,283
	mov loopv,2
	mov looph,2
	call drawpixel	

;5
	mov ax,164
	mov bx,324
	mov loopv,2
	mov looph,9
	call drawpixel

	mov ax,164
	mov bx,326
	mov loopv,2
	mov looph,2
	call drawpixel		
	
	mov ax,164
	mov bx,328
	mov loopv,3
	mov looph,7
	call drawpixel

	mov ax,171
	mov bx,330
	mov loopv,3
	mov looph,2
	call drawpixel

	mov ax,164
	mov bx,333
	mov loopv,2
	mov looph,7
	call drawpixel		
	
;actual scores
	lea bp,name1
	mov bl,0fh
	mov cx,10
	mov dh,8
	mov dl,35
	call disp
	
	lea bp,name2
	mov dh,11
	call disp
	
	lea bp,name3
	mov dh,14
	call disp
	
	lea bp,name4
	mov dh,17
	call disp
	
	lea bp,name5
	mov dh,20
	call disp
	
	lea bp,scor1
	mov bl,0fh
	mov cx,3
	mov dh,8
	mov dl,53
	call disp
	
	lea bp,scor2
	mov dh,11
	call disp
	
	lea bp,scor3
	mov dh,14
	call disp
	
	lea bp,scor4
	mov dh,17
	call disp
	
	lea bp,scor5
	mov dh,20
	call disp
	
	ret
scorescreen endp

;-->Print Score
;expects: scorestr = Score in Hex
;	//    sc1 = score in ones
;		  sc2 = score in tens
;		  sc3 = score in hundreds
;		  
pscore proc
	pusha
	
	mov sc1,30h
	mov sc2,30h
	mov sc3,30h
	
	mov cx,scorestr
scloop:
	inc sc1
	cmp sc1,3ah
	je carryten
	jmp __continue0
carryten:
	mov sc1,30h
	inc sc2
__continue0:
	cmp sc2,3ah
	je carryhundred
	jmp __continue1
carryhundred:
	mov sc2,30h
	inc sc3
__continue1:
	
	loop scloop
	
	lea di,crtscore
	mov al,sc3
	stosb
	mov al,sc2
	stosb
	mov al,sc1
	stosb
	
	popa
	ret
pscore endp

;-->Check if Highscore
;expects: tmpoint
;		  pointer for the score
;returns: enable bit 7 true if high
ishigh proc
	pusha
	
	mov bx,tmpoint
	mov si,[bx+2]
	
	lodsb
	cmp sc3,al
	jg highistrue
	jl issober
	
	lodsb
	cmp sc2,al
	jg highistrue
	jl issober
	
	lodsb
	cmp sc1,al
	jg highistrue
	jle issober
	
	highistrue:
		btc enable,7
	issober:
	popa
	ret
ishigh endp


;-->Change Highscore
;expects: tmpoint 
;		  pointer for the correct name/score variable
chghigh proc
	pusha
	
	mov bx,tmpoint
	mov di,[bx]
	mov cx,10
	lea si,nul
	rep movsb
	
	mov bx,tmpoint
	mov di,[bx+2]
	mov cx,3
	lea si,nul
	rep movsb
	
	mov bx,tmpoint
	mov di,[bx]
	mov cx,10
	lea si,crtplayr
	rep movsb
	
	mov bx,tmpoint
	mov di,[bx+2]
	mov cx,3
	lea si,crtscore
	rep movsb
	
	popa
	ret
chghigh endp


;-->Parses the scores from buffer 
;expects: buff = address where the string collected
;				 from the filestreaming is stored
parse proc
	
	xor cx,cx
	lea si,buff
	lea bx,spoint

	mov di,[bx]
looparse:
	lodsb 
	
	cmp al,'/'
	jne cnparse
	
	inc cx
	add bx,2
	mov di,[bx]
	jmp cnparse2
cnparse:
	stosb
cnparse2:
	cmp cx,10
	jge exitparse
	jmp looparse

exitparse:
	ret
parse endp

;-->Encodes the scores from idividual variables
;expects: buff = address to write the variables
;				 in preparation for filestreaming
store proc
	pusha
	
	xor cx,cx ;loop for individual char
	xor dx,dx ;loop for whole string
	
	lea di,buff
	lea bx,spoint
	mov si,[bx]
	
	mov cx,10
loopstore:
	lodsb
	
	cmp al,7fh
	jle belowceil
	jg 	notchar
belowceil:
	cmp al,20h
	jg cnstore
	jmp notchar

cnstore:
	stosb
	loop loopstore
	
notchar:
	inc dx
	add bx,2
	mov si,[bx]
	mov al,'/'
	stosb
	
	bt dx,0
	jc itrscore
;itrname:
	mov cx,10
	jmp cnstore1
itrscore:
	mov cx,4
cnstore1:
	cmp dx,10
	jge exitstore
	jmp loopstore
	
exitstore:
	popa
	ret
store endp

;-->Start Screen Procedure
;		controls the startscreen menu
start proc
	call cls
	call startdisp
	
	btc enable,3

	lea si,lvls
	mov crtlvl,si
	call loadlevel
	
	mov ax,18
	mov bx,5
	mov crtrow,ax
	mov crtcol,bx
	mov crtort,0
	
	call calccoord
	call drawblox_up

awaituser:
	call keymov
	call mousmov
	
	bt enable,0
	jc endstrt
	bt enable,4
	jc endstrt
	jmp awaituser

endstrt:
	ret
start endp


;-->Start Screen Display
;		display various graphics
startdisp proc
	
	mov pcolr,0fh
;B
	mov ax,188
	mov bx,125
	mov loopv,13
	mov looph,35
	call drawpixel
	
	mov ax,188
	mov bx,138
	mov loopv,45
	mov looph,12
	call drawpixel
	
	mov ax,200
	mov bx,148
	mov loopv,13
	mov looph,23
	call drawpixel
	
	mov ax,222
	mov bx,137
	mov loopv,12
	mov looph,12
	call drawpixel
	
	mov ax,222
	mov bx,160
	mov loopv,12
	mov looph,12
	call drawpixel
	
	mov ax,200
	mov bx,171
	mov loopv,12
	mov looph,23
	call drawpixel

;L
	mov ax,257
	mov bx,126
	mov loopv,57
	mov looph,12
	call drawpixel
	
	mov ax,269
	mov bx,172
	mov loopv,11
	mov looph,22
	call drawpixel
	
;O
	mov ax,325
	mov bx,125
	mov loopv,12
	mov looph,24
	call drawpixel
	
	mov ax,314
	mov bx,137
	mov loopv,35
	mov looph,12
	call drawpixel
	
	mov ax,348
	mov bx,137
	mov loopv,35
	mov looph,12
	call drawpixel
	
	mov ax,326
	mov bx,171
	mov loopv,12
	mov looph,24
	call drawpixel
	
;X
	mov ax,382
	mov bx,125
	mov loopv,13
	mov looph,11
	call drawpixel
	
	mov ax,428
	mov bx,125
	mov loopv,13
	mov looph,11
	call drawpixel
	
	mov ax,393
	mov bx,137
	mov loopv,12
	mov looph,13
	call drawpixel
	
	mov ax,416
	mov bx,137
	mov loopv,12
	mov looph,13
	call drawpixel
	
	mov ax,405
	mov bx,148
	mov loopv,13
	mov looph,12
	call drawpixel
	
	mov ax,393
	mov bx,160
	mov loopv,12
	mov looph,13
	call drawpixel
	
	mov ax,416
	mov bx,160
	mov loopv,12
	mov looph,13
	call drawpixel
	
	mov ax,382
	mov bx,171
	mov loopv,13
	mov looph,11
	call drawpixel
	
	mov ax,428
	mov bx,171
	mov loopv,13
	mov looph,11
	call drawpixel
	
	;small letters
	;start
	;s
	mov ax,281
	mov bx,230
	mov loopv,2
	mov looph,6
	call drawpixel
	
	mov ax,279
	mov bx,232
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,281
	mov bx,234
	mov loopv,3
	mov looph,5
	call drawpixel
	
	mov ax,286
	mov bx,236
	mov loopv,3
	mov looph,3
	call drawpixel

	mov ax,279
	mov bx,239
	mov loopv,2
	mov looph,8
	call drawpixel
	
	
	;t
	mov ax,292
	mov bx,230
	mov loopv,2
	mov looph,7
	call drawpixel
	
	mov ax,294
	mov bx,232
	mov loopv,9
	mov looph,3
	call drawpixel
	
	;a
	mov ax,306
	mov bx,230
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,304
	mov bx,232
	mov loopv,9
	mov looph,2
	call drawpixel
	
	mov ax,306
	mov bx,234
	mov loopv,2
	mov looph,4
	call drawpixel
	
	mov ax,310
	mov bx,232
	mov loopv,9
	mov looph,3
	call drawpixel
	
	;r
	mov ax,317
	mov bx,230
	mov loopv,2
	mov looph,7
	call drawpixel
	
	mov ax,317
	mov bx,232
	mov loopv,9
	mov looph,2
	call drawpixel
	
	mov ax,324
	mov bx,232
	mov loopv,3
	mov looph,2
	call drawpixel
	
	mov ax,319
	mov bx,234
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,322
	mov bx,236
	mov loopv,3
	mov looph,2
	call drawpixel
	
	mov ax,324
	mov bx,238
	mov loopv,3
	mov looph,2
	call drawpixel

	;t
	mov ax,330
	mov bx,230
	mov loopv,2
	mov looph,7
	call drawpixel
	
	mov ax,332
	mov bx,232
	mov loopv,9
	mov looph,3
	call drawpixel
	
	
	;scores
	;s
	
	mov ax,189
	mov bx,372
	mov loopv,2
	mov looph,6
	call drawpixel
	
	mov ax,187
	mov bx,374
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,189
	mov bx,376
	mov loopv,3
	mov looph,5
	call drawpixel
	
	mov ax,194
	mov bx,378
	mov loopv,3
	mov looph,3
	call drawpixel

	mov ax,187
	mov bx,381
	mov loopv,2
	mov looph,8
	call drawpixel
	
	;c
	
	mov ax,202
	mov bx,372
	mov loopv,2
	mov looph,6
	call drawpixel
	
	mov ax,200
	mov bx,374
	mov loopv,7
	mov looph,3
	call drawpixel
	
	mov ax,207
	mov bx,374
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,207
	mov bx,379
	mov loopv,2
	mov looph,3
	call drawpixel
	
	mov ax,202
	mov bx,380
	mov loopv,3
	mov looph,6
	call drawpixel
	
	;o
	mov ax,216
	mov bx,372
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,214
	mov bx,374
	mov loopv,7
	mov looph,2
	call drawpixel
	
	mov ax,220
	mov bx,374
	mov loopv,7
	mov looph,3
	call drawpixel
	
	mov ax,216
	mov bx,380
	mov loopv,3
	mov looph,5
	call drawpixel
	
	;r
	mov ax,227
	mov bx,372
	mov loopv,2
	mov looph,7
	call drawpixel
	
	mov ax,227
	mov bx,374
	mov loopv,9
	mov looph,2
	call drawpixel
	
	mov ax,234
	mov bx,374
	mov loopv,3
	mov looph,2
	call drawpixel
	
	mov ax,229
	mov bx,376
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,232
	mov bx,378
	mov loopv,3
	mov looph,2
	call drawpixel
	
	mov ax,234
	mov bx,380
	mov loopv,3
	mov looph,2
	call drawpixel
	
	;e
	mov ax,240
	mov bx,372
	mov loopv,2
	mov looph,8
	call drawpixel
	
	mov ax,240
	mov bx,374
	mov loopv,9
	mov looph,3
	call drawpixel
	
	mov ax,243
	mov bx,377
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,243
	mov bx,381
	mov loopv,2
	mov looph,5
	call drawpixel
	
	;s
	mov ax,254
	mov bx,372
	mov loopv,2
	mov looph,6
	call drawpixel
	
	mov ax,252
	mov bx,374
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,254
	mov bx,376
	mov loopv,3
	mov looph,5
	call drawpixel
	
	mov ax,259
	mov bx,378
	mov loopv,3
	mov looph,3
	call drawpixel

	mov ax,252
	mov bx,381
	mov loopv,2
	mov looph,8
	call drawpixel
	
	;exit
	;e
	mov ax,376
	mov bx,372
	mov loopv,2
	mov looph,8
	call drawpixel
	
	mov ax,376
	mov bx,374
	mov loopv,9
	mov looph,3
	call drawpixel
	
	mov ax,379
	mov bx,377
	mov loopv,2
	mov looph,5
	call drawpixel
	
	mov ax,379
	mov bx,381
	mov loopv,2
	mov looph,5
	call drawpixel
	
	;x
	mov ax,388
	mov bx,372
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,396
	mov bx,372
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,390
	mov bx,374
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,394
	mov bx,374
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,392
	mov bx,376
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,390
	mov bx,378
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,394
	mov bx,378
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,388
	mov bx,380
	mov loopv,3
	mov looph,3
	call drawpixel
	
	mov ax,396
	mov bx,380
	mov loopv,3
	mov looph,3
	call drawpixel
	
	;I
	mov ax,404
	mov bx,372
	mov loopv,11
	mov looph,3
	call drawpixel
	
	;t
	mov ax,410
	mov bx,372
	mov loopv,3
	mov looph,7
	call drawpixel
	
	mov ax,412
	mov bx,374
	mov loopv,9
	mov looph,3
	call drawpixel
	
	ret
startdisp endp


;-->Keyboard Movement
keymov proc
	pusha

	mov ah,11h
	int 16h
	jz awaitinput
	
	
	mov ah,10h
	int 16h
	
	cmp ah,48h
	je upmov
	cmp ah,50h
	je dnmov
	cmp ah,4dh
	je rtmov
	cmp ah,4bh
	je ltmov
	cmp ah,01h
	je __endblox
	cmp ah,1ch
	je entkey
	jmp awaitinput1
	
entkey:
	btc enable,4
	jmp awaitinput
__endblox:
	btc enable,0
	jmp awaitinput
upmov:
	mov dl,0
	jmp cnmov
dnmov:
	mov dl,1
	jmp cnmov
rtmov:
	mov dl,2
	jmp cnmov
ltmov:
	mov dl,3
cnmov:
	call movblox
awaitinput1:
	call decscore
awaitinput:

	popa
	ret
keymov endp

;-->Mousemovement
mousmov proc
	pusha
	
	mov tstm,0
	
	mov ax,5
	mov bx,0
	int 33h
	bt bx,0
	jnc nomousein
	
	mov mcorx,cx
	mov mcory,dx
	
	mov ax,crtrow
	mov bx,crtcol
	call calccoord
	
	;IF ORT IS 0
	mov refx0,ax
	add refx0,29
	mov refy0,bx

	mov cx,mcorx
	cmp cx,refx0
	jg posx0
	btc tstm,0
posx0:
	mov dx,mcory
	cmp dx,refy0
	jg posy0
	btc tstm,1
posy0:
	
	xor dx,dx
	
	bt tstm,0
	jc q2q4
	
	;q1q3 (quadrant 1 and 3)
	bt tstm,1
	jc mupmov
	jmp mrtmov
	
	q2q4:
	bt tstm,1
	jc mltmov
	jmp mdnmov
	

mupmov:
	mov dl,0
	jmp mcnmov
mdnmov:
	mov dl,1
	jmp mcnmov
mrtmov:
	mov dl,2
	jmp mcnmov
mltmov:
	mov dl,3
mcnmov:
	call movblox
	
	call decscore
nomousein:	
	popa
	ret
mousmov endp

;-->Decrements score
decscore proc
	pusha
	bt enable,3
	jc exitdecs
	
	dec scorestr
	mov ax,scorestr
	aam

	or ax,3030h
	xchg ah,al
	mov scorebuf0,ax
	
	lea bp,scorebuf0
	mov bl,0fh
	mov cx,2
	mov dh,1
	mov dl,42
	call disp
exitdecs:
	popa
	ret
decscore endp

;-->Initialize level values
;expects: tmplevel
;returns: tmpoint = pointer to existing name and score for a level
;		  crtlvl = pointer to existing level array
;		  endrow,endcol,bgnc,bgnr
initlevel proc
	pusha
	mov scorestr,100
	mov enable,0
	mov timestr,0
	mov minstr0,0
	mov secstr0,0
	xor ax,ax
	
	lea bx,spoint
	mov cx,tmplvl
	dec cx
	cmp cx,0
	je okoffset
setpoint:
	add bx,4
	loop setpoint
okoffset:
	mov tmpoint,bx
	
	mov cx,tmplvl
	lea si,lvlpoint
lvlp:
	lodsw
	loop lvlp
	mov crtlvl,ax
	
	xor ax,ax
	mov cx,tmplvl
	lea si,ar_endrow
endr:
	lodsb
	loop endr
	mov endrow,ax
	
	xor ax,ax
	mov cx,tmplvl
	lea si,ar_endcol
endcl:
	lodsb
	loop endcl
	mov endcol,ax
	
	xor ax,ax
	mov cx,tmplvl
	lea si,ar_strtrow
bgnr:
	lodsb
	loop bgnr
	mov crtrow,ax
	
	xor ax,ax
	mov cx,tmplvl
	lea si,ar_strtcol
bgnc:
	lodsb
	loop bgnc
	mov crtcol,ax
	popa
	ret
initlevel endp

;-->Master Movement procedure, with inbuilt time system
mastmov proc
	pusha
	
waitfirst:
	mov ax,3
	int 33h
	bt bx,0
	jc timloop

	mov ah,11h
	int 16h
	jz waitfirst

timloop:
	mov ah,02ch ;get system time
	int 21h		;returns ch = hour cl = min dh = sec 

	mov bh,dh   ; dh has current second
getsec:      	; loops until the current second is not equal to the last, in bh
	mov ah,02ch
	int 21h
	
	call keymov
	call mousmov

	;instruction to stop timer
	;check if quit
	bt enable,0
	jc getexit
	;check if win
	bt enable,1
	jc getexit
	;check if score is zero
	cmp scorestr,0
	je lostgame
	
	cmp bh,dh  ; here is the comparison to exit the loop and perform tick
	jne tick
	jmp getsec

	tick:
	inc timestr
	mov ax,timestr
	mov bl,60
	div bl 		;AH contains seconds, AL contains minutes
	
	push ax
	shr ax,8 	;take care of seconds first
	aam		 	;seconds converted to bcd seconds
	or ax,3030h
	xchg ah,al
	mov secstr0,ax
	
	lea bp,secstr0
	mov bl,0fh
	mov cx,2
	mov dh,2
	mov dl,44
	call disp
	
	pop ax
	and ax,00ffh ;take care of minutes
	aam		 	 ;seconds converted to bcd seconds
	or ax,3030h
	xchg ah,al
	mov minstr0,ax
	
	lea bp,minstr0
	mov cx,2
	mov dl,41
	call disp
	
	bt enable,0
	jnc timloop
	
lostgame:
	btc enable,2
getexit:
	popa
	ret
mastmov endp

;-->Display message
;expects: BP = string to write
;		  BL = attribute
;		  CX = len
;		  DX = coord
disp proc
	pusha

	mov ax,1301h
	mov bh,00
	;mov bl,attrc
	;mov cx,stringclen
	;mov dh,rowc
	;mov dl,colc
	;lea bp,stringc
	int 10h

	popa
	ret
disp endp

;-->Clear Screen
CLS proc
	pusha
	mov ax,0003h
	int 10h	
	mov ax,0012h
	int 10h	
	
	mov ax,1
	int 33h
	popa
	ret
CLS ENDP

;-->moves the blox location
movblox proc
	pusha
	
	call setblox
	cmp isokmov,1 ;checks if valid mov, if not exit
	jne exitmovblox
	call resetfield
	
	mov ax,tmprow
	mov crtrow,ax
	mov ax,tmpcol
	mov crtcol,ax
	mov ax,tmport
	mov crtort,ax
	
	mov ax,crtrow
	mov bx,crtcol
	
	cmp ax,endrow
	jne contmov
	cmp bx,endcol
	jne contmov
	cmp crtort,0
	je winmov
	jmp contmov
	
winmov:
	btc enable,1
contmov:
	call calccoord
	
	cmp crtort,2
	je blox_bck
	cmp crtort,1
	je blox_fw
	
	;blox_up
	call drawblox_up
	jmp exitmovblox
	blox_fw:
	call drawblox_downfwd
	jmp exitmovblox
	blox_bck:
	call drawblox_downbck
	
exitmovblox:
	popa
	ret
movblox endp


;-->sets the block location
;expects: crtort = current blox orientaion
;		  DL = expected movement input
;				0 UP
;				1 DN
;				2 RIGHT
;				3 LEFT
;returns : crtrow = new block row
;		   crtcol = new block col
;		   crtort = new block orientaion
;		   isokmov = set if valid
setblox proc
	pusha
	mov isokmov,0h
	
	mov ax,crtort
	mov tmport,ax
	
	mov ax,crtcol
	mov tmpcol,ax
	
	mov ax,crtrow
	mov tmprow,ax
	shr ax,1
	jc oddmove
	
;if not carry then even move
;evenmove:

	cmp tmport,0
	je efromup
	cmp tmport,1
	je efromdnfw
	
	;efrombck
	
	shr dl,1
	jc ebck_oneorthree
	
	;zeroortwo
		shr dl,1
		jc ebck_itstwo
	
		;itszero
			mov tmport,2
			jmp mov1
		ebck_itstwo:
			mov tmport,0
			jmp mov2
	
	ebck_oneorthree:
		shr dl,1
		jc ebck_itsthree
		
		;itsone
			mov tmport,2
			jmp mov4
		ebck_itsthree:
			mov tmport,0
			jmp mov6
	
	efromdnfw:
	shr dl,1
	jc efw_oneorthree
	
		shr dl,1
		jc efw_itstwo
	
		;itszero
			mov tmport,0
			jmp mov7
		efw_itstwo:
			mov tmport,1
			jmp mov2
	
	efw_oneorthree:
		shr dl,1
		jc efw_itsthree
		
		;itsone
			mov tmport,0
			jmp mov4
		efw_itsthree:
			mov tmport,1
			jmp mov3
	
	efromup:
	shr dl,1
	jc eup_oneorthree
	
		shr dl,1
		jc eup_itstwo
	
		;itszero
			mov tmport,1
			jmp mov1
		eup_itstwo:
			mov tmport,2
			jmp mov9
	
	eup_oneorthree:
		shr dl,1
		jc eup_itsthree
		
		;itsone
			mov tmport,1
			jmp mov10
		eup_itsthree:
			mov tmport,2
			jmp mov3
	
oddmove:
	cmp tmport,0
	je ofromup
	cmp tmport,1
	je ofromdnfw
	
	;efrombck
	shr dl,1
	jc obck_oneorthree
	
		shr dl,1
		jc obck_itstwo
	
		;itszero
			mov tmport,2
			jmp mov8
		obck_itstwo:
			mov tmport,0
			jmp mov5
	
	obck_oneorthree:
		shr dl,1
		jc obck_itsthree
		
		;itsone
			mov tmport,2
			jmp mov2
		obck_itsthree:
			mov tmport,0
			jmp mov6
	
	ofromdnfw:
	shr dl,1
	jc ofw_oneorthree
	
		shr dl,1
		jc ofw_itstwo
	
		;itszero
			mov tmport,0
			jmp mov7
		ofw_itstwo:
			mov tmport,1
			jmp mov5
	
	ofw_oneorthree:
		shr dl,1
		jc ofw_itsthree
		
		;itsone
			mov tmport,0
			jmp mov2
		ofw_itsthree:
			mov tmport,1
			jmp mov1	
	ofromup:
	shr dl,1
	jc oup_oneorthree
	
		shr dl,1
		jc oup_itstwo
	
		;itszero
			mov tmport,1
			jmp mov8
		oup_itstwo:
			mov tmport,2
			jmp mov9
	
	oup_oneorthree:
		shr dl,1
		jc oup_itsthree
		
		;itsone
			mov tmport,1
			jmp mov10
		oup_itsthree:
			mov tmport,2
			jmp mov1
		
mov1:
	dec tmprow
	jmp checkmov
mov2:
	inc tmprow
	jmp checkmov
mov3:
	dec tmprow
	dec tmpcol
	jmp checkmov
mov4:
	inc tmprow
	dec tmpcol
	jmp checkmov
mov5:
	inc tmprow
	inc tmpcol
	jmp checkmov
mov6:
	sub tmprow,2
	dec tmpcol
	jmp checkmov
mov7:
	sub tmprow,2
	inc tmpcol
	jmp checkmov
mov8:
	dec tmprow
	inc tmpcol
	jmp checkmov
mov9:
	add tmprow,2
	inc tmpcol
	jmp checkmov
mov10:
	add tmprow,2
	dec tmpcol
	
checkmov:


	mov cx,tmprow
	inc cx
	mov dx,crtlvl
	mov si,dx
loadrow:
	lodsw
	cmp cx,2
	jg __coninueloop
	push ax
__coninueloop:
	loop loadrow
	
	pop ax
	call check1
	cmp isokmov,1
	jne exitmov0
	

	cmp tmport,2
	je dnbck_ort
	cmp tmport,1
	je dnfw_ort
	;if not bw or fw jmp exitmov otherwise
	jmp exitmov0

	
dnbck_ort:
	pop ax
	mov dx,tmprow
	shr dx,1
	jc obck
	
	;ebck
	call check2
	jmp exitmov
	
	obck:
	call check1
	jmp exitmov
	

dnfw_ort:
	pop ax
	mov dx,tmprow
	shr dx,1
	jc ofwd
	
	;efwd
	call check1
	jmp exitmov
	
	ofwd:
	call check3
	jmp exitmov
	
	
exitmov0:
	;pop ax to normalize stack
	pop ax
exitmov:	
	popa
	ret
setblox endp

;-->Check tile type 1 row same
;expects: ax = row word
;		  tmpcol = new col value
;returns: isokmov set if tile is present
check1 proc
	pusha
	
	xor cx,cx
	mov bx,tmpcol
	mov cl,bl
	inc cl
	shr ax,cl
	jnc invalidmov1
	mov isokmov,1
	jmp exitcheck1
	
invalidmov1:
	mov isokmov,0
exitcheck1:	
	popa
	ret
check1 endp

;-->Check tile type 2 row -
;expects: ax = row word
;		  tmpcol = new col value
;returns: isokmov set if tile is present
check2 proc
	pusha
	
	xor cx,cx
	mov bx,tmpcol
	mov cl,bl
	shr ax,cl
	jnc invalidmov2
	mov isokmov,1
	jmp exitcheck2
	
invalidmov2:
	mov isokmov,0
exitcheck2:	
	popa
	ret
check2 endp

;-->Check tile type 3 row +
;expects: ax = row word
;		  tmpcol = new col value
;returns: isokmov set if tile is present
check3 proc
	pusha
	
	xor cx,cx
	mov bx,tmpcol
	mov cl,bl
	inc cl
	inc cl
	shr ax,cl
	jnc invalidmov3
	mov isokmov,1
	jmp exitcheck3
	
invalidmov3:
	mov isokmov,0
exitcheck3:	
	popa
	ret
check3 endp

;-->Resets Field
;expects : crtrow = current block row
;		   crtcol = current block col
;		   crtlvl = address of current level array
;warning : COL SHOULD NOT BE LESS THAN 1
resetfield proc
	pusha
	
	mov cx,crtrow 		;moves the row value to counter
	inc cx 				;increment the counter to use in a loop
	mov dx,crtlvl 		;move the address of current level array to dx
	mov si,dx 			;to be transferred into the source index
findrow:
	lodsw 				;in usage for lodsw that will store the array element in ax
	
	cmp cx, 5			;compares the counter to be less or equal to 5 (number of words to be pushed)
	jg continueloop     ;if not continue loading
	push ax
continueloop:
	loop findrow		;loop will stop with the stack loaded with 5 words
	
	pop ax				;pop stack, first word does not need searching
	
	mov ax,crtrow		;reset current tile first
	mov bx,crtcol
	
	cmp ax,endrow
	jne notspecial0
	cmp bx,endcol
	jne notspecial0
	mov dl,0EH
	jmp continue0
notspecial0:
	mov dl,8h
continue0:
	mov dh,0
	call calccoord 
	call drawtile 

	
	mov ax,1d			
findcol:
	pop dx				;restores word, pop should perform 4 times
	mov crtwrd,dx		;store to crtwrd
	mov bx,crtcol		;moves current column to bx
	
	mov cx,crtrow
	shr cx,1
	jnc evenreset
	
;odd row reset
	xor cx,cx
	cmp ax,4d			;findcol loops 1 times
	je oddloopone
	cmp ax,1d			;findcol loops 2 times
	je oddlooptwo
	cmp ax,3d
	je oddlooptwo
	
oddloopthree:
	dec bx
	inc cx
oddlooptwo:
	inc cx
oddloopone:
	inc cx
	jmp continuereset

;even row reset
evenreset:
	xor cx,cx
	cmp ax,4d			;findcol loops 1 times
	je evenloopone
	cmp ax,1d			;findcol loops 2 times
	je evenlooptwo
	cmp ax,3d
	je evenlooptwo
	
evenloopthree:
	inc cx
evenlooptwo:
	dec bx
	inc cx
evenloopone:
	inc cx
	
continuereset:
	push ax				;push ax the row iterator
	sub ax,crtrow
	not ax
	inc ax				;determine true row value

loopcol:
	push cx
	xor cx,cx
	
	mov dx,crtwrd
	mov cl,bl
	inc cl
	push bx
	push ax
	shr dx,cl
	jc foundtile
	
;no carry
	mov dh,0h
	mov dl,0h
	jmp continue2
;carry is set
foundtile:	
	cmp ax,endrow
	jne notspecial
	cmp bx,endcol
	jne notspecial
	mov dl,0EH
	jmp continue
notspecial:
	mov dl,8h
continue:
	mov dh,0
continue2:
	call calccoord 
	call drawtile 
	
	pop ax
	pop bx
	inc bx
	pop cx
	loop loopcol
	
	pop ax
	inc ax
	cmp ax,5
	jl findcol

	popa
	ret
resetfield endp

	
;-->Load Level
;expects: crtlvl = address of level array
;	
;		  endrow = row # of gold tile
;         endcol = col # of gold tile
loadlevel proc
	pusha
	
	xor ax,ax
	xor bx,bx
	
	mov si,crtlvl
drawlvl1:
	lodsw
	mov dx,ax
	
	call drawrow
	
	inc bx
	cmp bx,26
	jle drawlvl1	 
	
	bt enable,3
	jc exitload

	lea bp,strpoint
	mov bl,0fh
	mov cx,lenpnt
	mov dh,1
	mov dl,34
	call disp
	
	lea bp,scorebuf
	mov cx,2
	mov dl,42
	call disp
	
	
	lea bp,strtime
	mov bl,0fh
	mov cx,lentim
	mov dh,2
	mov dl,34
	call disp
	
	lea bp,minstr
	mov cx,2
	mov dl, 41
	call disp
	
	mov ah,02
	mov dl,':'
	int 21h
	
	lea bp,secstr
	mov cx,2
	mov dl, 44
	call disp
	
exitload:	
	
	popa
	ret
loadlevel endp

;-->Compute Coordinates
;expects: AX = row
;		  BX = col
;returns: AX = x coordinates
;		  BX = y coordinates
calccoord proc
pusha
mov row,ax
mov col,bx

sar ax,1
pushf

mov cx,28
mul cx
add ax,70
mov ycord,ax

mov ax,col
mov cx,56
mul cx
mov xcord,ax

popf
jnc endc

	add xcord,28
	add ycord,14
endc:
	popa
	mov ax,xcord
	mov bx,ycord
ret
calccoord endp


;-->Drawpixel
;expects: ax = x coordinates
;         bx = y coordinates
;		  pcolr = color of tile
;		  loopv = vertical loop
;		  looph = horizontal loop
drawpixel proc ;xcord,ycord,loopvert,loophoriz	
	pusha
	
	mov xcord,ax
	
	mov xcoor,ax
	mov ycoor,bx
	mov cx,loopv
pixelset:
	push cx
	mov cx,looph
pixelsetagain:
	push cx
	mov ah,0ch
	mov al,pcolr
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	inc xcoor
	pop cx
	loop pixelsetagain
	
	mov ax,xcord
	mov xcoor,ax
	inc ycoor
	pop cx
	loop pixelset
	
	popa
	ret
drawpixel endp


;-->Draw level row
;expects: DX = row string
;	      BX = row value
drawrow proc
pusha
xor ax,ax
	__drawrow1:
		shr dx,1
		jnc __nodraw
	
		push ax
		push bx
		push dx
	
		mov cx,ax
		mov ax,bx
		mov bx,cx
		
		
		cmp ax,endrow
		jne __notspecial
		cmp bx,endcol
		jne __notspecial
		mov dl,0EH
		jmp __continue
	__notspecial:
		mov dl,8
	__continue:
		mov dh,0
		
		call calccoord 
		call drawtile 
	
		pop dx
		pop bx
		pop ax
		
	__nodraw:
		inc ax
		cmp ax,10
	jle __drawrow1
popa
ret
drawrow endp


;-->Draw Field tile
;expects: AX = x coordinates
;         BX = y coordinates
;		  DH = base colour
;         DL = accent colour
;the procedure compare DH & DL
;if true inside tile is not drawn		
drawtile proc
pusha
mov xcoor,ax 
mov ycoor,bx
mov colour,dh
mov colour2,dl


push xcoor		
push ycoor		

mov horzl,03d
add xcoor,27d
sub ycoor,14d

mov cx,28d 

__tile1:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop:
	
	push cx		
	mov ah,0ch
	mov al,colour
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	

	cmp cx,15d
	jg __increase
	je __oddball
	cmp cx,14d
	jl __decrease
	je __oddball2
	
__increase:
	add horzl,03d
	dec xcoor
__oddball:
	inc horzl
	dec xcoor
	jmp __continue
__decrease:
	sub horzl,03d
	inc xcoor	
__oddball2:
	dec horzl
	inc xcoor
__continue:
	inc ycoor
	LOOP __tile1
	
	
	cmp dh,dl
	je __exitmod

	pop ycoor
	pop xcoor
	
	
	mov horzl,01d
	add xcoor,28d
	sub ycoor,13d

mov cx,27d 

__tile2:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop2:
	
	push cx		
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop2
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	
	cmp cx,15d
	jge __increase2
	jl __decrease2

__increase2:
	add horzl,04d
	sub xcoor,02d
	jmp __continue2
__decrease2:
	sub horzl,04d
	add xcoor,02d
	jmp __continue2

__continue2:
	inc ycoor
	LOOP __tile2
__exitmod:
popa
ret
drawtile endp


;-->Draw Blox | | UP | |
;expects: AX = x coordinates
;         BX = y coordinates
;      	  or use calccoord procedure
;         load ax and bx with same values
drawblox_up proc 
pusha
mov xcoor,ax 
mov ycoor,bx
mov colour,bsclr
mov colour1,acnt1
mov colour2,acnt2

push xcoor
push ycoor
push xcoor 
push ycoor 
push xcoor 
push ycoor 

;DRAW __border
mov horzl,03d
add xcoor,27d
sub ycoor,70d

mov cx,85d 

__border:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop:
	
	push cx		
	mov ah,0ch
	mov al,colour
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	

	cmp cx,72d
	jg __increase
	je __oddball
	cmp cx,15d
	je __oddball2
	jg __continue
	jl __decrease
	
__increase:
	add horzl,02d
	dec xcoor
__oddball:
	add horzl,02d
	dec xcoor
	jmp __continue
__decrease:
	sub horzl,02d
	inc xcoor
__oddball2:
	sub horzl,02d
	inc xcoor
__continue:
	inc ycoor
	LOOP __border

;DRAW COLOR 1
	pop ycoor 
	pop xcoor 
	
	mov horzl,01d
	add xcoor,28d
	sub ycoor,69d

mov cx,27d 

__drawcolour1:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop2:
	
	push cx		
	mov ah,0ch
	mov al,colour1
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop2
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	
	cmp cx,15d
	jge __increase2
	jl __decrease2

__increase2:
	add horzl,04d
	sub xcoor,02d
	jmp __continue2
__decrease2:
	sub horzl,04d
	add xcoor,02d
__continue2:
	inc ycoor
	LOOP __drawcolour1

	;draw2-----------------------------
	pop ycoor 
	pop xcoor 
	

	mov horzl,02d
	add xcoor,01d
	sub ycoor,54d
	
	mov cx,67d

__drawcolour2:

	push cx		
	
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop3:
	
	push cx		
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	LOOP __horzloop3
	
	pop ycoor   
	pop xcoor	
	
	pop cx 		
	cmp cx,55d
	jg __increase3
	je __oddball3
	cmp cx,14d
	jg __continue3
	je __oddball4
	jl __decrease3

__increase3:
	inc horzl
__oddball3:
	inc horzl
	jmp __continue3
__decrease3:
	dec horzl
	inc xcoor	
__oddball4:
	dec horzl
	inc xcoor
__continue3:
	inc ycoor
	LOOP __drawcolour2

;DRAW 3----------------------------
	pop ycoor ;2
	pop xcoor ;1
	

	mov horzl,02d
	add xcoor,54d
	sub ycoor,54d
	
	mov cx,67d;68

__drawcolour3:
	push cx		
	
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop4:
	
	push cx		
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	LOOP __horzloop4
	
	pop ycoor   
	pop xcoor	
	
	pop cx 		
	cmp cx,55d
	jg __increase4
	je __oddball5
	cmp cx,14d
	jg __continue4
	je __oddball6
	jl __decrease4

__increase4:
	inc horzl
	dec xcoor
__oddball5:
	inc horzl
	dec xcoor
	jmp __continue4
__decrease4:
	dec horzl
__oddball6:
	dec horzl
__continue4:
	inc ycoor
	LOOP __drawcolour3
popa
ret
drawblox_up endp


;-->Draw Blox \ \ DOWN BACKWARD \ \
;expects: AX = x coordinates
;         BX = y coordinates
;      	  or use calccoord procedure
;         load ax and bx with same values
drawblox_downbck proc
pusha
mov xcoor,ax 
mov ycoor,bx
mov colour,bsclr
mov colour1,acnt1
mov colour2,acnt2

push xcoor
push ycoor
push xcoor
push ycoor
push xcoor
push ycoor

;DRAW __border-------------------------------------
mov horzl,03d
sub xcoor,1d
sub ycoor,56d
;add xcoor,27d
;sub ycoor,42d

mov cx,42d 

__background0:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop0:
	
	push cx		
	mov ah,0ch
	mov al,colour
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop0
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	

	cmp cx,29d
	jg __increase
	je __oddball
	cmp cx,15d
	jg __increaseright
	Je __oddball2
	jl __continue0

__increase:
	inc horzl
	dec xcoor
__oddball:
	inc horzl
	dec xcoor
__increaseright:
	inc horzl
__oddball2:
	inc horzl
__continue0:
	inc ycoor
	LOOP __background0
	

mov cx,29d 
background1:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop:
	
	push cx		
	mov ah,0ch
	mov al,colour
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	

	cmp cx,29d
	je __oddball3
	cmp cx,15d
	je __oddball4
	jg __decreaseleft
	jl __decrease

__oddball3:
	inc xcoor
	dec horzl
	jmp __continue
__oddball4:
	add xcoor,02
	sub horzl,03
	jmp __continue
__decrease:
	sub horzl,02d
__decreaseleft:
	sub horzl,02d
	add xcoor,02d
__continue:
	inc ycoor
	LOOP background1
	

;DRAW colour1-----------------------------------
pop ycoor
pop xcoor	
	
mov horzl,02d
add xcoor,54d
sub ycoor,26d

;add xcoor,82d
;sub ycoor,12d

mov cx,39d 

__drawcolour1:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop1:
	
	push cx		
	mov ah,0ch
	mov al,colour1
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	 
	inc xcoor	
	loop __horzloop1
	
	pop ycoor    
	pop xcoor	
	pop cx 		
	

	cmp cx,27d
	jg __increaseleft1
	je __oddball5
	cmp cx,14d
	je __oddball6
	jg __continue1
	jl __decreaseright1
	
	
__increaseleft1:
	inc horzl
	dec xcoor
__oddball5:
	inc horzl
	dec xcoor
	jmp __continue1
__decreaseright1:
	dec horzl
__oddball6:
	dec horzl
__continue1:
	inc ycoor
	LOOP __drawcolour1


;DRAW colour2-----------------------------------
pop ycoor
pop xcoor	
	
mov horzl,01d
;add xcoor,1d
sub ycoor,55

;add xcoor,28d
;sub ycoor,41d

mov cx,41d 

__drawcolour2:
	push cx		
	push xcoor	 
	push ycoor	 
	
	mov cx,horzl
	
	__horzloop2:
	
	push cx		 
	
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	

	pop cx  	
	inc xcoor
	loop __horzloop2
	
	
	pop ycoor   
	pop xcoor	
	pop cx 		 
	

	cmp cx,28d
	jg __increase2
	cmp cx,14d
	jg __slantright
	jle __decrease2
	
	
__increase2:
	add horzl,04d
	sub xcoor,02d
	jmp __continue2
__slantright:
	add xcoor,02d
	jmp __continue2
__decrease2:
	sub horzl,04d
	add xcoor,02d
__continue2:
	inc ycoor
	LOOP __drawcolour2
	
	
;DRAW colour3-----------------------------------
pop ycoor
pop xcoor	
	
mov horzl,02d
sub xcoor,27d
sub ycoor,40
;add xcoor,01d
;sub ycoor,26d

mov cx,53 

__drawcolour3:
	push cx		
	push xcoor	
	push ycoor	 
	
	mov cx,horzl
	
	__horzloop3:
	
	push cx		
	
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	

	pop cx  	 
	inc xcoor
	loop __horzloop3
	
	
	pop ycoor    
	pop xcoor	
	pop cx 		 
	

	cmp cx,28d
	jg increaseright2
	je __oddball7
	cmp cx, 27d
	je __oddball8
	jl decreaseleft2
	
__oddball7:
	inc xcoor
	dec horzl
increaseright2:
	add horzl,2d
	jmp __continue3

decreaseleft2:
	dec horzl
__oddball8:
	add xcoor,2d
	dec horzl
	jmp __continue3
	
__continue3:
	inc ycoor
	LOOP __drawcolour3
popa
ret
drawblox_downbck endp

;-->Draw Blox / / DOWN FORWARD / /
;expects: AX = x coordinates
;         BX = y coordinates
;      	  or use calccoord procedure
;         load ax and bx with same values
drawblox_downfwd proc
pusha
mov xcoor,ax 
mov ycoor,bx
mov colour,bsclr
mov colour1,acnt1
mov colour2,acnt2


push xcoor
push ycoor
push xcoor
push ycoor
push xcoor
push ycoor

;DRAW __border-------------------------------------
mov horzl,03d
add xcoor,55d
sub ycoor,56d

mov cx,42d 

__background0:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop0:
	
	push cx		
	mov ah,0ch
	mov al,colour
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop0
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	

	cmp cx,29d
	jg __increase
	je __oddball
	cmp cx,15d
	jg __increaseleft
	Je __oddball2
	jl __continue0

__increase:
	inc horzl
__oddball:
	inc horzl
__increaseleft:
	inc horzl
	dec xcoor
__oddball2:
	inc horzl
	dec xcoor
__continue0:
	inc ycoor
	LOOP __background0
	
mov cx,29d 
__background1:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop:
	
	push cx		
	mov ah,0ch
	mov al,colour
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor	
	loop __horzloop
	
	pop ycoor   
	pop xcoor	
	pop cx 		
	

	cmp cx,29d
	je __oddball3
	cmp cx,15d
	je __oddball4
	jg __decreaseright
	jl __decrease

	
	__decrease:
		dec horzl
		inc xcoor
	__oddball4:
		inc xcoor
		dec horzl
	__decreaseright:
		dec horzl
	__oddball3:
		dec horzl
		
__continue:
	inc ycoor
	LOOP __background1
	


	
;DRAW colour1-----------------------------------
pop ycoor
pop xcoor	
	
mov horzl,02d
add xcoor,01d
sub ycoor,26d

mov cx,39d 

__drawcolour1:
	push cx		
	push xcoor	
	push ycoor	
	
	mov cx,horzl
	
	__horzloop1:
	
	push cx		
	mov ah,0ch
	mov al,colour1
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	 
	inc xcoor	
	loop __horzloop1
	
	pop ycoor    
	pop xcoor	
	pop cx 		
	

	cmp cx,27d
	jg __increaseright1
	je __oddball5
	cmp cx,14d
	je __oddball6
	jg __continue1
	jl __decreaseleft1
	
	
__increaseright1:
	inc horzl
__oddball5:
	inc horzl
	jmp __continue1
	
__decreaseleft1:
	dec horzl
	inc xcoor
__oddball6:
	dec horzl
	inc xcoor
	
	
__continue1:
	inc ycoor
	LOOP __drawcolour1


;DRAW colour2-----------------------------------
pop ycoor
pop xcoor	
	
mov horzl,01d
add xcoor,56d
sub ycoor,55d

mov cx,41d 

__drawcolour2:
	push cx		
	push xcoor	 
	push ycoor	 
	
	mov cx,horzl
	
	__horzloop2:
	
	push cx		 
	
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	
	pop cx  	
	inc xcoor
	loop __horzloop2
	
	
	pop ycoor   
	pop xcoor	
	pop cx 		 
	

	cmp cx,28d
	jg __increase2
	cmp cx,14d
	jg __slantleft
	jle __decrease2
	
	
__increase2:
	add horzl,04d
	sub xcoor,02d
	jmp __continue2
__slantleft:
	sub xcoor,02d
	jmp __continue2
__decrease2:
	sub horzl,04d
	add xcoor,02d
__continue2:
	inc ycoor
	LOOP __drawcolour2

;DRAW colour3-----------------------------------
pop ycoor
pop xcoor	
	
mov horzl,02d
add xcoor,82d
sub ycoor,40d

mov cx,53 

__drawcolour3:
	push cx		
	push xcoor	
	push ycoor	 
	
	mov cx,horzl
	
	__horzloop3:
	
	push cx		
	
	mov ah,0ch
	mov al,colour2
	mov bh,00h
	mov cx,xcoor
	mov dx,ycoor
	int 10h
	

	pop cx  	 
	inc xcoor
	loop __horzloop3
	
	
	pop ycoor    
	pop xcoor	
	pop cx 		 
	

	cmp cx,28d
	jg __increaseleft2
	je __oddball7
	cmp cx, 27d
	je __oddball8
	jl __decreaseright2
	

__oddball7:
	dec horzl
__increaseleft2:
	sub xcoor,2d
	add horzl,2d
	jmp __continue3

__decreaseright2:
	inc xcoor
	dec horzl
__oddball8:
	dec xcoor
	dec horzl
	jmp __continue3
	
__continue3:
	inc ycoor
	LOOP __drawcolour3
popa
ret
drawblox_downfwd endp

end main