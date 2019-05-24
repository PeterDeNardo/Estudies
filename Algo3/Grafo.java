
public class Grafo {
    private int V; // número de vértices
    private int A; // número de arestas
    private int adj[][]; // matriz de adjcência

    // inicializa os atributos da classe e cria a 
    // matriz de adjacência para V vértices
    public Grafo( int V ){
        this.V = V;
        this.A = 0; // nao tenho nenhuma aresta
        // criar a matriz de adjacencia
        adj = new int[V][V];
    }
    /*
    Método insere uma aresta v-w no grafo. O método supõe 
    que v e w são distintos, positivos e menores que V. 
    Se o grafo já tem aresta v-w, o método não faz nada, 
    após a inserção da aresta, o atributo A da classe é 
    atualizado.
    */
    public void insereA( int v, int w){
        if(this.adj[v][w]==0){
            this.adj[v][w]=1;
            this.A++;
        }
    }
    /*
    Para cada vértice v do grafo, este método imprime, 
    em uma linha, todos os vértices adjacentes a v. 
    */
    public void mostra( ){
        for( int v=0; v < this.V; v++){
            System.out.print(v+":");
            for( int w=0; w < this.V; w++){
                if( this.adj[v][w]==1)
                    System.out.print(" "+w);
                    
            }
            System.out.println();
        }
    }
    // calcula o grau de entrada de um vértice
    public int indeg( int v ){
        int grauEntrada = 0;
        for( int i=0; i < this.V; i++)
            grauEntrada+=this.adj[i][v];
        
        return grauEntrada;
            
    }

    public void teste() {
        for(int i =1; i<=adj.length; i++){
            for(int j =1;j<=adj[0].length; j++){
                System.out.print(this.adj[i][j]);
            }
            System.out.println();
        }
    }
}
