#!/usr/bin/python
import re
import os
import sys

try:
    sys.argv[1]
    sys.argv[2]
except IndexError:
  print "usage: ./to_marlin_gcode origin.nc origin_marlin.gcode"
  exit()

# default values
G0Speed = "F7000"
G1Speed = "F3000"



with open(sys.argv[1], "r") as ins:

  f2 = open(sys.argv[2],'w')
  for line in ins:
    match1 = re.match(r"G1(F.*)",  line )
    match2 = re.match(r"G1([XYZ].*)(F.*)",  line )
    match3 = re.match(r"G0(F.*)",  line )
    match4 = re.match(r"G0([XYZ].*)(F.*)?",  line )
    match5  = re.match(r"([XYZ].*)(F.*)?",  line )

    if match1 :
      G1Speed = match1.group(1)
      currentCommand = "G1"
      l = currentCommand 

    elif match2 :
      if match2.group(2):
        G1Speed = match2.group(2)
      currentCommand = "G1"
      coord = match2.group(1)
      l = currentCommand + coord 

    elif match3 :
      if match3.group(2):
        G0Speed = match3.group(2)
      currentCommand = "G0"
      l = currentCommand 

    elif match4 :
      if match4.group(2):
        G0Speed = match4.group(2)
      currentCommand = "G0"
      coord = match4.group(1)
      l = currentCommand + coord 

    elif match5 :
      if match5.group(2):
        if currentCommand == "G0":
          G0Speed = match5.group(2)
        else:
          G1Speed = match5.group(2)

      coord = match5.group(1)
      l = currentCommand + coord  
    else:
      l = False



    if l:
      # set last speed 
      if currentCommand == "G0":
        speed = G0Speed
      else :
        speed = G1Speed
      f2.write( l.rstrip()+speed+"\n" )
    else:
      f2.write( line ) 

  f2.close()
  ins.close()
        

  exit()

