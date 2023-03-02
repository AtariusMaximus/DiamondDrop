
  rem ------------------
  rem  Diamond Drop
  rem  Steve Engelhardt
  rem  3/18/2015
  rem ------------------

  rem Left Difficulty Switch:
  rem  A-Large diamonds
  rem  B-Small diamonds
  rem
  rem Speed (Lo/Hi):
  rem  Indicated on the title screen -
  rem  Press up and down on the joystick before
  rem  pressing fire to start the game.

  dim High_Score01=a
  dim High_Score02=b
  dim High_Score03=c
  dim Save_Score01=d
  dim Save_Score02=e
  dim Save_Score03=f
  dim direction = g
  dim counter = h
  dim counter2 = i
  dim p1x = j
  dim p1y = k
  dim p0x = l
  dim p0y = m
  dim flag=n
  rem  flag{0} marks if the titlescreen is active
  rem  flag{1} is the game speed option
  dim level=o
  dim circle=p
  dim blockx=q
  dim ballxpos=r
  dim blockrand=s
  dim block_endxpos=t
  dim flash=u
  dim scback=v
  dim bomb=w
  dim bombreduce=x
  dim audcounter1=y
  dim audcounter2=z

  dim sc1=score
  dim sc2=score+1
  dim sc3=score+2

  rem reset high score to 0
  High_Score01=0
  High_Score02=0
  High_Score03=0



  rem jump to titlescreen
  goto titlescreen0

init

  rem this is where the titlescreen returns to when you start the game

  rem initialize variables
  direction=1
  COLUPF=8
  circle=1
  score=000000
  pfclear %00000000
  bomb=6
  rem counter=0
  counter2=0
  rem audcounter1=0
  rem audcounter2=0
  const pfscore=1
  pfscore1=168
  pfscore2=168
  ballheight=0

  rem this sets the first line that drops
  pfhline 14 0 18 on

main

  rem if the left difficulty switch is set to B, jump to a sub for smaller diamond sprites.

  if switchleftb then goto smallball
 
  player0:
  %00011000
  %00111100
  %01111110
  %11111111
  %11111111
  %01111110
  %00111100
  %00011000
end
  player1:
  %00011000
  %00111100
  %01111110
  %11111111
  %11111111
  %01111110
  %00111100
  %00011000
