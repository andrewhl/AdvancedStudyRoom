$(function() {
  return $('form#validate_games').live("submit", function() {
    var vars;
    vars = $(this).serialize();
    $('#validationModal').modal('toggle');

    $.ajax({
      type: $(this).attr("method"),
      url: this.action,
      cache: false,
      data: vars,
      complete: function(xhr) {
        $('#validationModal').modal('hide');
        alert('success');
      }
    });
    return false;
  });
});

$(function() {
  return $('form#tag_games').live("submit", function() {
    var vars;
    vars = $(this).serialize();
    $('#tagModal').modal('toggle');

    $.ajax({
      type: $(this).attr("method"),
      url: this.action,
      cache: false,
      data: vars,
      complete: function(xhr) {
        $('#tagModal').modal('hide');
        alert('success');
      }
    });
    return false;
  });
});