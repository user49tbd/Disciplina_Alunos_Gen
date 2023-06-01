package AlunoStatus.AlunoStatusProj.model;

public class DisciplinaModel {
	private int codigo;
	private String nome;
	private String sigla;
	private String turno;
	private int numeroAulas;
	private int tpav;
	
	
	
	public int getTpav() {
		return tpav;
	}
	public void setTpav(int tpav) {
		this.tpav = tpav;
	}
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getSigla() {
		return sigla;
	}
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}
	public String getTurno() {
		return turno;
	}
	public void setTurno(String turno) {
		this.turno = turno;
	}
	public int getNumeroAulas() {
		return numeroAulas;
	}
	public void setNumeroAulas(int numeroAulas) {
		this.numeroAulas = numeroAulas;
	}
	@Override
	public String toString() {
		return "DisciplinaModel [codigo=" + codigo + ", nome=" + nome + ", sigla=" + sigla + ", turno=" + turno
				+ ", numeroAulas=" + numeroAulas + ", tpav=" + tpav + "]";
	}
	
	
}
