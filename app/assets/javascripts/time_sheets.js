var time_sheets = {
    switch_start_work: function (btn_switch, url) {
        var is_clock_in = btn_switch.is(':checked'), work_report_field = $('textarea[name=\'time_sheet[work_report]\']');
        if (is_clock_in){
            work_report_field.val('');
            work_report_field.closest('div').fadeIn();
        } else
            work_report_field.closest('div').fadeOut();
        var work_report = work_report_field.val();

        $.ajax({
            url: url,
            type: 'POST',
            data: {is_clock_in: is_clock_in, work_report: work_report},
            success: function (data) {
                $('#time-sheet-content').html(data);
            }
        });
    },
    view_note: function(link_view_note) {
        $.ajax({
            url: link_view_note.attr('href'),
            type: 'GET',
            success: function (data) {
                var modal_view_note = $('#modal-view-note');
                modal_view_note.html(data);
                modal_view_note.openModal();
            }
        });
    },
    edit_note: function (link_edit_note) {
        var modal_view_note = $('#modal-view-note');
        modal_view_note.closeModal();

        $.ajax({
            url: link_edit_note.attr('href'),
            type: 'GET',
            success: function (data) {
                var modal_edit_note = $('#modal-edit-note');
                modal_edit_note.html(data);
                modal_edit_note.openModal();
            }
        });
    },
    update_note: function (data) {
        var modal_edit_note = $('#modal-edit-note');
        modal_edit_note.closeModal();
        if (data.success)
            message_utils.show_success(data.message);
        else
            message_utils.show_error(data.message);
    }
};
