$(function() {
  $('#back a').on('click',function(event){
    $('main,html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});