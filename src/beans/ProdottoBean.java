package beans;

import java.io.Serializable;

public class ProdottoBean implements Serializable,Acquistabile {
	private static final long serialVersionUID = 1L;
	
int codice;
String nome;
String ingredienti;
double prezzo;
String tipo; 

public ProdottoBean() {
codice=-1;
nome="";
ingredienti= "";
tipo="";
prezzo=0;
}

public int getCodice() {
	return codice;
}
public void setCodice(int codice){
	this.codice=codice;
}
public String getNome() {
	return nome;
}
public void setNome(String nome) {
	this.nome=nome;
}
public String getComponenti() {
	return ingredienti;
	}
public void setComponenti (String ingredienti) {
this.ingredienti=ingredienti;
}

public String getTipo() {
	return tipo;
}
public void setTipo(String tipo) {
	this.tipo = tipo;
}
public double getPrezzo() {
	return prezzo;
}

public void setPrezzo(double prezzo) {
	this.prezzo=prezzo;
}

public String toString() {
	return "ProdottoBean[Codice=" + codice + ", Nome=" + nome + ", Ingredienti= "
			+ "" + ingredienti + ", Tipo=" + tipo + ",Prezzo=" + prezzo + "]";
}

	
	
	
	
	
	
	
	
	
	
	
	
}