end
largeball

  rem audio counter for the falling sound
  if circle=1 then audcounter1=audcounter1+1
  if audcounter1>254 then audcounter1=0

  rem create the falling sound
  AUDF0=audcounter1:AUDC0=14:AUDV0=4

  rem reset the game
  if switchreset then reboot

  rem set the borders on the left and right
  PF0=$FF
 
  rem set the color bar behind the score
  scback=$88

  rem set the playfield score color
  pfscorecolor=$18

  rem this counter is for displaying the missiles
  rem  which create the path for the diamonds
  circle=circle+1
  if circle>24 then circle=1

  rem set colors
  COLUP0=$44:COLUP1=$18:COLUBK=0:COLUPF=$86

  rem set player variables
  player0x=p0x:player0y=p0y
  player1x=p1x:player1y=p1y

  rem set score color to black
  scorecolor=0

  NUSIZ0=$10:NUSIZ1=$10

  rem move the diamonds
  if joy0right && counter2=1 then direction=direction+1
  if joy0left  && counter2=1 then direction=direction-1

  rem speed up the scrolling if you push down
  if joy0down then pfscroll down

  rem reset rotation when you wrap around
  if direction>12 then direction=1
  if direction<1 then direction=12

  rem move the diamonds on the path
  if direction=1 then gosub pos1
  if direction=2 then gosub pos2
  if direction=3 then gosub pos3
  if direction=4 then gosub pos4
  if direction=5 then gosub pos5
  if direction=6 then gosub pos6
  if direction=7 then gosub pos7
  if direction=8 then gosub pos8
  if direction=9 then gosub pos9
  if direction=10 then gosub pos10
  if direction=11 then gosub pos11
  if direction=12 then gosub pos12

  rem draw the missile path for the diamonds
  if circle=1  then  missile1x=60:missile1y=64:missile0x=104:missile0y=68
  if circle=2  then  missile1x=64:missile1y=68:missile0x=100:missile0y=72
  if circle=3  then  missile1x=68:missile1y=72:missile0x=96:missile0y=76
  if circle=4  then  missile1x=72:missile1y=76:missile0x=92:missile0y=80
  if circle=5  then  missile1x=76:missile1y=80:missile0x=88:missile0y=84
  if circle=6  then  missile1x=80:missile1y=84:missile0x=84:missile0y=88
  if circle=7  then  missile1x=84:missile1y=88:missile0x=80:missile0y=84
  if circle=8  then  missile1x=88:missile1y=84:missile0x=76:missile0y=80
  if circle=9  then  missile1x=92:missile1y=80:missile0x=72:missile0y=76
  if circle=10  then  missile1x=96:missile1y=76:missile0x=68:missile0y=72
  if circle=11  then  missile1x=100:missile1y=72:missile0x=64:missile0y=68
  if circle=12  then  missile1x=104:missile1y=68:missile0x=60:missile0y=64
  if circle=13  then  missile1x=108:missile1y=64:missile0x=64:missile0y=60
  if circle=14  then  missile1x=104:missile1y=60:missile0x=68:missile0y=56
  if circle=15  then  missile1x=100:missile1y=56:missile0x=72:missile0y=52
  if circle=16  then  missile1x=96:missile1y=52:missile0x=76:missile0y=48
  if circle=17  then  missile1x=92:missile1y=48:missile0x=80:missile0y=44
  if circle=18  then  missile1x=88:missile1y=44:missile0x=84:missile0y=40
  if circle=19  then  missile1x=84:missile1y=40:missile0x=88:missile0y=44
  if circle=20  then  missile1x=80:missile1y=44:missile0x=92:missile0y=48
  if circle=21  then  missile1x=76:missile1y=48:missile0x=96:missile0y=52
  if circle=22  then  missile1x=72:missile1y=52:missile0x=100:missile0y=56
  if circle=23  then  missile1x=68:missile1y=56:missile0x=104:missile0y=60
  if circle=24  then  missile1x=64:missile1y=60:missile0x=108:missile0y=64

  drawscreen

  rem if you collide with the playfield, the game is over
  if collision(player0,playfield) || collision(player1,playfield) then audcounter2=0:circle=0:goto gameover
  rem if collision(player1,playfield) then audcounter2=0:circle=0:goto gameover

  rem scroll the screen
  if !flag{1} then level=21
  if counter2=1 then pfscroll down

  counter=counter+1
  counter2=counter2+1

  rem this sets the ball to 8 pixels wide
  CTRLPF=$31

  rem move the ball back and forth at the bottom of the screen
  rem when the playfield hits it it resets the scrolling to the top
  ballxpos=ballxpos+1
  if ballxpos>16 then ballxpos=0
  if ballxpos=1 then ballx=52:bally=87:ballx=52:bally=87
  if ballxpos=2 then ballx=60:bally=87:ballx=60:bally=87
  if ballxpos=3 then ballx=68:bally=87:ballx=68:bally=87
  if ballxpos=4 then ballx=76:bally=87:ballx=76:bally=87
  if ballxpos=5 then ballx=84:bally=87:ballx=84:bally=87
  if ballxpos=6 then ballx=92:bally=87:ballx=92:bally=87
  if ballxpos=7 then ballx=100:bally=87:ballx=100:bally=87
  if ballxpos=8 then ballx=108:bally=87
  if ballxpos=9 then ballx=108:bally=87
  if ballxpos=10 then ballx=100:bally=87:ballx=52:bally=87
  if ballxpos=11 then ballx=92:bally=87:ballx=60:bally=87
  if ballxpos=12 then ballx=84:bally=87:ballx=68:bally=87
  if ballxpos=13 then ballx=76:bally=87:ballx=76:bally=87
  if ballxpos=14 then ballx=68:bally=87:ballx=84:bally=87
  if ballxpos=15 then ballx=60:bally=87:ballx=92:bally=87
  if ballxpos=16 then ballx=52:bally=87:ballx=100:bally=87

  rem gradually increase speed
  if level<6 && counter2>5 then counter2=0
  if level>5 && level<11 && counter2>4 then counter2=0
  if level>10 && level<16 && counter2>3 then counter2=0
  if level>15 && level<21 && counter2>2 then counter2=0
  if level>20 && counter2>2 then counter2=0

  rem if the playfield blocks reach the bottom of the screen and touch the ball,
  rem  reset a new barrier, add one to your score and clear the screen
  if collision(ball,playfield) then gosub change_block
  
  rem make sound when you use a bomb
  rem if joy0fire && bomb>0 then AUDF1=31:AUDC1=circle:AUDV1=15

  rem use a bomb to clear the screen
  if joy0fire && bomb>0 then audcounter2=0:AUDF1=31:AUDC1=15:AUDV1=15:gosub usebomb
  if bomb=6 then pfscore1=168:pfscore2=168			: rem 3 3
  if bomb=5 then pfscore1=10:pfscore2=168 			: rem 2 3
  if bomb=4 then pfscore1=4:pfscore2=168  			: rem 1 3
  if bomb=3 then pfscore1=0:pfscore2=168  			: rem 0 3
  if bomb=2 then pfscore1=0:pfscore2=10   			: rem 0 2
  if bomb=1 then pfscore1=0:pfscore2=4   			: rem 0 1
  if bomb<1 then pfscore1=0:pfscore2=0                          : rem 0 0

  rem this counter will turn off the bomb sound after a few seconds
  audcounter2=audcounter2+1
  if audcounter2>12 then audcounter2=14:AUDV1=0

  goto main

  rem this clears the screen with your bomb and keeps track of bombs remaining
