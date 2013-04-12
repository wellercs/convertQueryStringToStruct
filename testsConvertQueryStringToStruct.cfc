
component extends="mxunit.framework.TestCase" {
	

	function setUp(){
		variables.obj = new MyConvertQueryStringToStructComponentTest();
	}

	function tearDown(){ }
	
	function test_Simple(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="a=1");
		local.teststruct["a"] = ["1"];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	function test_DuplicatedParameter(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="a=1,2&b=3&a=4,5");
		local.testarray = [];
		arrayappend(local.testarray,"1,2");
		arrayappend(local.testarray,"4,5");
		local.teststruct["a"] = local.testarray;
		local.teststruct["b"] = ["3"];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	function test_SingleEmptyStringWithAssignmentOperator(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="a=");
		local.teststruct["a"] = [""];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	function test_MultipleEmptyStringsWithAssignmentOperator(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="a=&b=");
		local.teststruct["a"] = [""];
		local.teststruct["b"] = [""];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	function test_MultipleEmptyStringsWithoutAssignmentOperator(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="a&b");
		local.teststruct["a"] = [""];
		local.teststruct["b"] = [""];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	function test_DoubleAssignmentOperator(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="a==");
		local.teststruct["a"] = ["="];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	function test_EncodedUrl(){
		local.querystringstruct = variables.obj.convertQueryStringToStruct(querystring="user=john%20doe");
		local.teststruct["user"] = ["john doe"];
		assertEquals(local.querystringstruct, local.teststruct);
	}

	
}
