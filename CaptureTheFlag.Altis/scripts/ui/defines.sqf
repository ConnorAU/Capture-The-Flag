/*-------------------------------------------------------
|														|
| ~ Heads Up Icons	 									|
|														|
-------------------------------------------------------*/
#define HUI_DRAWICON_CODE {\
	params ["_f","_p","_t","_o"];\
	drawIcon3D [\
		_f,[1,1,1,((((player distance _o)-5)/10)min 0.5)max 0],\
		_p,1.25,0.75,0, \
		_t,2,0.034,"PuristaMedium","center",\
		true\
	];\
}
#define HUI_DRAWICON_PARAMS1(IMG,TXT) [\
	IMG,\
	_obj modelToWorldVisual [0,-0.5,boundingBoxReal _obj select 1 select 2],\
	TXT,\
	_obj\
]
#define HUI_DRAWICON_PARAMS2(IMG,TXT) [\
	IMG,\
	_obj modelToWorldVisual (_obj selectionPosition "head") vectorAdd [0,0,0.5],\
	TXT,\
	_obj\
]