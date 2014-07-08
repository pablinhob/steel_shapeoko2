steel shapeoko2
===============

Big Shapeoko made by steel tubes and OpenRail.

In my country isn't easy to amateur materials like openslide or other aluminium railed frames. If you buy something like shapeoko or makerslide to the USA, you have to pay a lot of custom clearance costs.

I've tied made an opensource big CNC (Soft materials), ussing the existing open projects as Shapeoko and RepRap.


# Mecanical hardware #
* Dimensions: 1000mm x 3000mm (Obviously, customizable)
* Frame and desk structure: steel tube 40x40mm
* Rail: OpenRail ( https://www.kickstarter.com/projects/openrail/openrail-open-source-linear-bearing-system/posts/261027 )
* Shapeoko2 Plates: Modified and cutted by laser in 6mm steel

# Electronic hardware #
* Drivers: Wantai  DQ542MA drivers
* Steper Motor: Nema 23 
* Sanguinololu (Reprap project)
* Interface beetwen Sanguinololu and Wantai drivers: DIY board.
* Autonomous control panel: Sanguinololu panel G3D_PANEL, with screen, control and SD support.

# Firmware #
* Marlin (Reprap): modified to avoid all temperature references, turning it in a CNC firmware instead 3D printer one.
