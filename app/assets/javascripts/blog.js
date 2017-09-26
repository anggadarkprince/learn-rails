$(document).on('turbolinks:load', function () {
    $('.custom-file-input').on('change', function () {
        var fileName = $(this).val();
        if (fileName !== '') {
            fileName = fileName.split('\\').pop();
        }
        $(this).next('.custom-file-control').addClass('selected').html(fileName);
    });

    $('.tags').tagsinput({
        tagClass: 'badge badge-primary badge-pill'
    });

    $.ajax({
        url: 'https://api.github.com/emojis',
        async: false
    }).then(function(data) {
        window.emojis = Object.keys(data);
        window.emojiUrls = data;
    });;

    $('.text-editor').summernote({
        height: 200,
        placeholder: 'Type a awesome content',
        hint: {
            match: /:([\-+\w]+)$/,
            search: function (keyword, callback) {
                callback($.grep(emojis, function (item) {
                    return item.indexOf(keyword)  === 0;
                }));
            },
            template: function (item) {
                var content = emojiUrls[item];
                return '<img src="' + content + '" width="20" /> :' + item + ':';
            },
            content: function (item) {
                var url = emojiUrls[item];
                if (url) {
                    return $('<img />').attr('src', url).css('width', 20)[0];
                }
                return '';
            }
        }
    });

    // incompatibility issue with bootstrap 4
    $('.note-btn').removeAttr('data-original-title');
    $('.note-popover').css({'display': 'none'});

    function createSlug(str) {
        var slug;
        var trimmed = $.trim(str);
        slug = trimmed.replace(/[^a-z0-9-]/gi, '-').replace(/-+/g, '-').replace(/^-|-$/g, '');
        return slug.toLowerCase();
    }

    var slugify = $('.slugify');
    if (slugify.length) {
        var slugTarget = slugify.data('target');
        slugify.keyup(function () {
            if (!$(slugTarget).hasClass('changed')) {
                $(slugTarget).val(createSlug($(this).val()));
            }
        });

        if ($(slugTarget).length) {
            $(slugTarget).keyup(function () {
                if (slugify.val() !== '') {
                    $(this).addClass('changed');
                }
            });
        }
    }

    $('#btn-edit-slug').on('click', function () {
        var slugTarget = $('.slugify').data('target');
        if ($(this).hasClass('editing')) {
            $(this).text('Edit').removeClass('editing');
            $(slugTarget).attr('readonly', true);
        } else {
            $(this).text('Set Slug').addClass('editing');
            $(slugTarget).removeAttr('readonly');
        }
    });

    $('.btn-delete-article').on('click', function(e){
        e.preventDefault();

        var title = $(this).data('title');
        var urlDelete = $(this).attr('href');

        var modalDelete = $('#modal-delete-article');
        modalDelete.find('form').attr('action', urlDelete);
        modalDelete.find('#article-title').text(title);
        modalDelete.modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    $('.btn-delete-comment').on('click', function(e){
        e.preventDefault();
        var urlDelete = $(this).attr('href');
        var modalDelete = $('#modal-delete-comment');
        modalDelete.find('form').attr('action', urlDelete);
        modalDelete.modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    var formCommentTemplate = $('#comment-form-wrapper').clone();
    $('.btn-reply').on('click', function (e) {
        e.preventDefault();
        var commentParentId = $(this).closest('ul').data('id');
        formCommentTemplate.find('input[name="comment[comment_id]"]').val(commentParentId);
        $(this).closest('ul').after(formCommentTemplate);
    });
});