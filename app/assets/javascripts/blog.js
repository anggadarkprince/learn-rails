$(document).on('turbolinks:load', function () {
    $('.custom-file-input').on('change', function () {
        var fileName = $(this).val();
        if (fileName != '') {
            fileName = fileName.split('\\').pop();
        }
        $(this).next('.custom-file-control').addClass('selected').html(fileName);
    });

    $('.tags').tagsinput({
        tagClass: 'badge badge-primary badge-pill'
    });

    function createSlug(str) {
        var $slug;
        var trimmed = $.trim(str);
        $slug = trimmed.replace(/[^a-z0-9-]/gi, '-').replace(/-+/g, '-').replace(/^-|-$/g, '');
        return $slug.toLowerCase();
    }

    var slugify = $('.slugify');
    if (slugify.length) {
        var slugTarget = $('.slugify').data('target');
        $('.slugify').keyup(function () {
            if (!$(slugTarget).hasClass('changed')) {
                $(slugTarget).val(createSlug($(this).val()));
            }
        });

        if ($(slugTarget).length) {
            $(slugTarget).keyup(function () {
                if (slugify.val() != '') {
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
    })

});
