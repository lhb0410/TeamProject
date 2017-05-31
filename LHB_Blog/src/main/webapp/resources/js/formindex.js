function field_focus(field, id)
  {
    if(field.value == id)
    {
      field.value = '';
    }
  }

  function field_blur(field, pwd)
  {
    if(field.value == '')
    {
      field.value = pwd;
    }
  }

//Fade in dashboard box
$(document).ready(function(){
    $('.box').hide().fadeIn(1000);
    });

//Stop click event
$('a').click(function(event){
    event.preventDefault(); 
	});