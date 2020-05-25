package beans;

public class LocaleBean {
	
String nome;
int codice;
int cap;
String citta;
String telefono;
String via;


public LocaleBean() {
	codice = 0;
	nome = "";
	cap = 0;
	citta = "";
	telefono ="";
	via = "";
}

public int getCodice() {
	return codice;
}

public void setCodice(int codice) {
	this.codice = codice;
}

public String getNome() {
	return nome;
}

public void setNome(String nome) {
	this.nome = nome;
}

public String getVia() {
	return via;
}

public void setVia(String via) {
	this.via = via;
}

public String getCitta() {
	return citta;
}

public void setCitta(String citta) {
	this.citta = citta;
}

public int getCap() {
	return cap;
}

public void setCap(int cap) {
	this.cap = cap;
}

public String getTelefono() {
	return telefono;
}

public void setTelefono(String telefono) {
	this.telefono = telefono;
}

public String toString() {
	return "LocaleBean [Codice=" + codice + ", Nome=" + nome + ", Via=" + via + ", Citta=" + citta + ", Cap=" + cap
			+ ", Telefono="+ telefono + "]";
}
}
