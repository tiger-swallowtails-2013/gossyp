var GossypApp = function() {
  $('#gossyps').on('submit', '.toggle_star', function(e) {
    // This is what's known as event delgation. If we simply bound the event
    // directly to toggle_star, if we replaced that element it would no longer
    // have the event bound to it!

    // Event delegation is when you bind the event to a containing element,
    // but only trigger the callback if the event was triggered on the
    // element which matches the 2nd arguments css selector

    // I read these like:

    // Within #gossyps, on submit of the .toggle_star element, do this callback

    e.preventDefault()
    // Stop the form from actually submitting

    var gossypId = getGossypIdFromDom($(this).closest('.gossyp'));
    GossypAPI.starGossyp(gossypId, function(response) {
      $('#gossyp_' + gossypId).replaceWith(response);
    });
  });

  function getGossypIdFromDom(gossypDom) {
    return gossypDom.attr('id').split('_')[1];
  }
}


// I'm choosing *not* to test the GossypAPI in Jasmine because I'm relying on the capybara
// tests to exercise the connection between the Server and my javascript
GossypAPI = {
  starGossyp: function(gossypId, callback) {
    $.post('/gossyps/' + gossypId + '/stars', callback);
  }
}
