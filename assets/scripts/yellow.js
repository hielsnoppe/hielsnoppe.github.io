(function () { 'use strict';

function animate () {

    var env = document.getElementById('#envelope-front-center');

    env.className += ' animate';
}

window.animate = animate;

}());

(function ($) { 'use strict';

$(document).ready(function () {

    $('#show-past-switch').click(function () {

        $(this).toggleClass('on off');
        $('.past').toggle($(this).hasClass('on'));
    });

    $('#show-present-switch').click(function () {

        $(this).toggleClass('on off');
        $('.present').toggle($(this).hasClass('on'));
    });

    $('#show-future-switch').click(function () {

        $(this).toggleClass('on off');
        $('.future').toggle($(this).hasClass('on'));
    });

    $(".show-details-switch").click(function () {

        $(this).parent().next('.description').toggleClass('hidden');
    });
});

})(jQuery);
