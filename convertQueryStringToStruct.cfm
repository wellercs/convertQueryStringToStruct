<cffunction name="queryStringToStruct" access="public" returntype="struct" output="false" hint="Accepts a url query string and returns it as a structure.">
    <cfargument name="queryString" type="string" required="true" hint="Query string for which to parse.">
	<cfargument name="delimiters" type="string" required="false" default="&" hint="Delimiters of the query string.">
	<cfargument name="assignmentOperator" type="string" required="false" default="=" hint="Assignment operator of the query string.">

	<!--- var local used to support versions older than ColdFusion 9 --->
	<cfset var local = structNew()>
	<!--- structnew() to support versions older than ColdFusion 7 instead of {} --->
	<cfset local.queryStringStruct = structNew()>

	<cfloop list="#arguments.queryString#" index="local.queryStringIndex" delimiters="#arguments.delimiters#">
		<cfset local.queryStringKey = urlDecode(listFirst(local.queryStringIndex,arguments.assignmentOperator))>
		<cfif !find(arguments.assignmentOperator,local.queryStringIndex)>
			<cfset local.queryStringValue = "">
		<cfelse>
			<cfset local.queryStringValue = replaceNoCase(urldecode(listRest(local.queryStringIndex,arguments.assignmentOperator,true)),local.queryStringKey & arguments.assignmentOperator,"")>
		</cfif>
		<cfif !structKeyExists(local.queryStringStruct,local.queryStringKey)>
			<cfset structInsert(local.queryStringStruct,local.queryStringKey,[])>
		</cfif>
		<cfset arrayAppend(local.queryStringStruct[local.queryStringKey],local.queryStringValue)>
	</cfloop>

	<cfreturn local.queryStringStruct>
</cffunction>