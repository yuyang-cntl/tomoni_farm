function jpostal() {
  $('#postal_code').jpostal({
    postcode : ['#postal_code'],
    address : {
      "[id$='prefecture']" : "%3",
      "[id$='city']"       : "%4",
      "[id$='street']"     : "%5"
    }
  });
}
$(document).on("turbolinks:load", jpostal);