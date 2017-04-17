Include %IKPublic

Class Community.iKnow
{

/// Запускает процесс анализа данных
/// DomainName - название домена
ClassMethod StartAnalisis(DomainName As %String) As %Status
{
	//Проверяем существует ли Домен, если нет то создаем
	do ..CreateDomainIfNotExists(DomainName)
	
	//Получаем ID домена который мы указали
	set domId  = ##class(%iKnow.Domain).GetOrCreateId(DomainName)
	
	//Lister для поиска источников, соответствующих записям в результатах запроса
	set lister = ##class(%iKnow.Source.SQL.Lister).%New(domId)
	//Loader координирует процесс загрузки.
	set loader = ##class(%iKnow.Source.Loader).%New(domId)
	
	//Запрос с помощью которого мы получаем данные всех постов для анализа
		//ID - это id поста
		//Text - текст поста
	set myquery = "SELECT ID, Text FROM Community.Post"
	
	//Указываем iKnow по какому полю делать анализ, группировать и сам ID
	set data = $lb("Text")
	set group = "ID"
	set id = "ID"
	
	//Занесем все данные в Lister
	set tSC = lister.AddListToBatch(myquery, id, group, data)
	//Запускаем процесс анализа
	set tSC = loader.ProcessBatch()
	
	//Возврат результата
	return tSC
}

/// Проверяем существует ли Домен, если нет то создаем
ClassMethod CreateDomainIfNotExists(DomainName As %String) As %Status
{
	if '(##class(%iKnow.Domain).Exists(DomainName)) 
	{
		write "Domain " _ DomainName _ " does not exist.", !
	
		write "Creating new domain: " _ DomainName, !
				
		#dim status As %Status = ..CreateDomain(DomainName)
			
		if (status = $$$OK) 
		{
			write "New domain " _ DomainName _ " was created successfully.", !	
		}
		else 
		{
			return status
		}	
	}
	return 0
}

/// Создание нового домена
/// DomainName - имя создаваемого домена
ClassMethod CreateDomain(DomainName As %String) As %iKnow.Domain
{
	if (##class(%iKnow.Domain).Exists(DomainName))
	{
		#dim domain As %iKnow.Domain = ##class(%iKnow.Domain).Open(DomainName)
		write "   open domain ", DomainName, " ", !
	}
	else
	{
		set domain = ##class(%iKnow.Domain).%New(DomainName)
		do domain.%Save()
		do domain.SetParameter($$$IKPSTEMMING, 1)	
		do domain.%Save()
		
		write "   domain ", DomainName, " created!", !
	}
	return domain
}

/// Удаление домена
/// DomainName - имя создаваемого домена
ClassMethod DeleteDomain(DomainName As %String) As %Status
{
	if (##class(%iKnow.Domain).Exists(DomainName)) {
		set domain  = ##class(%iKnow.Domain).Open(DomainName)
		set domainId = domain.Id
		set tSC = ##class(%iKnow.Domain).DeleteId(domainId)	
		
		if (tSC = $$$OK) {
			write "Domain ", DomainName, " deleted successfully.", !
			return $$$OK
		}
		else {
			write "Error: failed to delete domain ", DomainName, !
			return $$$ERROR()
		}
	}
	else {
		write "Domain ", DomainName, " doesn't exist", !
		return $$$ERROR()
	}
}

}
