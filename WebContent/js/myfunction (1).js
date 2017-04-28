function getClass(className){
	if(document.getElementsByClassName){
		return document.getElementsByClassName(className);
	}else{
		var tags=document.getElementsByTagName('*');
		var arr=[];
		for (var i = 0; i < tags.length; i++) {
			if(tags[i].className===className){
               arr.push(tags[i])
			}
		};
		return arr;
	}
}