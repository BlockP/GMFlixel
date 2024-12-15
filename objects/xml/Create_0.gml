function curAttr(key){
	return is_undefined(ds_map_find_value(_curAttr,key))?"":ds_map_find_value(_curAttr,key);
}

function curType(){
	return _curType;
}

function ReadLine(){
	ds_map_clear(_curAttr);
	_current = "";
	_curType = "";
	if(file_text_eoln(_target)){
		return false;
	}
	else{
		var curTxt = file_text_readln(_target);
		_current = string_replace(curTxt,"\n","");
		
		var breaking = false;
		for(var i=0;i<string_length(_current)-1;i++){
			var c = string_char_at(_current,i);
			if(c=="<"){
				var type = ""
				for(var j = 1;j<string_length(_current)-i;j++){
					var ct = string_char_at(_current,j+i);
					if(((ct=="!")&&(string_char_at(_current,j+i+1)=="-")&&(string_char_at(_current,j+i+2)=="-"))||(ct=="?")){
						_curType = "";
						breaking = true;
						break;
					}
					else if(ct==" "){
						_curType = string_replace(type,"<","");
						_current = string_replace_all(string_delete(_current,1,i+j)," ","");
						breaking = true;
						break;
					}
					else{
						type = type + ct;
					}
				}
				if(breaking){
					break;
				}
			}
		}
		
		if(_curType!=""){
			var a = "";
			var v = "";
			for(var i=1;i<string_length(_current);i++){
				if(string_char_at(_current,i)=="="){
					var j = i;
					do{
						j--;
					}until((string_char_at(_current,j-1)=="\"")||(j<2));
					var a = "";
					for(;j<i;j++){
						a = a + string_char_at(_current,j);
					}
			
					var v = "";
					var j = i + 1;
					do{
						j++;
						v = v + string_char_at(_current,j)
					}until(string_char_at(_current,j+1)=="\"");
					ds_map_add(_curAttr,a,v);
				}
			}
		}
		return true;
	}
}