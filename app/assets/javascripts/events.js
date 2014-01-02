function updateWordsCounter(id, maxLength, counter){
  var text = $(id).val();
  var count = maxLength - text.length;
  $(counter).text(count);
  return;
}

function pagination(id){
  $("li.pages").removeClass("active");
  $("a#" + id).parent().addClass("active");
    
  page = "#block" + id;
  //$(".block").fadeOut("fast");
  //$(page).fadeIn("slow");
  $(".block").css('display', 'none');
  $(page).css('display', 'block');
  return;
}
