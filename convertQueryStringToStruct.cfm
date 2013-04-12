<cffunction name="convertQueryStringToStruct" access="public" returntype="struct" output="false" hint="I accept a url query string and return it as a structure.">
    <cfargument name="querystring" type="string" required="true" hint="I am the query string for which to parse.">
	<cfargument name="querystringdelimiter" type="string" required="false" default="&" hint="I am the delimiter of the query string.">
	<cfargument name="querystringassignmentoperator" type="string" required="false" default="=" hint="I am the assignment operator of the query string.">

	<!--- var local used to support versions older than ColdFusion 9 --->
	<cfset var local = structnew()>
	<!--- structnew() to support versions older than ColdFusion 7 instead of {} --->
	<cfset local.querystringstruct = structnew()>

	<cfloop list="#arguments.querystring#" index="local.querystringindex" delimiters="#arguments.querystringdelimiter#">
		<cfset local.querystringkey = urldecode(listfirst(local.querystringindex,arguments.querystringassignmentoperator))>
		<cfif !find(arguments.querystringassignmentoperator,local.querystringindex)>
			<cfset local.querystringvalue = "">
		<cfelse>
			<cfset local.querystringvalue = replacenocase(urldecode(listrest(local.querystringindex,arguments.querystringassignmentoperator,true)),local.querystringkey & arguments.querystringassignmentoperator,"")>
		</cfif>
		<cfif !structkeyexists(local.querystringstruct,local.querystringkey)>
			<cfset structinsert(local.querystringstruct,local.querystringkey,[])>
		</cfif>
		<cfset arrayappend(local.querystringstruct[local.querystringkey],local.querystringvalue)>
	</cfloop>

	<cfreturn local.querystringstruct>
</cffunction>