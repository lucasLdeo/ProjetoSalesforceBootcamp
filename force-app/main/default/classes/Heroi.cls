public class Heroi extends Contato  {
    
    public String habilidade;
    public String nomeDeHeroi;
    
    public Heroi(String nomeDeHeroi,String habilidade){
        super(nomeDeHeroi + 'Malvadão', nomeDeHeroi.replace(' ','')+'@email.com');
        this.habilidade = habilidade;
        this.nomeDeHeroi = nomeDeHeroi;
    }

}