usebomb
  pfclear %00000000:AUDV0=0:audcounter1=0
  rem this counter will turn off the bomb sound after a few seconds
  audcounter2=audcounter2+1
  if audcounter2>20 then audcounter2=22:AUDV1=0

  COLUBK=$00:COLUPF=$86:ballx=0:bally=0:PF0=$FF
  missile0x=0:missile0y=0:missile1x=0:missile1y=0
  if bomb=0 then return
  bombreduce=1

  if !joy0fire && bomb=6 then bomb=5:goto change_block
  if !joy0fire && bomb=5 then bomb=4:goto change_block
  if !joy0fire && bomb=4 then bomb=3:goto change_block
  if !joy0fire && bomb=3 then bomb=2:goto change_block
  if !joy0fire && bomb=2 then bomb=1:goto change_block
  if !joy0fire && bomb=1 then bomb=0:goto change_block
  drawscreen
  goto usebomb

  rem this sub runs when you collide with a barrier
gameover
  audcounter2=audcounter2+1
  if audcounter2>60 then audcounter2=0:circle=1
  flash=flash+$02
  if flash>$FF then flash=$00
  PF0=flash
  COLUBK=0:COLUP0=$44:COLUP1=$18:COLUPF=$82
  missile0x=0:missile0y=0:missile1x=0:missile1y=0:ballx=0:bally=0
  if circle=1 then AUDV0=0:goto skipaud2
  AUDF0=31:AUDC0=audcounter2:AUDV0=12
skipaud2
  drawscreen
  if joy0fire then goto startup
  goto gameover

startup
  if !joy0fire then gosub HighScoreCalc:goto titlescreen
  drawscreen
  goto startup

  rem the subs below position the missiles, creating the path

pos1

  p0x=56:p0y=64
  p1x=104:p1y=64
  return

pos2

  p0x=60:p0y=68
  p1x=100:p1y=60
  return

pos3

  p0x=64:p0y=72
  p1x=96:p1y=56
  return

pos4

  p0x=68:p0y=76
  p1x=92:p1y=52
  return

pos5

  p0x=72:p0y=80
  p1x=88:p1y=48
  return

pos6

  p0x=76:p0y=84
  p1x=84:p1y=42
  return

pos7

  p0x=80:p0y=88
  p1x=80:p1y=42
  return

pos8

  p0x=84:p0y=84
  p1x=76:p1y=42
  return

pos9

  p0x=88:p0y=80
  p1x=72:p1y=48
  return

pos10

  p0x=92:p0y=76
  p1x=68:p1y=52
  return

pos11

  p0x=96:p0y=72
  p1x=64:p1y=56
  return

pos12

  p0x=100:p0y=68
  p1x=60:p1y=60
  return

change_block

  rem Calculate X position of the Left side 
redocalc
  blockx = (rand&127)+10

  rem limit range
  if blockx<76 || blockx>84 then goto redocalc

  rem calculate length of block
  blockrand = (rand&2)
  block_endxpos = q + blockrand

  rem pfhline xpos ypos endxpos function 
  counter=0:counter2=0
  pfclear %00000000
  playfieldpos=8
  pfhline blockx 9 block_endxpos on  

  if !flag{0} then score=score+1:level=level+1

  if bombreduce=1 then score=score-1:bombreduce=0:return
  audcounter1=0
  return

titlescreen0

 flag{1}=1

titlescreen

  AUDV0=0:AUDV1=0
  rem ballx=0:bally=0
  
  pfclear %00000000
  pfscore1=0
  pfscore2=0
  counter=200
  flag{0}=1
  level=0
  
  player0:
  %00000000
end
  player1:
  %00000000
end

  ballheight=3
  CTRLPF=$21
  blockx=80

