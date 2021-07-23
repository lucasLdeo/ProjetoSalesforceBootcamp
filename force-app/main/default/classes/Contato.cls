public virtual class Contato {
    
    private String nome;
    private String email;
    
    public Contato(String nome, string email){
        this.nome = nome;
        this.email = email;
    }
    
    public void informaDados(){
        
        System.debug('>>> nome ::'+ this.nome);
        System.debug('>>> email ::'+ this.email);
    }
    public static void mostrarTodosContatos(List<Contato> contatos){
        for (Contato personagem : contatos){
            System.debug('>>> personagem ::'+personagem);
        }        
    }
}