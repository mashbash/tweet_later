$(document).ready(function(){
  console.log("I'm  here")
  $('form').submit(function(e){
    console.log("I'm in submit!")
    e.preventDefault();
    var $form = $(this);
    var tweet_text = $form.find('textarea[name="tweet"]').val();
    $('textarea').attr('disabled', 'disabled');
    $('#submit').attr('disabled', 'disabled');
    $('#pacman').show();
    $.ajax({
      type: this.method,
      url: this.action,
      data: {tweet: tweet_text}
      }).done(function(serverResponse){
        debugger
        console.log("I'm in first success!");
        $('textarea').removeAttr('disabled');
        $('#submit').removeAttr('disabled');
        $('#pacman').hide();
        $('textarea').val('');
        $('.message').html(serverResponse);
        checkStatus(serverResponse.job_id);
   });    
  });
}); 

  var checkStatus = function(jobID) {
    $.ajax({
      type: "get",
      url: "/status/"+jobID,
      data: {job_id: jobID}
      }).done(function(serverResponse){
      console.log("I'm in the second success!");  
      if (serverResponse == false) {
        $('.message').html("Tweet successfully posted!");
      }
      else {
        setTimeout(checkStatus(jobID),10000); 
      }
    });   
  }  