titlescreen2

  if joy0up then level=0:flag{1}=1
  if joy0down then level=1:flag{1}=0

  if flag{1} then ballx=74:bally=82 
  if !flag{1} then ballx=74:bally=87

  if !flag{1} then counter=counter+2:pfscroll down

  rem missile0height=91
  rem missile1height=91

  missile0height=88
  missile1height=88

  missile0x=18:missile0y=88
  missile1x=145:missile1y=88

  NUSIZ0=$05:NUSIZ1=$05

  counter=counter+1
  counter2=counter2+1

  if counter2>3 then counter2=0
  if counter>230 then counter=0:pfclear %00000000:gosub change_block
  if counter2=1 then pfscroll down

  player0x=68:player0y=88
  player1x=84:player1y=88
  COLUP0=$18:COLUP1=$18
  COLUBK=0:COLUPF=blockx+20

  PF0=$FF
  scback=blockx+24
  pfscorecolor=$18

  drawscreen
  if joy0fire then goto startgame

  player0:
  %01111001
  %01001001
  %01001001
  %01111001
  %00000000
  %01111001
  %01001001
  %01001001
  %01111001
  %00000000
  %00000000
  %11010001
  %01010001
  %11011101
  %10010101
  %11011101
  %00000000
  %00000000
  %11111111
  %00000000
  %00000000
  %01001110
  %01000100
  %01100100
  %01000100
  %01101110
  %00000000
  %00000000
  %10001010
  %10001010
  %11101100
  %10101010
  %11101110
  %00000000
  %00000000
  %11111111
  %01111111
  %00111111
  %00011111
  %01111111
  %01000011
  %01011101
  %01011101
  %01011101
  %01000011
  %01111111
  %01011101
  %01011101
  %01011001
  %01010101  
  %01001101
  %01111111
  %01100011
  %01011101
  %01011101
  %01011101
  %01100011
  %01111111
  %01011101
  %01011101
  %01010101
  %01001001
  %01011101
  %01111111
  %01011101
  %01011101
  %01000001
  %01011101
  %01011101
  %01100011
  %01111111
  %01000001
  %01110111
  %01110111
  %01110111
  %01000001
  %01111111
  %01000011
  %01011101
  %01011101
  %01011101
  %01000011
  %01111111
  %00011111
  %00111111
  %01111111
  %11111111
end

  player1:
  %01011100
  %01001000
  %11001000
  %01011100
  %00000000
  %11011100
  %00010100
  %00010100
  %00011100
  %00000000
  %00000000
  %10110110
  %00100101
  %10110101
  %00100101
  %10110110
  %00000000
  %00000000
  %11111111
  %00000000
  %00000000
  %10101110
  %11001000
  %11101100
  %10101000
  %11101110
  %00000000
  %00000000
  %11011011
  %10001001
  %11011011
  %10010010
  %11011011
  %00000000
  %00000000
  %11111111
  %11111110
  %11111100
  %11111000
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %10111110
  %10111110
  %10000110
  %10111010
  %10111010
  %10000110
  %11111110
  %11000110
  %10111010
  %10111010
  %10111010
  %11000110
  %11111110
  %10111010
  %10110110
  %10000110
  %10111010
  %10000110
  %11111110
  %10000110
  %10111010
  %10111010
  %10111010
  %10000110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111110
  %11111000
  %11111100
  %11111110
  %11111111
end

 sc1=High_Score01:sc2=High_Score02:sc3=High_Score03 

 goto titlescreen2

startgame
  player0:
  %00000000
end
  player1:
  %00000000
end
  COLUBK=0:COLUPF=0
  if !joy0fire then flag{0}=0:missile0height=1:missile1height=1:goto init
  drawscreen
  goto startgame

HighScoreCalc

   Save_Score01=sc1
   Save_Score02=sc2
   Save_Score03=sc3

   rem  Checks for a new high score.
   if sc1 > High_Score01 then goto New_High_Score
   if sc1 < High_Score01 then goto Skip_High_Score

   rem  First byte equal. Do the next test. 
   if sc2 > High_Score02 then goto New_High_Score
   if sc2 < High_Score02 then goto Skip_High_Score

   rem  Second byte equal. Do the next test. 
   if sc3 > High_Score03 then goto New_High_Score
   if sc3 < High_Score03 then goto Skip_High_Score

   rem  All bytes equal. Current score is the same as the high score.
   goto Skip_High_Score

New_High_Score

   rem  Save new high score.
   High_Score01 = sc1 : High_Score02 = sc2 : High_Score03 = sc3

Skip_High_Score

   return

   asm
minikernel
   sta WSYNC
   lda scback
   sta COLUBK
   rts
end

smallball
  player0:
  %00011000
  %00111100
  %01111110
  %01111110
  %00111100
  %00011000
end
  player1:
  %00011000
  %00111100
  %01111110
  %01111110
  %00111100
  %00011000
end
  goto largeball

