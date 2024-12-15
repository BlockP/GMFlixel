if(ds_list_size(_anims)>0){
	animation.curAnim = ds_list_find_value(ds_list_find_value(_anims,ds_list_find_index(_prefix,animation.frameName))._container,floor(animation.frameIndex));
	if(_rev){
		if(floor(animation.frameIndex) > 1){
			animation.frameIndex -= (animation.frameRate / game_get_speed(gamespeed_fps));
		}
		else{
			if(_loop) animation.frameIndex = animation.numFrames - 1;
			if(_fNameNext!=undefined){
				animation.numFrames = ds_list_size(ds_list_find_value(_anims,ds_list_find_index(_prefix,_fNameNext))._container)
				frameIndex = _fIndexNext;
				animation.frameName = _fNameNext;
				animation.frameRate = _fRateNext;
				_flipX = _flipXNext;
				_flipY = _flipYNext;
				_rev = _revNext;
				_loop = _loopNext;
			}
		}
	}
	else{
		if(floor(animation.frameIndex) < (animation.numFrames - 1)){
			animation.frameIndex += (animation.frameRate / game_get_speed(gamespeed_fps));
		}
		else{
			if(_loop) animation.frameIndex = 0;
			if(_fNameNext!=undefined){
				animation.numFrames = ds_list_size(ds_list_find_value(_anims,ds_list_find_index(_prefix,_fNameNext))._container)
				frameIndex = _fIndexNext;
				animation.frameName = _fNameNext;
				animation.frameRate = _fRateNext;
				_flipX = _flipXNext;
				_flipY = _flipYNext;
				_rev = _revNext;
				_loop = _loopNext;
			}
		}
	}
}