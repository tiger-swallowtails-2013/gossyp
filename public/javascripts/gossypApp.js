var GossypApp = function() {
  $('.toggle_star').on('submit', function(e) {
    // Stop the form from actually submitting
    e.preventDefault()

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
