var aceAutocomplete = new Object();

$.widget("custom.catcomplete", $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var that = this,
			currentCategory = "";
		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append("<li class='ui-autocomplete-category'>" + item.category + "</li>");
				currentCategory = item.category;
			}
			that._renderItemData(ul, item);
		});
	}
});

/**
 * 自动补全
 * @param {} inputId
 * @param {} Url
 */
aceAutocomplete.Autocomplete = function(inputId, Url) {
	$.ajax({
		url: Url,
		cache: false,
		async: false,
		dataType: "json",
		type: 'post',
		success: function(response) {
			var massage = response.msg.replace(/LABEL/g, "label").replace(/CATEGORY/g, "category");
			var res = dealSpecialCharactor(massage);
			var resultmsgobj = convertJson.string2json1(res);
			var data = resultmsgobj.response.data;

			$("#" + inputId).catcomplete({
				delay: 0,
				source: data
			});
		}
	});
}

//转换字符串中的特殊字符
function dealSpecialCharactor(v) {
	v = v.replace(/\\[b]/g, " ");
	v = v.replace(new RegExp("&gt;", "g"), ">");
	v = v.replace(new RegExp("&lt;", "g"), "<");
	return v;
}