<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.model.ProductBean,it.unisa.model.Cart"%>
 <%
 	Collection<?> products = (Collection<?>) request.getAttribute("products");
 
 	String error = (String)request.getAttribute("error");
 	
 	if(products == null && error == null) {
 		response.sendRedirect(response.encodeRedirectURL("./ProductControl"));
 		return;
 	}
 	
 	Cart<ProductBean> cart = (Cart<ProductBean>)request.getAttribute("cart");
	
 	if(cart == null) {
 		response.sendRedirect(response.encodeRedirectURL("./ProductControl"));
 		return;
 	}	
 	
 	ProductBean product = (ProductBean) request.getAttribute("product");
 %>   
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="Style1.css" rel="stylesheet" type="text/css">
	<title>StoreDemo</title>
</head>
<body>
<h1>StoreDemo</h1>
<h2>Cart</h2>
<%
	List<ProductBean> prodcart = cart.getItems();

	if(prodcart.size() > 0) {
%>
	<a href="<%=response.encodeURL("ProductControl?action=clearCart")%>">Clear</a>
	<a href="">Buy</a>
<%  } %>
<table>
	<tr>
		<th>Name</th>
		<th>Action</th>
	</tr>	
	<%
		if(prodcart.size() > 0) {
			for(ProductBean prod: prodcart) {
	%>
			<tr>
				<td><%=prod.getName()%></td>
				<td><a href="<%=response.encodeURL("ProductControl?action=deleteCart&id=" + prod.getCode())%>">Delete from cart</a>
			</tr>
	<% 		}
		} else {
	%>
		<tr><td colspan="2">No product available in the cart</td></tr>
	<%
		}
	%>
</table>


<h2>Products</h2>
<table>
	<tr>
		<th>Code <a href="<%=response.encodeURL("ProductControl?sort=code")%>">Sort</a></th>
		<th>Name <a href="<%=response.encodeURL("ProductControl?sort=name")%>">Sort</a></th>
		<th>Description <a href="<%=response.encodeURL("ProductControl?sort=description")%>">Sort</a></th>
		<th>Action</th>
	</tr>
	<%
		if(products != null && products.size() > 0) {
			
			Iterator<?> it  = products.iterator();
			while(it.hasNext()) {
				ProductBean bean = (ProductBean)it.next();	
	%>
			<tr>
				<td><%=bean.getCode()%></td>
				<td><%=bean.getName()%></td>
				<td><%=bean.getDescription()%></td>
				<td>
					<a href="<%=response.encodeURL("ProductControl?action=details&id=" + bean.getCode())%>">Details</a>
					<a href="<%=response.encodeURL("ProductControl?action=delete&id=" + bean.getCode())%>">Delete</a>
					<a href="<%=response.encodeURL("ProductControl?action=addCart&id=" + bean.getCode())%>">Add to cart</a>
				</td>
			</tr>
	<% 		} 
	 	} else { %>
	<tr>
		<td colspan="4">No product available</td>
	</tr>	
	<% } %>
</table>

	<%
		if(product != null && !product.isEmpty()) {
	%>
		<h2>Deatils</h2>
		<table>
			<tr>
				<th>Code</th>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
				<th>Quantity</th>
			</tr>
			<tr>
				<td><%=product.getCode()%></td>
				<td><%=product.getName()%></td>
				<td><%=product.getDescription()%></td>
				<td><%=product.getPrice()%></td>
				<td><%=product.getQuantity()%></td>
			</tr>
		</table>
		
		<form action="<%=response.encodeURL("ProductControl")%>" method="POST">
			<fieldset>
				<legend><b>Update</b></legend>
				<input type="hidden" name="action" value="update">
				<input type="hidden" name="id" value="<%=product.getCode()%>">
				
				<label for="name">Name:</label><br>
				<input name="name" type="text" maxlength="20" placeholder="enter name" required value="<%=product.getName()%>"><br>
				
				<label for="description">Description:</label><br>
				<textarea name="description" maxlength="100" rows="3" placeholder="enter description" required><%=product.getDescription()%></textarea><br>
				
				<label for="price">Price:</label><br>
				<input name="price" type="number" min="0" required value="<%=product.getPrice()%>"><br>
				
				<label for="quantity">Quantity:</label><br>
				<input name="quantity" type="number" min="1" required value="<%=product.getQuantity()%>"><br>		
				
				<input type="submit" value="Update">
				<input type="reset" value="Reset">
			</fieldset>
		</form>		
		
		
	<%  } %>

<%
	String message = (String)request.getAttribute("message");
	if(message != null && !message.equals("")) {
%>
	<p style="color: green;"><%=message %></p>
<%
	}
	if(error != null && !error.equals("")) {
%>
	<p style="color: red;">Error: <%= error%></p>
<%
	}
%>	

<form action="<%=response.encodeURL("ProductControl")%>" method="POST">
	<fieldset>
		<legend><b>Insert</b></legend>
		<input type="hidden" name="action" value="insert">
		
		<label for="name">Name:</label><br>
		<input name="name" type="text" maxlength="20" placeholder="enter name" required><br>
		
		<label for="description">Description:</label><br>
		<textarea name="description" maxlength="100" rows="3" placeholder="enter description" required></textarea><br>
		
		<label for="price">Price:</label><br>
		<input name="price" type="number" min="0" value="0" required><br>
		
		<label for="quantity">Quantity:</label><br>
		<input name="quantity" type="number" min="1" value="1" required><br>		
		
		<input type="submit" value="Insert">
		<input type="reset" value="Reset">
	</fieldset>
</form>























</body>
</html>