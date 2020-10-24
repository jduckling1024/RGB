package dto;

public class UserDTO {
	String id;
	String password;
	String name;
	int autority;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getAutority() {
		return autority;
	}
	
	public void setAutority(int autority) {
		this.autority = autority;
	}
}
