<cffunction name="convertqueryStringToStruct" access="public" returntype="struct" output="false" hint="I accept a url query string and return it as a structure.">
    <cfargument name="queryString" type="string" required="true" hint="I am the query string for which to parse.">
	<cfargument name="queryStringDelimiter" type="string" required="false" default="&" hint="I am the delimiter of the query string.">
	<cfargument name="queryStringAssignmentOperator" type="string" required="false" default="=" hint="I am the assignment operator of the query string.">

	<!--- var local used to support versions older than ColdFusion 9 --->
	<cfset var local = structnew()>
	<!--- structnew() to support versions older than ColdFusion 7 instead of {} --->
	<cfset local.queryStringstruct = structnew()>

	<cfloop list="#arguments.queryString#" index="local.queryStringindex" delimiters="#arguments.queryStringDelimiter#">
		<cfset local.queryStringkey = urldecode(listfirst(local.queryStringindex,arguments.queryStringAssignmentOperator))>
		<cfif !find(arguments.queryStringAssignmentOperator,local.queryStringindex)>
			<cfset local.queryStringvalue = "">
		<cfelse>
			<cfset local.queryStringvalue = replacenocase(urldecode(listrest(local.queryStringindex,arguments.queryStringAssignmentOperator,true)),local.queryStringkey & arguments.queryStringAssignmentOperator,"")>
		</cfif>
		<cfif !structkeyexists(local.queryStringstruct,local.queryStringkey)>
			<cfset structinsert(local.queryStringstruct,local.queryStringkey,[])>
		</cfif>
		<cfset arrayappend(local.queryStringstruct[local.queryStringkey],local.queryStringvalue)>
	</cfloop>

	<cfreturn local.queryStringstruct>
</cffunction>