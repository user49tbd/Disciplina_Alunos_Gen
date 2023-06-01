package AlunoStatus.AlunoStatusProj.controller;

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
import AlunoStatus.AlunoStatusProj.model.AlunoNotasModel;
import AlunoStatus.AlunoStatusProj.model.DisciplinaModel;
import AlunoStatus.AlunoStatusProj.persistence.DaoAlunoDisciplina;


@Controller
public class statusFaltasController {
	@Autowired
	DaoAlunoDisciplina dad;
	
	
	
	@RequestMapping(name = "statusFaltas", value = "/statusFaltas", method = RequestMethod.GET)
	public ModelAndView init1(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		List<AlunoFaltasModel> ldf = new ArrayList<>();
		List<AlunoNotasModel> ldn = new ArrayList<>();
		List<DisciplinaModel> ld = new ArrayList<>();
		List<DisciplinaModel> ldt = new ArrayList<>();
		List<LocalDate> lcdt = new ArrayList<>();
		String listdisc = allParam.get("sd");
		String listturn = allParam.get("sdt");
		String btBusc = allParam.get("btBusc");
		String btBuscN = allParam.get("btBuscN");
		System.out.println("Selected");
		System.out.println(listdisc);
		try {
			ld = dad.ListarDisciplina("T");
			ldt = dad.ListarDisciplina("F");
			if(btBusc != null && btBusc.equalsIgnoreCase("Buscar Faltas")) {
				if(listdisc != null && listturn != null) {
					ldf = dad.ListarFaltasD(listdisc,listturn);
					lcdt = dad.getDiscDate(listdisc,listturn);
				}
			}
			if(btBuscN != null && btBuscN.equalsIgnoreCase("Buscar Notas")) {
				if(listdisc != null && listturn != null) {
					ldn = dad.ListarNotasD(listdisc,listturn);
					//ldf = dad.ListarFaltasD(listdisc,listturn);
					//lcdt = dad.getDiscDate(listdisc,listturn);
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			System.out.println("-------------->"+ld.get(0).getTpav());
			model.addAttribute("ld", ld);
			model.addAttribute("ldt", ldt);
			model.addAttribute("ldf", ldf);
			model.addAttribute("ldslc", listdisc);
			model.addAttribute("notas", ldn);
			model.addAttribute("datad", lcdt);
		}
		return new ModelAndView("statusFaltas");
	}
	@RequestMapping(name = "statusFaltas", value="/statusFaltas", method = RequestMethod.POST)
	public ModelAndView init(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		return new ModelAndView("statusFaltas");
	}
}
