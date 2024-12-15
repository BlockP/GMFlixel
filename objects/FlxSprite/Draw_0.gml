if( ds_list_size(_anims) > 0 ){
	
	var _x = ( ( offset.x + animation.curAnim.frameX ) * scale.x ) + animation.curAnim.frameWidth;
	var _y = ( ( offset.y + animation.curAnim.frameY ) * scale.y ) + animation.curAnim.frameHeight;
	var _r = sqrt( sqr( _x ) + sqr( _y ) );
	var _t = darctan( _x / _y );
	var _fx = ( ( flipX == _flipX ) ? 1 : -1);
	var _fy = ( ( flipY == _flipY ) ? 1 : -1);
	
	try{
		draw_sprite_general(
		sprite_index,
		0,
		animation.curAnim.x,
		animation.curAnim.y,
		animation.curAnim.width,
		animation.curAnim.height,
		x - lengthdir_x(_r, angle - _t) * _fx,
		y - lengthdir_y(_r, angle - _t) * _fy,
		scale.x * _fx,
		scale.y * _fy,
		angle,
		color,
		color,
		color,
		color,
		alpha)
	}
	catch(error){
		show_debug_message("WARNING: Playing a non-exist animation");
	}
}else{
	if(sprite_exists(sprite_index)) draw_sprite_ext( sprite_index, 0, x - offset.x * scale.x, y - offset.y * scale.y, scale.x, scale.y, angle, color, alpha )
}