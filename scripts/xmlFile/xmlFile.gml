function xmlFile(path){
	var reader = instance_create_depth(0,0,0,xml);
	with(reader){
		_target = file_text_open_read(path);
		_curAttr = ds_map_create();
	}
	return reader;
}