Class SampleUI.Utils
{

ClassMethod repopulateAll(num = 100) As %Integer
{
	set sc = $$$OK
	
	do ##class(SampleUI.Category).%KillExtent()
	do ##class(SampleUI.Task).%KillExtent()
	
	set sc = ##class(SampleUI.Category).Populate()
	
	if $$$ISERR(sc) {
		quit -1	
	}
	set col = ##class(SampleUI.Task).Populate(num)
	
	quit col
}

ClassMethod repopulateTasks(num = 100) As %Integer
{
	
	do ##class(SampleUI.Task).%KillExtent()
	set col = ##class(SampleUI.Task).Populate(num)
	
	quit col
}

ClassMethod setup() As %Status
{
	set namespace = $namespace
	set $namespace = "%SYS"
	if ##class(Security.Applications).%ExistsId("/samplerest") {
		set restapp = ##class(Security.Applications).%OpenId("/samplerest")
		set restapp.NameSpace = namespace
		set restapp.IsNameSpaceDefault = $$$NO
		set restapp.GroupById = "/samplerest"
		set restapp.CookiePath = "/samplerest/"
		set restapp.MatchRoles = ":%All"
		set restapp.AutheEnabled = $$$AutheUnauthenticated
		set restapp.DispatchClass = "SampleUI.REST"
		do restapp.%Save()
	} else {
		set restapp("NameSpace") = namespace
		set restapp("IsNameSpaceDefault") = $$$NO
		set restapp("GroupById") = "/samplerest"
		set restapp("CookiePath") = "/samplerest/"
		set restapp("MatchRoles") = ":%All"
		set restapp("AutheEnabled") = $$$AutheUnauthenticated
		set restapp("DispatchClass") = "SampleUI.REST"
		do ##class(Security.Applications).Create("/samplerest",.restapp)
	}
	set $namespace = namespace

	do ..repopulateAll()
	quit $$$OK
}

ClassMethod dictionary() [ CodeMode = objectgenerator, Private ]
{
	//English
	set ^CacheMsg("SAMPLEUI","en","labCat") = "Category"
	set ^CacheMsg("SAMPLEUI","en","addBtn") = "Add"
	set ^CacheMsg("SAMPLEUI","en","title") = "My To Do List"
	set ^CacheMsg("SAMPLEUI","en","myInput") = "Title"
	set ^CacheMsg("SAMPLEUI","en","labLang") = "Language"
	//Russian
	set ^CacheMsg("SAMPLEUI","ru","labCat") = "Категория"
	set ^CacheMsg("SAMPLEUI","ru","addBtn") = "Добавить"
	set ^CacheMsg("SAMPLEUI","ru","title") = "Мой Список Дел"
	set ^CacheMsg("SAMPLEUI","ru","myInput") = "Заголовок"
	set ^CacheMsg("SAMPLEUI","ru","labLang") = "Язык"
}

}

