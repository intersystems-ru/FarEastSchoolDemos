'use strict'

init();

// Events
$('input#myInput').keyup(function (event) {
  if (event.keyCode == 13) {
    if ($(this).val().length != 0)
      postTaskAJAX($(this).val(), $('select#cat option:selected').attr('id'));
  }
});

$('span.addBtn').click(function (event) {
  if ($('input#myInput').val().length != 0)
      postTaskAJAX($('input#myInput').val(), $('select#cat option:selected').attr('id'));
});

$('select#cat').change(function(e) {
  $('ul#myUL li').remove();
  getTasksAJAX($('select#cat option:selected').attr('id'));
});

$('select#lang').change(function(e) {
  getWordsAJAX($('select#lang option:selected').attr('id'));
});

function init() {
  $('input#myInput').attr("placeholder", "Title...");
  getLanguagesAJAX();
  check();
  getCategoriesAJAX();
}

function addTask(id, text, checked) {
  var li = $('<li id="'+id+'"/>').text(text+", ID:"+id);

  if (checked) li.addClass('checked');


  $("<span/>", {
      'class': 'close',
      text : '\u00D7',
      click: function(event) {
        $(this).parent().off();
        deleteTaskAJAX($(this).parent().attr('id'));
      } 
  }).appendTo(li);

  $('ul#myUL').prepend(li);

  li.click(function(event) {

    var checked = $(this).hasClass('checked')?0:1;

    putTaskAJAX($(this).attr('id'), checked);
  })
}

function getLanguagesAJAX()
{	
	$.ajax({
        url: 'http://'+location.host+'/samplerest/get_languages',
        type: 'GET',

        complete: function(data) {
	        for (var i = 0; i < data.responseJSON.languages.length; i++){
	    	    $('<option/>', {
		    	    id:data.responseJSON.languages[i],
		    	    text:langCode[data.responseJSON.languages[i]]
		    	})
		    	.appendTo('select#lang');
		    }
		    
		    $('select#lang option:selected').removeAttr('selected');
		    $('option#en').attr('selected','');
		    
		    getWordsAJAX('en');
        },
        dataType: 'json'   
    });
}

function getWordsAJAX(lang)
{	
	$.ajax({
        url: 'http://'+location.host+'/samplerest/get_words/'+lang,
        type: 'GET',

        complete: function(data) {
	        for (var i = 0; i < data.responseJSON.length; i++){
	    	    if (data.responseJSON[i].id != 'myInput') {
	    	    	$('#'+data.responseJSON[i].id).text(data.responseJSON[i].word);
	    	    } else {
		    	    $('input#myInput').attr("placeholder", data.responseJSON[i].word+'...');
		    	}
		    }
        },
        dataType: 'json'   
    });
}

var langCode = {
            sq: "Albanian",
            ar: "Arabian",
            hy: "Armenian",
            az: "Azeri",
            be: "Belarusian", 
            bs: "Bosnian",
            eu: "Basque",
            bg: "Bulgarian",
            ca: "Catalan",
            hr: "Croatian",
            cs: "Czech",
            zh: "Chinese",
            da: "Danish",
            nl: "Dutch",
            en: "English",
            et: "Estonian",
            eo: "Esperanto",
            fi: "Finnish",
            fr: "French",
            ka: "Georgian",
            de: "German",
            el: "Greek",
            he: "Hebrew",
            hu: "Hungarian",
            is: "Icelandic",
            id: "Indonesian",
            it: "Italian",
            ja: "Japanese",
            kk: "Kazakh",
            ko: "Korean",
            la: "Latin",
            lv: "Latvian",
            lt: "Lithuanian",
            mk: "Macedonian",
            ms: "Malay",
            mt: "Maltese",
            no: "Norwegian",
            pl: "Polish",
            pt: "Portuguese Brazil",
            ro: "Romanian",
            ru: "Russian",
            es: "Spanish",
            sr: "Serbian",
            sk: "Slovak",
            sl: "Slovenian",
            sv: "Swedish",
            th: "Thai",
            tr: "Turkish",
            uk: "Ukrainian",
            vi: "Vietnamese"
  };