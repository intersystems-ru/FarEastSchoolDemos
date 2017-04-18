Class SampleUI.Task Extends (%Persistent, Form.Adaptor, %Populate)
{

/**
*Задание: Сделать класс доступным для RESTForms
*Для того чтобы класс стал доступным для RESTForms
*	Добавьте в Extends класс Form.Adaptor
*	Добавьте в класс 4 параметра DISPLAYPROPERTY, OBJPERMISSIONS, FORMNAME, FORMORDERBY
*	Добавьте к свойствам которые должны отображаться в RESTFormsUI параметр DISPLAYNAME
*/
Property Status As %Boolean(DISPLAYNAME = "Status", POPORDER = 3, POPSPEC = ".setStatus()");

Property Text As %String(DISPLAYNAME = "Text", MAXLEN = 100, POPSPEC = ".taskCreator()");

Property Created As %TimeStamp(POPORDER = 1, POPSPEC = "TimeStamp($zdt((+$zts-20)_"",""_$random(86400), 3, 1, 3), $zdt($zts, 3, 1, 3))");

Property Performed As %TimeStamp(POPORDER = 2, POPSPEC = ".performedDate()") [ SqlComputeCode = {set {*} = $case({Status}, 0:"", 1:$case({*}, "":$ZDT($NOW(), 3, 1, 3), :{*}))}, SqlComputed, SqlComputeOnChange = Status ];

Relationship Category As SampleUI.Category [ Cardinality = one, Inverse = Tasks ];

Index CategoryIndex On Category;

Method %OnNew() As %Status [ Private, ServerOnly = 1 ]
{
	if i%Created = "" {
		set i%Created = $ZDATETIME($NOW(), 3, 1, 3)
	}
	set i%Status = 0
	
	Quit $$$OK
}

Method performedDate() As %TimeStamp
{
	set CreatedDate = $ZDATETIMEH(i%Created, 3, 1, 3)
	if ($RANDOM(2)) {
		set date = (+CreatedDate+$RANDOM(10))_","_$RANDOM(86400)
		if (date < $NOW()) {
			quit $ZDATETIME(date, 3, 1, 3)
		} else {
			quit ""
		}
	} else {
		quit ""
	}
}

Method taskCreator() As %String
{
	set verbList = $lb("Make", "Walk", "Get", "Buy")
	set adjectiveList = $lb("beautiful", "unbearable", "difficult", "expensive")
	set nounList = $lb("task", "dog", "food", "form")
	
	set task = $lg(verbList,$random($ll(verbList))+1)
	set task = task_" "_$lg(adjectiveList,$random($ll(adjectiveList))+1)
	set task = task_" "_$lg(nounList,$random($ll(nounList))+1)
	
	quit task
}

Method setStatus() As %Boolean
{
	if i%Performed '= "" quit 1
	quit 0
}

Storage Default
{
<Data name="TaskDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Status</Value>
</Value>
<Value name="3">
<Value>Text</Value>
</Value>
<Value name="4">
<Value>Created</Value>
</Value>
<Value name="5">
<Value>Performed</Value>
</Value>
<Value name="6">
<Value>Deleted</Value>
</Value>
<Value name="7">
<Value>Category</Value>
</Value>
<Value name="8">
<Value>rand</Value>
</Value>
</Data>
<DataLocation>^SampleUI.TaskD</DataLocation>
<DefaultData>TaskDefaultData</DefaultData>
<ExtentSize>100</ExtentSize>
<IdLocation>^SampleUI.TaskD</IdLocation>
<IndexLocation>^SampleUI.TaskI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.92</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Category">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<Property name="Created">
<AverageFieldSize>19</AverageFieldSize>
<Selectivity>1.0753%</Selectivity>
</Property>
<Property name="Deleted">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Performed">
<AverageFieldSize>9.31</AverageFieldSize>
<OutlierSelectivity>.51:</OutlierSelectivity>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="Status">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Text">
<AverageFieldSize>18.64</AverageFieldSize>
<Selectivity>1.9608%</Selectivity>
</Property>
<SQLMap name="CategoryIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SampleUI.TaskS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

