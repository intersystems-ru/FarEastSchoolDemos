Class SampleUI.REST Extends %CSP.REST
{

XData UrlMap
{
<Routes>
	<Route Url="/get_languages" Method="GET" Call="getLanguages"/>
	<Route Url="/get_words/:lang" Method="GET" Call="getWords"/>
</Routes>
}

ClassMethod getLanguages() As %Status
{
	set obj = "{""languages"":["
	set lang=""
	for {
		set lang = $order(^CacheMsg("SAMPLEUI",lang))
		quit:lang=""
		set obj = obj_""""_lang_""","
	}
	set obj = obj_"]"
	w $piece(obj,",]",1)_"]}"
	quit $$$OK
}

ClassMethod getWords(lang As %String) As %Status
{
	set obj = "["
	set id = ""
	for {
		set id = $order(^CacheMsg("SAMPLEUI",lang,id))
		quit:id=""
		set word = ^CacheMsg("SAMPLEUI",lang,id)
		set obj = obj_"{""id"":"""_id_""", ""word"":"""_word_"""},"
	}
	
	set obj = obj_"]"
	w $piece(obj, ",]", 1)_"]"
	quit $$$OK
}

}

