$(document).ready(function(){
  $(document)
    .ajaxStart(function(){
      $('#global-spin').fadeIn('slow')
    })
    
    .ajaxStop(function(){
      $('#global-spin').fadeOut('slow')
    })
})