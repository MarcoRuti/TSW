package beans;

public class ClienteBean {
    String username;
    String nome;
    String cognome;
    String password;


    public ClienteBean() {
        username = "";
        nome = "";
        cognome = "";
        password = "";
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String user) {
        this.username=user;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome=nome;
    }
    public String getCognome() {
        return cognome;
    }
    public void setCognome(String cognome) {
        this.cognome=cognome;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String psw) {
        this.password=psw;
    }
    public String toString() {
        return "ClienteBean[Username=" + username + ", Nome=" + nome + ", Cognome=" + cognome + ", Password=" + password + "]";



    }
}
