steel shapeoko2
===============

Big Shapeoko made by steel tubes and OpenRail.

In my country isn't easy to find amateur materials like openslide or other aluminium railed frames. If you buy something like shapeoko or makerslide to the USA, you have to pay a lot of custom clearance costs.

I've tied made an opensource big CNC (Soft materials), ussing the existing open projects as Shapeoko and RepRap.


# Mecanical hardware #
* Dimensions: 1000mm x 3000mm (Obviously, customizable)
* Frame and desk structure: steel tube 40x40mm
* Rail: OpenRail ( https://www.kickstarter.com/projects/openrail/openrail-open-source-linear-bearing-system/posts/261027 )
* Shapeoko2 Plates: Modified and cutted by laser in 6mm steel

# Electronic hardware #
* Sanguino ATMEGA W/ 1284p 16mhZ , Arduino as ISP
* Drivers: Wantai  DQ542MA drivers
* Steper Motor: Nema 23 
* Sanguinololu (Reprap project)
* Interface beetwen Sanguinololu and Wantai drivers: DIY board.
* Autonomous control panel: Sanguinololu panel G3D_PANEL, with screen, control and SD support.

# Firmware #
* Marlin (Reprap): modified to avoid all temperature references, turning it in a CNC firmware instead 3D printer one.



# CONNECTION DETAILS #

Wantai DQ542MA and Marlin connections. It works to beetwen arduino and any other drivers.

![](https://raw.githubusercontent.com/pablinhob/steel_shapeoko2/master/resources/wantai_sanguinololu.png)


# ABOUT GCODE #
Marlin firmware can`t read standard GCODE .nc files made by, for example meshcam. Use this python script to convert standard G-CODE to reprap favoured GCODE. https://gist.github.com/pablinhob/5b4a28e6b459bf64f90c#file-to_marlin_gcode-py
