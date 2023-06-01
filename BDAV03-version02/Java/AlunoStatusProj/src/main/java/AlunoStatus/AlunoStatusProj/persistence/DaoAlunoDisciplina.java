package AlunoStatus.AlunoStatusProj.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import AlunoStatus.AlunoStatusProj.model.AlunoFaltasModel;
import AlunoStatus.AlunoStatusProj.model.AlunoModel;
import AlunoStatus.AlunoStatusProj.model.AlunoNotasModel;
import AlunoStatus.AlunoStatusProj.model.DisciplinaModel;

@Repository
public class DaoAlunoDisciplina {
	@Autowired
	GenericDao gd;
	
	public List<DisciplinaModel> ListarDisciplina(String uni) throws ClassNotFoundException, SQLException{
		Connection c = gd.getC();
		String sql = "SELECT CODIGO,NOME,SIGLA,TURNO,NUM_AULAS,TB.CODIGO_AVALIACAO FROM DISCIPLINA D INNER JOIN TBDISCAV TB ON "
				+ "TB.CODIGO_DISCIPLINA = D.CODIGO";
		if(uni == "T") {
			sql = "SELECT DISTINCT NOME,SIGLA,NUM_AULAS,TB.CODIGO_AVALIACAO FROM DISCIPLINA D INNER JOIN TBDISCAV TB ON "
					+ "TB.CODIGO_DISCIPLINA = D.CODIGO";
		}
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<DisciplinaModel> lafm = new ArrayList<>();
		while(rs.next()) {
			DisciplinaModel dm = new DisciplinaModel();
			if(uni != "T") {
				dm.setCodigo(rs.getInt("CODIGO"));
				dm.setTurno(rs.getString("TURNO"));
			}
			dm.setNome(rs.getString("NOME"));
			dm.setSigla(rs.getString("SIGLA"));
			dm.setNumeroAulas(rs.getInt("NUM_AULAS"));
			dm.setTpav(rs.getInt("CODIGO_AVALIACAO"));
			lafm.add(dm);
		}
		rs.close();
		c.close();
		return lafm;
	}
	public List<AlunoNotasModel> ListarNotasD(String nd, String p) throws ClassNotFoundException, SQLException{
		Connection c = gd.getC();
		StringBuffer sb1 = new StringBuffer();
		sb1.append("SELECT RA,NOME,NOTA1,NOTA2,NOTA3,EXAME,NOTA,SITUACAO ");
		sb1.append("FROM dbo.EXB_STATUSC(?,?)");
		PreparedStatement ps = c.prepareStatement(sb1.toString());
		ps.setString(1, nd);
		ps.setString(2, p);
		ResultSet rs = ps.executeQuery();
		List<AlunoNotasModel> lanm = new ArrayList<>();
		while(rs.next()) {
			AlunoNotasModel anm = new AlunoNotasModel();
			anm.setRa(rs.getInt("RA"));
			anm.setNome(rs.getString("NOME"));
			anm.setNt1(rs.getDouble("NOTA1"));
			anm.setNt2(rs.getDouble("NOTA2"));
			anm.setNt3(rs.getDouble("NOTA3"));
			anm.setExm(rs.getDouble("EXAME"));
			anm.setFnt(rs.getDouble("NOTA"));
			anm.setSituacao(rs.getString("SITUACAO"));
			lanm.add(anm);
			}
		rs.close();
		c.close();
		return lanm;
	}
	public List<LocalDate> getDiscDate(String nd, String p) throws ClassNotFoundException, SQLException{
		Connection c = gd.getC();
		StringBuffer sb1 = new StringBuffer();
		sb1.append("SELECT DISTINCT F.DATA FROM FALTAS F INNER JOIN DISCIPLINA D ");
		sb1.append("ON D.CODIGO = F.CODIGO_DISCIPLINA WHERE D.NOME = ? AND D.TURNO = ? ");
		PreparedStatement ps = c.prepareStatement(sb1.toString());
		ps.setString(1, nd);
		ps.setString(2, p);
		ResultSet rs = ps.executeQuery();
		List<LocalDate> ld = new ArrayList<>();
		while(rs.next()) {
			ld.add(rs.getDate("DATA").toLocalDate());
		}
		return ld;
		
	}
	public List<AlunoModel> lam() throws ClassNotFoundException, SQLException{
		Connection c = gd.getC();
		String sql = "SELECT RA,NOME,DISC FROM dbo.ALUNODT ()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<AlunoModel> alm = new ArrayList<>();
		String[] ls;
		List<String> ds;
		while(rs.next()) {
			//ds.clear();
			ds = new ArrayList<>();
			AlunoModel am= new AlunoModel();
			am.setRa(rs.getInt("RA"));
			am.setNome(rs.getString("NOME"));
			ls  = rs.getString("DISC").split("@");
			for(String a : ls) {
				//System.out.println(a);
				ds.add(a);
			}
			am.setDisciplinas(ds);
			alm.add(am);
		}
		return alm;
	}
	public String getTurno(int i ,String discN) throws ClassNotFoundException, SQLException{
		Connection c = gd.getC();
		StringBuffer sb1 = new StringBuffer();
		sb1.append("SELECT D.TURNO FROM MATRICULA M INNER JOIN DISCIPLINA D ");
		sb1.append("ON D.CODIGO = M.CODIGO_DISCIPLINA INNER JOIN ALUNO AL ON M.RA_ALUNO = AL.RA ");
		sb1.append("WHERE AL.RA = ? AND D.NOME=? ");
		PreparedStatement ps = c.prepareStatement(sb1.toString());
		ps.setInt(1, i);
		ps.setString(2, discN);
		ResultSet rs = ps.executeQuery();
		String t = "";
		if(rs.next()) {
			t = rs.getString("TURNO");
		}
		return t;
	}
	public void IsrNotas(int ra,double nt1,double nt2,double nt3,String disci) throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql = "EXEC ISR_NOTA ?,?,?,?,?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setDouble(1, nt1);
		ps.setDouble(2, nt2);
		ps.setDouble(3, nt3);
		ps.setInt(4, ra);
		ps.setString(5, disci);
		ps.execute();
		ps.close();
		c.close();
	}
	public void isrMat(int ra,double nt1,double nt2,double nt3,String disci) throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql = "CALL UPDMAT ?,?,?,?,?";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, ra);
		cs.setString(2, disci);
		cs.setDouble(3, nt1);
		cs.setDouble(4, nt2);
		cs.setDouble(5, nt3);
		cs.execute();
		cs.close();
		c.close();
	}
	public void IsrExm(int ra,String disci,double exm) throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql = "EXEC ISR_EXAME ?,?,?";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, ra);
		cs.setString(2, disci);
		cs.setDouble(3, exm);
		cs.execute();
		cs.close();
		c.close();
	}
	public List<AlunoFaltasModel> ListarFaltasD(String nd, String p) throws ClassNotFoundException, SQLException{
		Connection c = gd.getC();
		String sql = "SELECT RA,NOME,FALTAS,TOTF,LMTF  FROM dbo.EXB_FALT (?,?,'V')";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, nd);
		ps.setString(2, p);
		ResultSet rs = ps.executeQuery();
		List<AlunoFaltasModel> lafm = new ArrayList<>();
		//List<String> lstf = new ArrayList<>();
		String[] ls;
		String sqf;
		while(rs.next()) {
			List<String> lstf = new ArrayList<>();
			AlunoFaltasModel afm = new AlunoFaltasModel();
			afm.setRa(rs.getInt("RA"));
			afm.setNome(rs.getString("NOME"));
			afm.setTotalF(rs.getInt("TOTF"));
			afm.setLmtF(rs.getInt("LMTF"));
			sqf = rs.getString("FALTAS");
			ls = sqf.split(" ");
			System.out.println("comeco da list faltas");
			for(String a : ls) {
				//System.out.println(a);
				lstf.add(a);
			}
			afm.setFaltas(lstf);
			lafm.add(afm);
			}
		rs.close();
		c.close();
		return lafm;
	}
	public List<AlunoNotasModel> getANotas() throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql="SELECT RA,DISC,NT1,NT2,NT3,EXM,MED,SITUACAO FROM dbo.ALUNOTS ()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<AlunoNotasModel> ls = new ArrayList<>();
		while(rs.next()) {
			AlunoNotasModel anm = new AlunoNotasModel();
			anm.setRa(rs.getInt("RA"));
			anm.setNome(rs.getString("DISC"));
			anm.setNt1(rs.getDouble("NT1"));
			anm.setNt2(rs.getDouble("NT2"));
			anm.setNt3(rs.getDouble("NT3"));
			anm.setExm(rs.getDouble("EXM"));
			anm.setFnt(rs.getDouble("MED"));
			anm.setSituacao(rs.getString("SITUACAO"));
			ls.add(anm);
		}
		return ls;
		
	}
	public void isrFaltas (int ra, String disciplina,LocalDate ld,int fault ) throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql="EXEC ISR_FALTAS ?,?,?,?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, ra);
		ps.setString(2, disciplina);
		ps.setDate(3, Date.valueOf(ld));
		ps.setInt(4, fault);
		ps.execute();
		ps.close();
		c.close();
	}
	public void clear(int ra, String disciplina) throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql="EXEC CLEARP ?,?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, ra);
		ps.setString(2, disciplina);
		ps.execute();
		ps.close();
		c.close();
	}
	public void initDB() throws ClassNotFoundException, SQLException {
		Connection c = gd.getC();
		String sql="EXEC INITIAL";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.execute();
		ps.close();
		c.close();
	}
}
