package AlunoStatus.AlunoStatusProj.controller;

import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
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

import AlunoStatus.AlunoStatusProj.model.AlunoFaltasModel;
import AlunoStatus.AlunoStatusProj.model.AlunoModel;
import AlunoStatus.AlunoStatusProj.model.DisciplinaModel;
import AlunoStatus.AlunoStatusProj.persistence.DaoAlunoDisciplina;

@Controller
public class IsrFaltasController {
	@Autowired
	DaoAlunoDisciplina dad;
	@RequestMapping(name = "isrFaltas", value = "/isrFaltas", method = RequestMethod.GET)
	public ModelAndView init1(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		List<AlunoModel> alm = new ArrayList<>();
		List<DisciplinaModel> ldt = new ArrayList<>();
		int getA = 0;
		String d = "";
		if(allParam.get("sd") != null) {
		getA = Integer.parseInt(allParam.get("sd"));
		System.out.println(getA);
		}
		LocalDate ld = LocalDate.now();
		int nf = 0;
		if(allParam.get("ipn") != null && !allParam.get("ipn").equalsIgnoreCase("")) {
			nf = Integer.parseInt(allParam.get("ipn"));
		}
		if(allParam.get("dt") != null && !allParam.get("dt").equalsIgnoreCase("")) {
			ld = (Date.valueOf(allParam.get("dt"))).toLocalDate();
			System.out.println(ld);
		}
		String bt = allParam.get("bt");
		if(allParam.get("d") != null) {
			d = allParam.get("d");
				}
		List<LocalDate> lcdt = new ArrayList<>();
		List<AlunoFaltasModel> ldf = new ArrayList<>();
		String turno="";
		try {
			if(bt != null && bt.equalsIgnoreCase("Inserir")){
				dad.isrFaltas(getA, d, ld, nf);
			}
			alm = dad.lam();
			ldt = dad.ListarDisciplina("F");
			turno = dad.getTurno(getA, d);
			lcdt = dad.getDiscDate(d,turno);
			if(d != null && turno != null && !turno.equalsIgnoreCase("")) {
				ldf = dad.ListarFaltasD(d,turno);
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			model.addAttribute("gselec", getA);
			model.addAttribute("alunoM", alm);
			model.addAttribute("ldt", ldt);
			model.addAttribute("dsc", d);
			model.addAttribute("datad", lcdt);
			model.addAttribute("ldf", ldf);
			model.addAttribute("ld", ld);
		}
		return new ModelAndView("isrFaltas");
	}
	@RequestMapping(name = "isrFaltas", value="/isrFaltas", method = RequestMethod.POST)
	public ModelAndView init(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		return new ModelAndView("isrFaltas");
	}
}
