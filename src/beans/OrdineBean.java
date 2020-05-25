package beans;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.OrdineModel;

public class OrdineBean {
int codice;
double prezzo;
String usernameCliente;
List <Acquistabile> arrayProdotti;


public OrdineBean() {
	codice = 0;
	prezzo=0;
	usernameCliente= "";
	arrayProdotti= new ArrayList<Acquistabile>();
}
public int getCodice() {
	return codice;
	
}
public void setCodice(int codice) {
	this.codice=codice;
}

public int assegnaCodice() throws SQLException {
OrdineModel model =new OrdineModel("pizzeria", "root", "root");
return model.assegnaCodice();
}

public String getUsernameCliente() {
	return usernameCliente;
}
public void setUsernameCliente( String usernameCliente) {
	this.usernameCliente=usernameCliente;
}

public double getPrezzo() {
	return prezzo;
}

public ArrayList<Acquistabile> getProdottiOrdine(){
	return (ArrayList<Acquistabile>) arrayProdotti;
}

public void addProdotto(Acquistabile prodotto) {
	arrayProdotti.add(prodotto);
	prezzo+=prodotto.getPrezzo();
}
public void removeAll() {
	for(int i=0;i<arrayProdotti.size();i++) {
		arrayProdotti.remove(i);
	}
	prezzo=0;
}
public String toString() {
	return "OrdineBean[Codice=" + codice + ", Username Cliente=" + usernameCliente + "Prezzo= "+prezzo+ "Array= "+arrayProdotti.toString() +  "]";
}

public void setArray(List<Acquistabile> array) {
	arrayProdotti=array;
	if(arrayProdotti!=null)
	for(int i=0;i<arrayProdotti.size();i++) {
		prezzo=arrayProdotti.get(i).getPrezzo();
	}
}

public void deleteProduct (Acquistabile prodotto) {
	for(int i=0;i<arrayProdotti.size();i++) {
		if(arrayProdotti.get(i).getCodice()==prodotto.getCodice()) {
			prezzo-=arrayProdotti.get(i).getPrezzo();
			arrayProdotti.remove(i);
		}
	}
	



}




}
