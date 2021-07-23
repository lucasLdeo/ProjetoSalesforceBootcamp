public class Vilao extends Contato {
	public String nomeDeVilao;
    public String hablidades;
    public Vilao(String nomeDeVilao, String hablidades ){
        super(nomeDeVilao + 'Malvadão', nomeDeVilao.replace(' ','')+'@email.com');
        this.nomeDeVilao = nomeDeVilao;
        this.hablidades = hablidades;
    }
    
}