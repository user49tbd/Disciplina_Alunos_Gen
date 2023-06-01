package AlunoStatus.AlunoStatusProj.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import AlunoStatus.AlunoStatusProj.model.AlunoModel;
import AlunoStatus.AlunoStatusProj.model.AlunoNotasModel;
import AlunoStatus.AlunoStatusProj.model.DisciplinaModel;
import AlunoStatus.AlunoStatusProj.persistence.DaoAlunoDisciplina;

@Controller
public class IsrNotaController {
	@Autowired
	DaoAlunoDisciplina dad;
	
	@RequestMapping(name = "isrNota", value = "/isrNota", method = RequestMethod.GET)
	public ModelAndView init1(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		int getA = 0;
		String d = "";
		if(allParam.get("sd") != null) {
		getA = Integer.parseInt(allParam.get("sd"));
		System.out.println(getA);
		}
		if(allParam.get("d") != null) {
		d = allParam.get("d");
			}
		List<AlunoModel> alm = new ArrayList<>();
		List<DisciplinaModel> ldt = new ArrayList<>();
		List<AlunoNotasModel> alunoNotasM = new ArrayList<>();
		double nt1=0,nt2=0,nt3=0,ex=0;
		String bt1=allParam.get("bt1");
		try {
			if(bt1 != null) {
				try {
					nt1 = Double.parseDouble(allParam.get("ntt1"));
					nt2 = Double.parseDouble(allParam.get("ntt2"));
					nt3 = Double.parseDouble(allParam.get("ntt3"));
				}
				finally {
					
				}
				ex = Double.parseDouble(allParam.get("ntt4"));
				if(bt1.equalsIgnoreCase("Clear")) {
					System.out.println("CODIGO: "+getA+" - "+"DISCIPLINA "+d);
					dad.clear(getA, d);
				}
				if(bt1.equalsIgnoreCase("Inserir Nota")) {	
					dad.isrMat(getA, nt1, nt2, nt3, d);		
				}
				if(bt1.equalsIgnoreCase("Inserir Exame")) {
					dad.IsrExm(getA, d, ex);
				}
				if(bt1.equalsIgnoreCase("Calcular Media")) {
					dad.IsrNotas(getA, nt1, nt2, nt3, d);
				}
				}
			alm = dad.lam();
			//System.out.println(alm.get(0).getDisciplinas().get(0));
			//System.out.println(alm.get(1).getDisciplinas().get(0));
			ldt = dad.ListarDisciplina("F");
			alunoNotasM = dad.getANotas();
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			model.addAttribute("gselec", getA);
			model.addAttribute("dsc", d);
			model.addAttribute("alunoM", alm);
			model.addAttribute("ldt", ldt);
			model.addAttribute("alunoNotasM", alunoNotasM);
		}
		return new ModelAndView("isrNota");
	}
	@RequestMapping(name = "isrNota", value="/isrNota", method = RequestMethod.POST)
	public ModelAndView init(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		return new ModelAndView("isrNota");
	}
}
