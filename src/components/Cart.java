package components;

import java.util.ArrayList;
import java.util.List;

import beans.Acquistabile;
import beans.OffertaBean;
import beans.ProdottoBean;

public class Cart {
	private List<Acquistabile> prodotto;
	
	public Cart() {
		prodotto = new ArrayList<Acquistabile>();
	}
	
	public void addProduct(Acquistabile product) {
		prodotto.add(product);
	}
	

	public void deleteProduct(Acquistabile product) {
		for(Acquistabile prod : prodotto) {
			if(prod.getCodice() == product.getCodice()) {
				prodotto.remove(prod);
				break;
			}
		}
 	}
	
	public void deleteAll() {
		prodotto.clear();
	}
	

	public List<Acquistabile> getProducts() {
		return  prodotto;
	}
	
}
