$(function () {

    var editor
        , $preview = $('#preview');

    function initEditor() {
        //init editor
        editor = ace.edit("editor");
        editor.getSession().setUseWrapMode(true)
        editor.setShowPrintMargin(false)
        editor.getSession().setMode('ace/mode/markdown')
        editor.getSession().setValue("")
        editor.setTheme("ace/theme/tomorrow_night_eighties");
        $('#editor').bind('keyup', previewMd);
    }
    function bindKeyEvent() {
        key('command+s, ctrl+s', function (e) {
            //Just ignore it.
            e.preventDefault() // so we don't save the webpage - native browser functionality
        })
        var command = {
            name: "save",
            bindKey: {
                mac: "Command-S",
                win: "Ctrl-S",
                sender: 'editor|cli'
            },
            exec: function () {
                //Just ignore it.
            }
        }
        editor.commands.addCommand(command);
    }
    function init() {
        initEditor();
        bindKeyEvent();

        editor.getSession().setValue($("#wikiContent").val());
        $('#filename > span[contenteditable="true"]').text($("#wikiTitle").val());
        previewMd();

        $("#saveBtn").bind("click", function() {
            $("#wikiTitle").val($('#filename > span[contenteditable="true"]').text());
            $("#wikiContent").val(editor.getSession().getValue());

            $("#wikiForm").submit();
        });
    }
    function previewMd() {

        var unmd = editor.getSession().getValue()
            , md =  marked(unmd)
        $("#temp").html(md);
        Rainbow.color($("#temp"), function() {
            $preview
                .html('') // unnecessary?
                .html($("#temp").html())
        })
    }
    init();
})
