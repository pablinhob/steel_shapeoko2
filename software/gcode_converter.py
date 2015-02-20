#!/usr/bin/python

##Copyright (c) 2012, River Allen
##All rights reserved.
##
##Redistribution and use in source and binary forms, with or without modification,
##are permitted provided that the following conditions are met:
##* Redistributions of source code must retain the above copyright notice, this list
##  of conditions and the following disclaimer.
##* Redistributions in binary form must reproduce the above copyright notice,
##  this list of conditions and the following disclaimer in the documentation and/or
##  other materials provided with the distribution.
##
##THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
##EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
##OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
##SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
##INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
##TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
##BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
##CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
##ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
##DAMAGE.

from datetime import datetime
import os
import sys
import shutil

class GCodeConverter:
    def __init__(self):
        self.invalid_commands = [
            'M2',
            'M5',
            'M6',
            'M3',
            'T1',
            'S1', # Surface command does not work (this is a hack)
            ] 
    
    def convert(self, filename):
        pass
    
    
class PyCamGCodeConverter(GCodeConverter):
    def __init__(self):
        GCodeConverter.__init__(self)

    def convert(self, filename, final_pos=None):
        # Add and remove g-code commands to make a pycam g-code
        # file more mendel compatible. Ouput to <filename_converted.ext>.
        # When cutting is complete, move to final pos (x, y, z).
        final_pos = final_pos or (0., 0., 18.)
        write_fname = '%s_converted%s' % os.path.splitext(filename)
        with open(filename, 'rb') as rf:
            with open(write_fname, 'wb') as wf:
                # Add some metadata to the file (not really used at this point)
                wf.write('; CONVERTED FOR MENDEL: %s\n' % str(datetime.now()))
                # Let's start by homing the mendel.
                wf.write('G28 ; HOME\n')
                # Copy the contents of the original gcode file devoid
                # of the pycam gcode commands that do not work on the 
                # mendel gcode firmware.
                for l in rf.readlines():
                    if self.check_valid_commands(l):
                        wf.write(l)
                # Some finish up commands to make it easier to remove the
                # completed part.
                wf.write("; FINISH THE CUT BY MOVING BIT TO SAFER POSITION\n")
                wf.write("G1 Z%f ; MOVE BIT ABOVE PIECE\n" % final_pos[2])
                wf.write("G1 X%f Y%f ; HOME X AND Y\n" % final_pos[:2])
        
        return write_fname

    def check_valid_commands(self, line):
        for cmd in self.invalid_commands:
            if cmd in line:
                return False
        return True        


class MarlinGCodeConverter(PyCamGCodeConverter):
    def __init__(self):
        PyCamGCodeConverter.__init__(self)
    
    def convert(self, filename, final_pos=None):
        # All of this code is written to compensate for the fact Marlin is 
        # less robust with the format of g-code. Specifically, on the old mendel
        # the following commands:
        # ~ G1 X30
        # ~  Y30 
        # ~  X50
        # would work. These commands do not work on Marlin. Hence, this code
        # converts the above commands to:
        # ~ G1 X30
        # ~ G1 Y30
        # ~ G1 X50
        
        # Convert pycam gcode for mendel
        convert_fname = PyCamGCodeConverter.convert(self, filename, final_pos)
        # Store this new conversion in a temp file
        temp_fname = '.temp_convert'
        
        with open(convert_fname, 'rb') as f_pycc:
            with open(temp_fname, 'wb') as f_temp:
                move_type = None
                for l in f_pycc.readlines():
                    first_chars = l[:2].upper()
                    if first_chars == 'G1':
                        move_type = 'G1'
                    elif first_chars == 'G0':
                        move_type = 'G0'
                    elif first_chars == ' X' or first_chars == ' Y' or first_chars == ' Z':
                       # Change ' X100' to 'G0 X100'
                       l = "%s%s" % (move_type, l) 

                    f_temp.write(l)
        # Copy the temp file conversion over to the pycam conversion
        # for cleanliness
        shutil.copy(temp_fname, convert_fname)
        # Get rid of temp file
        os.remove(temp_fname)
        return convert_fname


if __name__ == '__main__':
    # Simple command line script. Can be used, but mostly added for testing.
    if len(sys.argv) < 2:
        print 'cnc_mendel <filename1> [filename2 ... n]'
    gc_converter = MarlinGCodeConverter()
    fnames = sys.argv[1:]
    for fname in fnames:
        gc_converter.convert(fname)

