$(function () {

    var editor
        , $preview = $('#preview');
    var saved = {
        slug: '',
        title: '',
        content: '',
        on_server: false
    };
    function getSaved() {
        var p
        try {
            p = JSON.parse(localStorage.saved)
        } catch (e) {
            p = saved
        }
        return p
    }
    function updateSaved(saved) {
        localStorage.clear();
        localStorage.saved = JSON.stringify(saved);
    }
    function autoSave() {
        setInterval(function() {
     //       console.log("Auto save...")
            saved.content = editor.getSession().getValue();
            saved.title = $('#filename > span[contenteditable="true"]').text();

            updateSaved(saved);
        }, 3000)
    }
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

        saved.slug = $("#wikiSlug").val();
        saved.content = $("#wikiContent").val();
        saved.title = $("#wikiTitle").val();
        saved.on_server = false;

        $("#saveBtn").bind("click", function() {
            $("#wikiTitle").val($('#filename > span[contenteditable="true"]').text());
            $("#wikiContent").val(editor.getSession().getValue());
            $("#wikiForm").submit();

            saved.on_server = true;
            updateSaved(saved);
        });

        $("#restoreBtn").bind("click", function() {
            console.log("Restore unsaved data.");
            var last_saved = getSaved();
            editor.getSession().setValue(last_saved.content);
            $('#filename > span[contenteditable="true"]').text(last_saved.title);
            previewMd();

            $('#restore').modal('hide');
        });

        var last_saved = getSaved();
        if (last_saved.slug == $("#wikiSlug").val() && !last_saved.on_server) {
            $('#restore').modal({
                show:true
            });
        } else {
            autoSave();
        }
        $('#restore').on('hidden', function () {
            autoSave();
        })
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
