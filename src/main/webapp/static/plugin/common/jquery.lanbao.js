(function($){
	$.fn.hilight = function(options){
		var defaults ={
				foreground:'red',
				background:'yellow'
		};
		var opts = $.extend(defaults,options);
		$(this).css("color",opts.foreground);
		$(this).css("background-color",opts.background);
	};
})(jQuery);