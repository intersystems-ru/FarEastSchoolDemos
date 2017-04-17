/// 
Class SampleUI.BI.TaskCube Extends %DeepSee.CubeDefinition [ DependsOn = SampleUI.Task, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="TaskCube" displayName="TaskCube" disabled="false" abstract="false" sourceClass="SampleUI.Task" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false">
  <dimension name="Name" disabled="false" hasAll="false" allCaption="All Name" allDisplayName="Name" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Name" disabled="false" sourceProperty="Category.Name" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Created" disabled="false" hasAll="false" allCaption="All Created" allDisplayName="Created" sourceProperty="Created" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
      <level name="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
      <level name="Day" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Performed" disabled="false" hasAll="false" allCaption="All Performed" allDisplayName="Performed" sourceProperty="Performed" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
      <level name="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
      <level name="Day" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Status" disabled="false" hasAll="false" allCaption="All Status" allDisplayName="Status" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Status" disabled="false" sourceProperty="Status" list="false" rangeExpression="0:Новое;1:Завершено;" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <listing name="New_listing1" disabled="false" listingType="table" fieldList="Text,Created,Category-&gt;Name,Status,&apos;http://localhost:57773/FormsUI/index.html#/obj/SampleUI.Task/object/&apos; || ID as FormsLink">
  </listing>
</cube>
}

Parameter DOMAIN;

}

