
component extends="mxunit.framework.TestCase" {
	include "convertqueryStringToStruct.cfm";

	function Simple(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="a=1");
		local.teststruct["a"] = ["1"];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	function DuplicatedParameter(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="a=1,2&b=3&a=4,5");
		local.testarray = [];
		arrayappend(local.testarray,"1,2");
		arrayappend(local.testarray,"4,5");
		local.teststruct["a"] = local.testarray;
		local.teststruct["b"] = ["3"];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	function SingleEmptyStringWithAssignmentOperator(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="a=");
		local.teststruct["a"] = [""];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	function MultipleEmptyStringsWithAssignmentOperator(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="a=&b=");
		local.teststruct["a"] = [""];
		local.teststruct["b"] = [""];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	function MultipleEmptyStringsWithoutAssignmentOperator(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="a&b");
		local.teststruct["a"] = [""];
		local.teststruct["b"] = [""];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	function DoubleAssignmentOperator(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="a==");
		local.teststruct["a"] = ["="];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	function EncodedUrl(){
		local.queryStringStruct = convertqueryStringToStruct(queryString="user=john%20doe");
		local.teststruct["user"] = ["john doe"];
		assertEquals(local.queryStringStruct, local.teststruct);
	}

	
}
