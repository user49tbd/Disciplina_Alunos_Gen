package AlunoStatus.AlunoStatusProj.model;

public class AlunoNotasModel {
	private int ra;
	private String nome;
	private double nt1;
	private double nt2;
	private double nt3;
	private double exm;
	private double fnt;
	private String situacao;
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
	public double getNt1() {
		return nt1;
	}
	public void setNt1(double nt1) {
		this.nt1 = nt1;
	}
	public double getNt2() {
		return nt2;
	}
	public void setNt2(double nt2) {
		this.nt2 = nt2;
	}
	public double getNt3() {
		return nt3;
	}
	public void setNt3(double nt3) {
		this.nt3 = nt3;
	}
	public double getExm() {
		return exm;
	}
	public void setExm(double exm) {
		this.exm = exm;
	}
	public double getFnt() {
		return fnt;
	}
	public void setFnt(double fnt) {
		this.fnt = fnt;
	}
	public String getSituacao() {
		return situacao;
	}
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
	@Override
	public String toString() {
		return "AlunoNotasModel [ra=" + ra + ", nome=" + nome + ", nt1=" + nt1 + ", nt2=" + nt2 + ", nt3=" + nt3
				+ ", exm=" + exm + ", fnt=" + fnt + ", situacao=" + situacao + "]";
	}
}
