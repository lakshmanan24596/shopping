<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%
	Class.forName("com.mysql.jdbc.Driver");
 	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/shopping","root","");	
 	Statement stmt = conn.createStatement();
	
 	String selectedType = request.getParameter("selectedType");
 	int limit = Integer.parseInt(request.getParameter("selectedRecords"));
 	int pageNum = Integer.parseInt(request.getParameter("selectedPage"));	
 	int offset = (limit * pageNum) - limit;
 	
 	String value = request.getParameter("selectedSearchValue");
 	if(value == null)
 		value = "";
 		
	String sql = "";
    String output = "";
	
	if(selectedType.equals("product"))
	{	
	 	sql = "select productName, size, color, price, quantity, brandName from product inner join brand on product.brandId = brand.brandId where productName like '" + value + "%' order by productId desc limit " + limit + " offset " + offset + ";";
	 	ResultSet rs = stmt.executeQuery(sql);            
	 	while(rs.next())
	 	{
		 	for(int i=1; i<=6; i++)
		 	{ 	
		 		if(i != 6)
		 			output += rs.getString(i) + ",";
		 		else
		 			output += rs.getString(i);	
	    		}
		 	output += ":";
    		}  
	} 	
	else if(selectedType.equals("brand"))
	{	
	 	sql = "select brandName, categoryName from brand inner join category on brand.categoryId = category.categoryId where brandName like '" + value + "%' order by brandId desc limit " + limit + " offset " + offset + ";";
	 	ResultSet rs = stmt.executeQuery(sql);            
	 	while(rs.next())
	 	{
		 	for(int i=1; i<=2; i++)
		 	{ 	
		 		if(i != 2)
		 			output += rs.getString(i) + ",";
		 		else
		 			output += rs.getString(i);
		 	}
		 	output += ":";
    		}  	  
	}	
	else if(selectedType.equals("category"))
	{	
		sql = "select categoryName, segmentName from category inner join segment on category.segmentId = segment.segmentId where categoryName like '" + value + "%' order by categoryId desc limit " + limit + " offset " + offset + ";";
		ResultSet rs = stmt.executeQuery(sql);            
	 	while(rs.next())
	 	{
		 	for(int i=1; i<=2; i++)
		 	{ 	
		 		if(i != 2)
	        			output += rs.getString(i) + ",";
		 		else
		 			output += rs.getString(i);
	    		}
		 	output += ":";
    		}
	}	
	else if(selectedType.equals("segment"))
	{	
		sql = "select segmentName from segment where segmentName like '" + value + "%'  order by segmentId desc limit " + limit + " offset " + offset + ";";
		ResultSet rs = stmt.executeQuery(sql);            
	 	while(rs.next())
	 	{
	 		output += rs.getString(1) + ":";		 		
    		}
	}	
   stmt.close();
   conn.close();
	   
   if(!output.equals(""))
    		output = output.substring(0, output.length() - 1);
   out.println(output); 
%>

