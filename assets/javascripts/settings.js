
jQuery(document).ready(function(){

	jQuery.each(jQuery('.selectors'), function(i,v){
		var el         = jQuery(this);
		
		var ID         = el.attr('id').split('_');
		var optionCode = ID[1];
		var key        = ID[2];

		var setValue = el.val();
		var targetPickerEl = jQuery('#' + optionCode + '_' + key);

		if (setValue) {
			var targetEl = jQuery('#target_' + key);

			if (optionCode == 'color') {
				targetEl.css({'color': setValue + ' !important'});
				targetPickerEl.css({'background-color': setValue + ' !important'});

				targetPickerEl.colpick({
					colorScheme:'dark',
					layout:'rgbhex',
					color:setValue,
					onSubmit:function(hsb,hex,rgb,el) {
						updateColorpickerTarget(el, '#'+hex);
					}
				});
			
			} else if (optionCode == 'background-color') {
				targetEl.css({'background-color': setValue + ' !important'});
				targetPickerEl.css({'background-color': setValue + ' !important'});

				targetPickerEl.colpick({
					colorScheme:'dark',
					layout:'rgbhex',
					color:setValue,
					onSubmit:function(hsb,hex,rgb,el) {
						updateColorpickerTarget(el, '#'+hex);
					}
				});
			
			} else if (optionCode == 'background-image') {
				targetEl.css({'background-image': 'url(' + setValue + ') !important', 'background-size': '16px 16px !important', 'background-repeat': 'no-repeat !important', 'text-indent': '20px !important'});
				console.log(setValue);
				targetPickerEl.text('edit');
			}

		} else {
			if (optionCode == 'color') {
				targetPickerEl.colpick({
					colorScheme:'dark',
					layout:'rgbhex',
					color:'#000000',
					onSubmit:function(hsb,hex,rgb,el) {
						updateColorpickerTarget(el, '#'+hex);
					}
				});

			} else if (optionCode == 'background-color') {
				targetPickerEl.colpick({
					colorScheme:'dark',
					layout:'rgbhex',
					color:'#ffffff',
					onSubmit:function(hsb,hex,rgb,el) {
						updateColorpickerTarget(el, '#'+hex);
					}
				});

			} else if (optionCode == 'background-image') {
				targetPickerEl.text('set');
			}
		}
	});

	jQuery('.reset').click(function(){
		var key = jQuery(this).attr('id').split('_')[1];
		jQuery('#target_' + key).css({'background': 'inherit !important', 'color': 'inherit !important'});

		jQuery('#color_' + key).css({'background': '#FFFFFF !important'});
		jQuery('#select_color_' + key).val("");

		jQuery('#background-color_' + key).css({'background': '#FFFFFF !important'});
		jQuery('#select_background-color_' + key).val("");
	});
})

function updateColorpickerTarget(element, color)
{
	var el = jQuery(element);
	el.css('background-color', color);
	el.colpickHide();

	var ID = el.attr('id');
	var optionCode = ID.split('_')[0];
	var key = ID.split('_')[1];

	jQuery('#select_'+ID).val(color);
	jQuery('#target_'+key).css(optionCode, color + " !important");

	console.log('#target_'+key, optionCode, color);
}