package beans;

public class AdminAccountBean {

String username;
String password;

public AdminAccountBean() {

	username = "";
	password = "";
	
}

public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username=username;
}
public String getPassword() {
	return password;
}
public void setPassword(String psw) {
	this.password=psw;
}


public String toString() {
	return "AdminAccountBean [Username=" + username + ", Password=" + password + "]";
}
}
