package beans;

import java.io.Serializable;

public class ProductBean implements Serializable,Acquistabile {
    private static final long serialVersionUID = 1L;

    int codice;
    String nome;
    String descrizione;
    double prezzo;
    String tipo;

    public ProductBean() {
        codice=-1;
        nome="";
        descrizione = "";
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
    public String getDescrizione() {
        return descrizione;
    }
    public void setDescrizione(String descrizione) {
        this.descrizione =descrizione;
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
                + "" + descrizione + ", Tipo=" + tipo + ",Prezzo=" + prezzo + "]";
    }













}


