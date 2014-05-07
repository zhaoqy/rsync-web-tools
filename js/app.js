var RSYNC_MSG = {
	syncing : "同步中....",
	none : ""
};
$(document).ready(function(){
    $('textarea').autosize();   
	$('#sync_submit').on('click', function(){
		var self = $(this);
		self.attr('disabled',"true");
		$('#msg').html(RSYNC_MSG.syncing);   
		$.ajax({
			url : "services/rsync.php",
			type : 'POST',
			cache : false,
			data : {
				// envpath : $("#envpath").val(),
				srcpath : $("#srcpath").val(),
				destpath : $("#destpath").val()
			},
			success : function(data, textStatus){
				$('#output').val(data).show().trigger('autosize.resize');
				self.removeAttr("disabled"); 
				setTimeout(function(){
					$('#msg').html(RSYNC_MSG.none);  
				},3000);		
			}
		});
	});
});