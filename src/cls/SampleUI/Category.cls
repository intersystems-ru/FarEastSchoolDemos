Class SampleUI.Category Extends (%Persistent, Form.Adaptor)
{

Parameter FORMNAME = "Category";

Parameter OBJPERMISSIONS As %String = "CRUD";

Parameter DISPLAYPROPERTY As %String = "Name";

Property Name As %String(DISPLAYNAME = "Name");

Index NameInd On Name [ Unique ];

Relationship Tasks As SampleUI.Task [ Cardinality = many, Inverse = Category ];

ClassMethod Populate() As %Status
{
	set sc = $$$OK
	set listOfCategories = $LISTBUILD("Home", "Work", "Education", "Hobby", "Leisure", "Other")
	
	for i=1:1:$LISTLENGTH(listOfCategories) {
		set obj = ..%New()
		set obj.Name = $LISTGET(listOfCategories, i)
		set sc = obj.%Save() 
	}
	
	quit sc
}

Storage Default
{
<Data name="CategoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^SampleUI.CategoryD</DataLocation>
<DefaultData>CategoryDefaultData</DefaultData>
<IdLocation>^SampleUI.CategoryD</IdLocation>
<IndexLocation>^SampleUI.CategoryI</IndexLocation>
<StreamLocation>^SampleUI.CategoryS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

