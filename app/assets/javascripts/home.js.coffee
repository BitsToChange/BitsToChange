$(document).on 'ready page:load', ->
  $('div.goals').before '<img class="world-topper" src="/images/world-topper.png">'

angular.module("btc-home", [])
.controller "DonateCtrl",
  class DonateCtrl
    constructor: ->
      @options = [
        {type: 'bitcoin', address: '1CTTGAxZDUuJKcxxmw58SVrgKsuatMVpWa'},
        {type: 'litecoin', address: 'LgfU5BkchhqVmyUiaL9Egusnm6dumAZ713'},
        {type: 'dogecoin', address: 'DN2dmH97Z1DLUEK1Q3cd49sXFX1e8bZ1We'},
      ]
      @selected = @options[0]