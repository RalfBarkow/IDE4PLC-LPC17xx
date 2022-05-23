"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ProIcon is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ProIcon',
	#superclass : #'PLC_DesktopIcon',
	#category : #'IDE4PLC-GUI'
}

{ #category : #'as yet unclassified' }
PLC_ProIcon >> leftClick: anEvent [
	"Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
		
	| editorConfigHard |
		
	editorConfigHard := PLC_ImageOpenSuicide new.
	editorConfigHard imagePath: 'IDE4PLC_files/GUI_Images/dummy/configHW.png'.
	editorConfigHard mouseOut.
	editorConfigHard position: 10@10.
]
