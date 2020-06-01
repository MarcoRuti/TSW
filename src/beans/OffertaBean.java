package beans;

import java.util.ArrayList;
import java.util.List;

public class OffertaBean implements Acquistabile{
    int codice;
    double prezzo;
    List<ProductBean> arrayProdotti;
    String data_inizio;
    String data_fine;



    public OffertaBean() {
        codice = 0;
        prezzo= 0;
        data_inizio = "";
        data_fine = "";
        arrayProdotti = new ArrayList<ProductBean>();
    }

    public void addProdotto(ProductBean prodotto) {
        arrayProdotti.add ( prodotto);
    }

    public void setArrayProdotti(ArrayList<ProductBean> array) {
        arrayProdotti=array;
    }

    public ArrayList<ProductBean> getProdottiInOfferta(){
        return (ArrayList<ProductBean>) arrayProdotti;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo=prezzo;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public int getCodice() {
        return codice;
    }
    public void setCodice(int codice) {
        this.codice=codice;
    }
    public String getDataInizio() {
        return data_inizio;
    }
    public void setDataInizio(String dataInizio) {
        this.data_inizio=dataInizio;
    }

    public String getDataFine() {
        return data_fine;

    }
    public void setDataFine(String dataFine) {
        this.data_fine=dataFine;
    }

    public String toString() {
        return "OffertaBean [Codice=" + codice + ", Data inizio=" + data_inizio + ", Data fine=" + data_fine +"Prezzo= "+prezzo+"Componenti="+arrayProdotti+ "]";

    }

    public String getNome() {
        String nome=""+codice;
        return nome;
    }
    public String getDescrizione() {
        String p="";
        for(int i=0;i<arrayProdotti.size();i++) {
            p+=arrayProdotti.get(i).getNome()+" ";
        }
        return p;
    }


    public void setNome(String nome) {

    }

    public void setDescrizione(String componenti) {

    }


}
