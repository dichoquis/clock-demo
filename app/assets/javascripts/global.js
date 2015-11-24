/*** Message Utils ***/
var message_utils = {
    _default_options: {duration: 5},
    show_success: function (message, options) {
        options  = $.extend(this._default_options, options);
        var toast_class = '';
        this._show(message, options.duration, toast_class);
    },
    show_error: function (message, options) {
        options  = $.extend(this._default_options, options);
        var toast_class = ' red darken-5';
        this._show(message, options.duration, toast_class);
    },
    hide: function () {
        $('#toast-container').remove();
    },
    // Duration in seconds
    _show: function (message, duration, toast_class) {
        var btnClose = $('<i/>').addClass('material-icons a-toast-close').text('close').click(function () {
            $(this).closest('#toast-container').fadeOut();
        });
        var content = $('<div/>').append(message).append(btnClose);
        Materialize.toast(content, duration * 1000, 'rounded a-toast' + toast_class);
    }
};