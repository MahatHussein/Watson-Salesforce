public class ContentItemsJSON{
	
	public List<ContentItem> contentItems;
	
	public class ContentItem {
		public String id;	//245160944223793152
		public String userid;	//bob
		public String sourceid;	//twitter
		public Integer created;	//1427720427
		public Integer updated;	//1427720427
		public String contenttype;	//text/plain
		public String charset;	//UTF-8
		public String language;	//en-us
		public String content;	//This is a sample tweet
		public String parentid;	//
		public boolean reply;
		public boolean forward;
		
	}
	
	public static ContentItemsJSON parse(String json){
		return (ContentItemsJSON) System.JSON.deserialize(json, ContentItemsJSON.class);
	}
}