package AlunoStatus.AlunoStatusProj.model;

import java.util.List;

public class AlunoFaltasModel {
	private int ra;
	private String nome;
	private List<String> faltas;
	private int totalF;
	private int lmtF;
	
	public int getLmtF() {
		return lmtF;
	}
	public void setLmtF(int lmtF) {
		this.lmtF = lmtF;
	}
	public int getRa() {
		return ra;
	}
	public void setRa(int ra) {
		this.ra = ra;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public List<String> getFaltas() {
		return faltas;
	}
	public void setFaltas(List<String> faltas) {
		this.faltas = faltas;
	}
	public int getTotalF() {
		return totalF;
	}
	public void setTotalF(int totalF) {
		this.totalF = totalF;
	}
	@Override
	public String toString() {
		return "AlunoFaltasModel [ra=" + ra + ", nome=" + nome + ", faltas=" + faltas + ", totalF=" + totalF + ", lmtF="
				+ lmtF + "]";
	}
	
	
}
