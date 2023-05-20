$('.post-comment').click(function () {
    var product_id = $(this).prev().val();
    var user_id = $(this).prev().prev().val();
    var content = $(this).prev().prev().prev().val();
    $.ajax({
        method: 'POST',
        url: '/post-comment',
        data: {
            'product_id': product_id,
            'user_id': user_id,
            'content': content,
            '_token': $('meta[name="csrf-token"]').attr('content')
        },
        success: function (resp) {
            console.log(resp);
            var comments = '';
            for (var i in resp) {
                comments += '<div class="col-sm-8">';
                comments += '<div class="panel-white post panel-shadow">';
                comments += '<div class="post-heading">';
                comments += '<div class="pull-left">'
                comments += '<div class="image text-center p-t-15 avatar" style="background-color: #fcb1ae">' + resp[i].user_first_char + '</div>';
                comments += '</div>';
                comments += '<div class="pull-left meta m-l-30">';
                comments += '<div class="userName title h5">'
                comments += '<b>' + resp[i].user_comment + '</b>';
                comments += ' made a review'
                comments += '</div>';
                comments += '<h6 class="text-muted time">' + resp[i].created_at + '</h6>'
                comments += '</div>';
                comments += '</div>';
                comments += '</div>';
                comments += '<div class="post-description">';
                comments += '<p>' + resp[i].content + '</p>'
                comments += '</div>';
                comments += '</div>';
                comments += '</div>';
                if (resp[i].user_id == user_id) {
                    comments += '<div class="hidden"></div>';
                    comments += '<div class="delete-btn col-sm-1 p-t-50">';
                    comments += '<button><i class="fas fa-times"></i></button>'
                    comments += '</div>';
                }
            }
            $('.comments').html(comments);

            $(this).prev().prev().prev().val('');
        },
        error: function (error) {
            swal('Thao tác thất bại', JSON.parse(error.responseText).msg);
        }
    })
});
$('body').on('click', '.delete-btn', function () {
    var id = $(this).prev().text();
    var user_id = $('input[name="user_id"]').val();
    var product_id = $('input[name="product_id"]').val();
    $.ajax({
        method: 'POST',
        url: '/delete-comment',
        data: {
            'id': id,
            '_token': $('meta[name="csrf-token"]').attr('content'),
            'product_id': product_id
        },
        success: function (resp) {
            var comments = '';
            console.log(resp);
            for (var i in resp) {
                if (resp.length > 0) {
                    comments += '<div class="col-sm-8">';
                    comments += '<div class="panel-white post panel-shadow">';
                    comments += '<div class="post-heading">';
                    comments += '<div class="pull-left">'
                    comments += '<div class="image text-center p-t-15 avatar" style="background-color: #fcb1ae">' + resp[i].user_first_char + '</div>';
                    comments += '</div>';
                    comments += '<div class="pull-left meta m-l-30">';
                    comments += '<div class="userName title h5">'
                    comments += '<b>' + resp[i].user_comment + '</b>';
                    comments += ' made a review'
                    comments += '</div>';
                    comments += '<h6 class="text-muted time">' + resp[i].created_at + '</h6>'
                    comments += '</div>';
                    comments += '</div>';
                    comments += '</div>';
                    comments += '<div class="post-description">';
                    comments += '<p>' + resp[i].content + '</p>'
                    comments += '</div>';
                    comments += '</div>';
                    comments += '</div>';
                    if (resp[i].user_id == user_id) {
                        comments += '<div class="hidden">'+resp[i].id+'</div>';
                        comments += '<div class="delete-btn col-sm-1 p-t-50">';
                        comments += '<button><i class="fas fa-times"></i></button>'
                        comments += '</div>';
                        console.log('haha')
                    }
                } else {
                    comments += '<div>This product doesn\'t have any review</div>';
                }

            }
            $('.comments').html(comments);
        },
        error: function (error) {
            console.log(error);
            swal('Thao tác thất bại', JSON.parse(error.responseText).msg);
        }
    });

})