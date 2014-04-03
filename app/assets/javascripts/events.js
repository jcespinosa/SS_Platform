function updateWordsCounter(id, maxLength, counter){
  var text = $(id).val();
  var count = maxLength - text.length;
  $(counter).text(count);
  return;
}

function pagination(id){
  $('li.pages').removeClass('active');
  $('a#' + id).parent().addClass('active');
    
  page = '#block' + id;
  //$('.block').fadeOut('fast');
  //$(page).fadeIn('slow');
  $('.block').css('display', 'none');
  $(page).css('display', 'block');
  return;
}

function pagination2(id){
  $('li.pages').removeClass('active');
  $('li.page' + id).addClass('active');
  
  page = '#block' + id;
  $('.block').fadeOut('fast');
  $(page).fadeIn('slow');
  return;
}

function loadCase(id){
  var content = './cases/' + id + '.html';
    
  $('li.case').removeClass('active');
  $('a#' + id).parent().addClass('active');
    
  $('#userCaseContainer').fadeOut('fast', function(){
    $(this).load(content, function(response, status, xhr){
      if(status == 'error'){
        return;
      } else {
        $(this).fadeIn('fast');
      }
    });
  });
    
  return;
}

function ajaxSubmit(type){
  /*var RESPONSE = 'http://elisa.dyndns-web.com/cgi-bin/ss/response.py';*/
  var RESPONSE = 'http://10.166.226.149/cgi-bin/ss/response.py';

  try {
    var form = {
      'nombre': $('input#name').val(),
      'lugar': $('input#workplace').val(),
      'ocupacion': $('input#job').val(),
      'correo': $('input#email').val(),
      'casos': [],
      'caso': $('textarea#userCase').val(),
      'intereses': [],
      'comentarios': $('textarea#comments').val()
    };

    $('form :input[name="intereses"]:checked').each(function(){
      form['intereses'].push($(this).val());
    });

    $('form :input[name="casos"]:checked').each(function(){
      form['casos'].push($(this).val());
    });

    $.ajax({
      url: RESPONSE,
      type: 'post',
      async: false,
      data: form,
      dataType: 'application/json',
      traditional: true,
      success: function(response){
        console.log(response);
        $('#sending').fadeOut(function(){
          $('#sucess').fadeIn();
        });
      },
      error: function(response){
        console.log(response);
        $('#sending').fadeOut(function(){
          $('#error').fadeIn();
        });
      }
    });

    console.log(form);

    return;
  } catch(e) {
    console.log(e);
  }
}
