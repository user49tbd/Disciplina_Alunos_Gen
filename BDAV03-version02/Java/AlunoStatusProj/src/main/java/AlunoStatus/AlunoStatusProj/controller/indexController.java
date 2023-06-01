package AlunoStatus.AlunoStatusProj.controller;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import AlunoStatus.AlunoStatusProj.persistence.DaoAlunoDisciplina;
@Controller
public class indexController {
	@Autowired
	DaoAlunoDisciplina dad;
	@RequestMapping(name = "index", value = "/index", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("index");
	}
	@RequestMapping(name = "index", value="/index", method = RequestMethod.POST)
	public ModelAndView init(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		try {
			if(allParam.get("btg").equalsIgnoreCase("Gerar Valores")) {
				dad.initDB();
				}
		}catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("index");
	}
}
