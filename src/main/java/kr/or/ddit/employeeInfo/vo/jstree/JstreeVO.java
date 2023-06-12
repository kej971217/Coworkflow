package kr.or.ddit.employeeInfo.vo.jstree;

public interface JstreeVO {
	public String getId(); // required
	public String getParent(); // required
	public String getText(); // node text
//	public String getIcon();
//	public boolean opened();
//	public boolean disabled();
//	public boolean selected();
	
}

/*
 * JSON 형식 1
 * 
{
id          : "string" // required
parent      : "string" // required
text        : "string" // node text
icon        : "string" // string for custom
state       : {
 opened    : boolean  // is the node open
 disabled  : boolean  // is the node disabled
 selected  : boolean  // is the node selected
},
li_attr     : {}  // attributes for the generated LI node
a_attr      : {}  // attributes for the generated A node
}
 * 
 * 
 */

/*
 * JSON 형식 2
 * 
$('#using_json_2').jstree({ 'core' : {
    'data' : [
       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
    ]
} });
 * 
 */