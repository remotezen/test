jQuery(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip({'placement': 'top'});
  $('[data-toggle="popover"]').popover({trigger: 'hover','placement': 'top'});
  $(function(){
    $('a.comment-form').pjax('#main') // pjax call
    })

});
$(document).ready(function(){
  var limitnum = 140; // set your int limit for max number of characters
  
  function limiting(obj, limit) {
    var cnt = $("#counter > span");
    var txt = $(obj).val(); 
    var len = txt.length;
    
    // check if the current length is over the limit
    if(len > limit){
       $(obj).val(txt.substr(0,limit));
       $(cnt).html(len-1);
     } 
     else { 
       $(cnt).html(len);
     }
     
     // check if user has less than 20 chars left
     if(limit-len <= 20) {
     	$(cnt).addClass("warning");
     }
     else if (limit-len <= 0){ 
      alert( "sorry you have  have exceed the limit of  140 character");
     }
  }


  $('textarea').keyup(function(){
    limiting($(this), limitnum);
  });
});


$(document).ready(function() {

	/* This is basic - uses default settings */
	
	$(".fancybox").fancybox()

	
});

$(document).ready(function(){
           $('li img').on('click',function(){
                var src = $(this).attr('src');
                var img = '<img src="' + src + '" class="img-responsive"/>';
                $('#myModal').modal();
                $('#myModal').on('shown.bs.modal', function(){
                    $('#myModal .modal-body').html(img);
                });
                $('#myModal').on('hidden.bs.modal', function(){
                    $('#myModal .modal-body').html('');
                });
           });  
        })
