Include Community

/// Это класс нашей базы для постов.
/// Эти посты мы и будем анализировать с помащю iKnow.
Class Community.Post Extends %Persistent
{

Property Nid As %Integer [ Required ];

Index IDKEY On Nid [ IdKey, Unique ];

Property Type As %String(VALUELIST = ",code_package,documentation,learning_track,video,post");

Property Tags As %String(MAXLEN = 350);

Property Views As %Integer;

Property AvgVote As %Integer;

Property VotesAmount As %Integer;

Property Name As %String(MAXLEN = 250);

Property Created As %TimeStamp;

Property Published As %Boolean;

Property PublishedDate As %TimeStamp;

Property Deleted As %Boolean;

Property Text As %String(MAXLEN = "");

Property Link As %String(MAXLEN = 150) [ SqlComputeCode = {set {*} = $$$Server _ "node/" _ {Nid}}, SqlComputed, SqlComputeOnChange = %%INSERT ];

Index Link On Link [ Unique ];

Property Comments As %String(MAXLEN = "");

Property Author As %String(MAXLEN = "");

Index AuthorIndex On Author;

Property GroupsClass As %String(MAXLEN = "");

Property CommentsAmount As %Integer [ Calculated ];

Property PostType As %String(VALUELIST = ",Question,Article");

/// Hash of input row, used to build this object
Property Hash As %String;

Property SubsCount As %Integer;

Property HaveCorrectAnswer As %Boolean;

}
