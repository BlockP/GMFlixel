// flixel
scale = { x: 1 , y: 1 , set: function(_x,_y){ x= _x; y= _y }};
alpha = 1;
angle = 0;
color = c_white;
offset = { x: 0 , y: 0 , set: function(_x,_y){ x= _x; y= _y }};
flipX = false;
flipY = false;

function loadGraphic(graphic,animated=false,frameWidth=0,frameHeight=0/*, unique = false, key=""*/){
	
	// built-in
	_anims = ds_list_create(); // anim list
	_prefix = ds_list_create(); // name list (prefix)
	_rev = false;
	_flipX = false;
	_flipY = false;
	_loop = false;

	_fIndexNext = 0;
	_fNameNext = "";
	_fRateNext = 0;
	_revNext = false;
	_flipXNext = false;
	_flipYNext = false;
	_loopNext = false;
	
	animation = new FlxAnimationController(id);
	
	sprite_index = sprite_add(graphic,1,false,true,0,0);
	if(animated){
		// get file name (no suffix)
		for(var i = string_length(graphic);i>0;i--){
			if(string_char_at(graphic,i)="."){
				break;
			}
		}
		
		var reader = xmlFile(string_delete(graphic,i,string_length(graphic)-i+1)+".xml");
		var _subtextures = ds_list_create();
		while(reader.ReadLine()){
			if(reader.curType()=="SubTexture"){
				var curSubT = {
					name:        reader.curAttr("name"),
					x:           real(reader.curAttr("x")),
					y:           real(reader.curAttr("y")),
					width:       real(reader.curAttr("width")),
					height:      real(reader.curAttr("height")),
					frameX:      (reader.curAttr("frameX") == "") ? 0 : real(reader.curAttr("frameX")),
					frameY:      (reader.curAttr("frameY") == "") ? 0 : real(reader.curAttr("frameY")),
					frameWidth:  (reader.curAttr("frameWidth") == "") ? 0 : real(reader.curAttr("frameWidth")),
					frameHeight: (reader.curAttr("frameHeight") == "") ? 0 : real(reader.curAttr("frameHeight"))	
					};
				ds_list_add(_subtextures,curSubT);
			}
		}
		
		// name without index
		var _formattedST = ds_list_create();
		for(var i = 0;i<ds_list_size(_subtextures);i++){
			var _formattedName = ds_list_find_value(_subtextures,i).name;
			_formattedName = string_delete(_formattedName,string_length(_formattedName)-3,4);
			ds_list_add(_formattedST,_formattedName);
		}
		
		var _nameState = ds_list_create(); // check repeated name in formatted name list
		var _nameLast = "";
		for(var i = 0;i<ds_list_size(_formattedST);i++){
			var _nameCur = ds_list_find_value(_formattedST,i);
			ds_list_add(_nameState,_nameCur!=_nameLast);
			if(_nameCur!=_nameLast){
				ds_list_add(_prefix,_nameCur);
			}
			_nameLast = _nameCur;
		}
		
		var _class = ds_list_create(); // for FlxAnimation._container
		for(var i = 0;i<ds_list_size(_nameState);i++){
			if(ds_list_find_value(_nameState,i)){
				ds_list_add(_class,ds_list_create());
			}
			ds_list_add(ds_list_find_value(_class,ds_list_size(_class)-1),ds_list_find_value(_subtextures,i))
		}
		
		for(var i = 0;i<ds_list_size(_class);i++){
			var animInfo = {
				_container : ds_list_find_value(_class,i),
				name       : ds_list_find_value(_prefix,i)
			};
			ds_list_add(_anims,animInfo);
		}
		
		animation.curAnim = ds_list_find_value(ds_list_find_value(_anims,0)._container,0);
		
		// garbage collection
		ds_list_destroy(_subtextures);
		ds_list_destroy(_formattedST);
		ds_list_destroy(_nameState);
		ds_list_destroy(_class);
		delete(_subtextures);
		delete(_formattedST);
		delete(_nameState);
		delete(_class);
		
		delete(_nameLast);
		delete(_nameCur);
		instance_destroy(reader);
	}
}

/**
	* Helper function that adjusts the offset automatically to center the bounding box within the graphic.
	*
	* @param   AdjustPosition   Adjusts the actual X and Y position just once to match the offset change.
	*/
function centerOffsets(AdjustPosition = false)
{
	if(is_struct(animation.curAnim)){
		offset.x = (animation.curAnim.frameWidth - animation.curAnim.width) / 2;
		offset.y = (animation.curAnim.frameHeight - animation.curAnim.height) / 2;
	}
	if (AdjustPosition)
	{
		x += offset.x;
		y += offset.y;
	}
}