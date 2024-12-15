function FlxAnimationController(Sprite)constructor{
	
	/**
	 * Property access for currently playing animation (warning: can be `null`).
	 */
	curAnim = undefined;
	
	/**
	 * The frame index of the current animation. Can be changed manually.
	 */
	frameIndex = -1;
	
	/**
	 * Tell the sprite to change to a frame with specific name.
	 * Useful for sprites with loaded TexturePacker atlas.
	 */
	frameName = "";
	
	/**
	 * Gets or sets the currently playing animation (warning: can be `null`).
	 */
	name = undefined;
	
	/**
	 * Pause or resume the current animation.
	 */
	paused = false;
	
	/**
	 * Whether the current animation has finished playing.
	 */
	finished = false;
	
	/**
	 * The total number of frames in this image.
	 * WARNING: assumes each row in the sprite sheet is full!
	 */
	numFrames = 0;
	
	curFrame = 0;
	
	/**
	 * Internal, reference to owner sprite.
	 */
	_sprite = Sprite;
	
	/**
	 * Internal, stores all the animation that were added to this sprite.
	 */
	_animations = ds_map_create();
	
	/**
	 * Adds a new animation to the sprite.
	 *
	 * @param   Name        What this animation should be called (e.g. `"run"`).
	 * @param   Prefix      Common beginning of image names in atlas (e.g. `"tiles-"`).
	 * @param   FrameRate   The speed in frames per second that the animation should play at (e.g. `40` fps).
	 * @param   Looped      Whether or not the animation is looped or just plays once.
	 * @param   FlipX       Whether the frames should be flipped horizontally.
	 * @param   FlipY       Whether the frames should be flipped vertically.
	 */
	function addByPrefix(Name, Prefix, FrameRate = 30, Looped = true, FlipX = false, FlipY = false){
		var ref = {
			prefix : string_replace(Prefix," ",""),
			frameRate : FrameRate,
			loop : Looped,
			flipX : FlipX,
			flipY : FlipY
		};
		ds_map_add(_animations,Name,ref);
	}
	
	function play(AnimName, Force = false, Reversed = false, Frame = 0){
		var ref = ds_map_find_value(_animations,AnimName);
		if(Force){
			numFrames = ds_list_size(ds_list_find_value(_sprite._anims,ds_list_find_index(_sprite._prefix,ref.prefix))._container);
			if(Frame==0){
				frameIndex = Reversed? (numFrames - 1) : 0;
			}
			else{
				frameIndex = ((Frame == -1)? irandom_range(0 , (numFrames - 1)) : Frame)
			}
			frameName = ref.prefix;
			frameRate = ref.frameRate;
			_sprite._flipX = ref.flipX;
			_sprite._flipY = ref.flipY;
			_sprite._rev = Reversed;
			_sprite._loop = ref.loop;
			
			_sprite._fIndexNext = 0;
			_sprite._fNameNext = undefined;
			_sprite._fRateNext = 0;
			_sprite._flipXNext = false;
			_sprite._flipYNext = false;
			_sprite._revNext = false;
			_sprite._loopNext = false;
		}
		else{
			var numF = ds_list_size(ds_list_find_value(_sprite._anims,ds_list_find_index(_sprite._prefix,ref.prefix))._container);
			show_debug_message(ref.prefix)
			if(Frame==0){
				_sprite._fIndexNext = Reversed? (numF - 1) : 0;
			}
			else{
				_sprite._fIndexNext = ((Frame == -1)? irandom_range(0 , (numF - 1)) : Frame)
			}
			_sprite._fNameNext = ref.prefix;
			_sprite._fRateNext = ref.frameRate;
			_sprite._flipXNext = ref.flipX;
			_sprite._flipYNext = ref.flipY;
			_sprite._revNext = Reversed;
			_sprite._loopNext = ref.loop;
		}
	}
}