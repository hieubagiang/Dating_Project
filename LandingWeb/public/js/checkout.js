$('.time').click(function () {
    $('input[name=personal_training_time_id]').val($(this).next().text());
    $('input[name=time]').val($(this).text());
    if ($(this).hasClass('btn-secondary')) {
        $(this).removeClass('btn-secondary').addClass('btn-primary');
    } else if ($(this).hasClass('btn-primary')) {
        $(this).removeClass('btn-primary').addClass('btn-secondary');
    }
    $('.time').not(this).addClass('btn-secondary').removeClass('btn-primary');
});

$('.category-name').text(function (_, txt) {
    return txt.slice(0, -2);
});

$('input[name=user_id]').val($('#user_id').text());

$('.duration').click(function () {
    $('input[name=duration]').val($(this).text());
    $('input[name=duration_id]').val($(this).next().text());
    $('input[name=price]').val($(this).next().next().text());
});

$.each($('.time'), function () {
  if ($(this).next().next().text() === '0'){
      $(this).attr("disabled", true);
  }
});
