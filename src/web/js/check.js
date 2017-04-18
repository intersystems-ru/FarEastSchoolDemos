'use strict'
/**
*Функция отечающая за получение категорий.
*Помимо получения категорий подгружает задачи состоящие в данной категории.
*Требуется:
*	1.Указать такой REST API URL предоставляемый RESTForms, чтобы
*	  получить категории задач.
*	2.Указать тип запроса.
*	3.Заполнить обьект данными полученными спомошью запроса.
*/
function check()
{
	$.ajax({
    	url: 'http://'+location.host+'/sampleforms/form/objects/SampleUI.Category/info',
    	type: 'GET',

    	success: function(data) {
    		/*data - переменная содержащая в себе JSON обьект возвращённый запросом*/
    		var option_setup = Array();

    		for (var i = 0; i < data.total; i++) {
	    		option_setup[i] = {

			        id: data.children[i]._id, /*Сюда требуется установить ID категории*/

			        text: data.children[i].displayName /*Сюда требуется установить название категории*/

		        }
	    	}



//===================Код не относящийся к заданию==========================================
     		var select = $('select#cat');

      		for (var i = 0; i < data.total; i++) {
		        $('<option/>', option_setup[i])
        		.appendTo(select);
      		}

	      	select.show();
    	},

    	dataType: 'json'   
  	});
}
//===========================================================================================



















