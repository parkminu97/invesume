$(function(){
	// Side Menu size;
	var centerSize = $("#wrap_center").height()+70;
	$("#wrap_lnb").css("height",centerSize);
	
	// Side Menu
	var menu_v = $('ul.lnb');
	var sItem = menu_v.find('>li');
	var ssItem = menu_v.find('>li>ul>li');
	var lastEvent = null;//값이 없다
	
	//sItem.find('>ul').css('display','none'); 
    menu_v.find('ul>li[class=active]').parents('li').attr('class','active'); 
    menu_v.find('li[class=active]').find('>ul').css('display','block'); 

	function menu_vToggle(event){
		var t = $(this); //클릭된 depth1
	
		if (this == lastEvent) return false; //클릭된게 없으면 return false
		/*
		if (t.next('ul').is(':hidden')) {//클릭된 depth1에 depth2가 display:none 일 경우
			sItem.find('>ul').slideUp(100);
			t.next('ul').slideDown(100); 
		} else if(!t.next('ul').length) {//클릭된 depth1에 depth2 없을 경우
			sItem.find('>ul').slideUp(100);
		} else {						//클릭된 depth1에 depth2 이미 열려있음
			t.next('ul').slideUp(100);
		}
		*/
		if (t.parent('li').hasClass('active')){
			t.parent('li').removeClass('active');
		} else {
			sItem.removeClass('active');
			t.parent('li').addClass('active');
			//ssItem.removeClass('active');
			//t.next('ul').find('li').first().addClass('active'); 
		}
	}
	//sItem.find('>a').click(menu_vToggle);
	
	function subMenuActive(){
		ssItem.removeClass('active');
		$(this).addClass('active');
		$(this).parent(ssItem).addClass('active');
	}; 
	ssItem.find('>a').click(subMenuActive);

});