// I like to use context for input permutations and describe for methods and
// object names. It's not built into jasmine, so I'm just aliasing describe to
// context.

var context = describe;

describe('Gossyper Stars Gossyp', function () {
  beforeEach(function() {
    // affix is provided by jasmine-fixture, and makes it *super easy* to
    // insert temporary elements into the DOM

    var body = affix('#gossyps');
    body.affix('#gossyp_1.gossyp form.toggle_star');
    body.affix('#gossyp_2.gossyp form.toggle_star');



    var counter = 1;
    // Because I don't want to actually hit the server from my tests, I'm
    // spying on GossypAPI's starGossyp function.
    spyOn(GossypAPI, 'starGossyp').andCallFake(function(gossypId, callback) {
      // Because starring the gossyp will need to be asynchronous, I have to do
      // a bit more work.


      var fakeServerResponse = "<div id='gossyp_" + gossypId + "' class='gossyp'>" + counter++ +" attempt to " +
                 "star gossyp " + gossypId + "<form class='toggle_star'></form></div>"
      // Here I'm setting up a fake version of a string I may get back from the server.

      callback(fakeServerResponse);
      // Here I'm calling the callback that is passed in. This allows me to
      // simulate asynchronous code without actually writing asynchronous code.

      // I'm explicitely choosing not to test something complex (the server
      // interaction) so that I can test something that is important (replacing
      // the DOM with the servers response)
    })

    new GossypApp();
  });
  context("When the toggle_star form is submitted", function() {
    beforeEach(function() {
      $('#gossyp_1 .toggle_star').submit();
    });

    it("replaces the correct gossyp with the response from the server", function() {
      expect($('#gossyp_1').text()).toContain('attempt to star gossyp 1');
    });

    it("does not replace other gossyp with the servers response", function() {
      expect($('#gossyp_2').text()).not.toContain('attempt at starring gossyp');
    });

    it("allows me to unstar the gossyp even after starring it once", function() {
      $('#gossyp_1 .toggle_star').submit();
      expect($('#gossyp_1').text()).toContain('2 attempt to star gossyp 1');
    });
  });
});

