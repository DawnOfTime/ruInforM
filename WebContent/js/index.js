window.onload=function(){
    var left=getClass("left")[0];
    var right=getClass("right")[0];
    var imgbox=getClass("imgbox");
    var dj=getClass("dj");

    var num=0;
    for (var i = 0; i < imgbox.length; i++) {
        imgbox[i].style.opacity="0";
        dj[i].style.background="gray";

    };
    imgbox[0].style.opacity="1";
    dj[0].style.background="yellow";
    //right    2
    function qh(){
        num++;
        if (num>4) {
            num=0;
        };
        for (var i = 0; i <imgbox.length; i++) {
            imgbox[i].style.opacity="0"
            dj[i].style.background="gray";
            
        }
        imgbox[num].style.opacity="1"
        dj[num].style.background="yellow";
    }
    var t=setInterval(qh,5000)
    var box=getClass("box")[0];
   
    box.onmouseover=function(){
        clearInterval(t)
    }
    box.onmouseout=function(){
        t=setInterval(qh,5000)
    }
    right.onclick=function(){
        for (var i = 0; i < imgbox.length; i++) {
            imgbox[i].style.opacity="0";
            dj[i].style.background="gray";

        };
        num++;
        if(num>4){
           num=0;
        }
     imgbox[num].style.opacity="1";
     dj[num].style.background="yellow";
    }
    // alert(dj)
   // setTimeout(function(){alert(num)},2000)
    left.onclick=function(){
        for (var i = 0; i < imgbox.length; i++) {
            imgbox[i].style.opacity="0"
        };
        num--;
        if(num<0){
            num=4;
        }
        imgbox[num].style.opacity="1";
    }
    for (var i = 0; i <dj.length; i++) {
        dj[i].wangdi=i
        dj[i].onmouseover=function(){
            for (var i = 0; i <imgbox.length; i++) {
                imgbox[i].style.opacity="0"
                dj[i].style.background="gray"
            }
            num=this.wangdi;
            imgbox[num].style.opacity="1";
            dj[num].style.background="yellow";
        }
    };

}
