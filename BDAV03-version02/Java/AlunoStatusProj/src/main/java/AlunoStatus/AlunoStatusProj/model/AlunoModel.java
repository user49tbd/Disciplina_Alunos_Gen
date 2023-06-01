package AlunoStatus.AlunoStatusProj.model;

import java.util.List;

public class AlunoModel {
	private int	ra;
	private String nome;
	private List<String> disciplinas;
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getRa() {
		return ra;
	}
	public void setRa(int ra) {
		this.ra = ra;
	}
	
	public List<String> getDisciplinas() {
		return disciplinas;
	}
	public void setDisciplinas(List<String> disciplinas) {
		this.disciplinas = disciplinas;
	}
	@Override
	public String toString() {
		return "AlunoModel [ra=" + ra + ", nome=" + nome + ", disciplinas=" + disciplinas + "]";
	}
	
}
