<cffunction name="convertQueryStringToStruct" access="public" returntype="struct" output="false" hint="I accept a url query string and return it as a structure.">
	<cfargument name="querystring" type="string" required="true" hint="I am the query string for which to parse.">

	<cfset var local = {}>

	<cfset local.jHtmlTools = CreateObject('java', 'coldfusion.util.HTMLTools') />
	<cfset local.urlQueryStringStruct = local.jHtmlTools.parseQueryString(arguments.querystring) />

	<cfreturn local.urlQueryStringStruct>
</cffunction>