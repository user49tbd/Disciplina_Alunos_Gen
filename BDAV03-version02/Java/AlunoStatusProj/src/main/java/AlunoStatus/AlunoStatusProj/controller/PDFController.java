package AlunoStatus.AlunoStatusProj.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
//import java.sql.Date;
import java.sql.SQLException;
//import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

//import AlunoStatus.AlunoStatusProj.model.AlunoFaltasModel;
//import AlunoStatus.AlunoStatusProj.model.AlunoModel;
//import AlunoStatus.AlunoStatusProj.model.AlunoNotasModel;
import AlunoStatus.AlunoStatusProj.model.DisciplinaModel;
import AlunoStatus.AlunoStatusProj.persistence.DaoAlunoDisciplina;
import AlunoStatus.AlunoStatusProj.persistence.GenericDao;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class PDFController {
	@Autowired
	DaoAlunoDisciplina dad;
	
	@Autowired
	GenericDao gd;
	
	
	//String listdisc;
	//String listturn;
	List<DisciplinaModel> ld;
	List<DisciplinaModel> ldt;
	@RequestMapping(name = "GenPDF", value = "/GenPDF", method = RequestMethod.GET)
	public ModelAndView init1(ModelMap model, @RequestParam Map<String,String>
	allParam) {
		ld = new ArrayList<>();
		ldt = new ArrayList<>();
		String listdisc = allParam.get("sd");
		//String listturn = allParam.get("sdt");
		try {
			ld = dad.ListarDisciplina("T");
			ldt = dad.ListarDisciplina("F");
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			System.out.println("-------------->"+ld.get(0).getTpav());
			model.addAttribute("ld", ld);
			model.addAttribute("ldt", ldt);
			model.addAttribute("ldslc", listdisc);
		}
		return new ModelAndView("GenPDF");
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(name = "GenPDF",value = "/GenPDF",method = RequestMethod.POST)
	public ResponseEntity geraR(@RequestParam Map<String,String> allRequestParam) {
		
		
		String err= "";
		
		String listdisc = allRequestParam.get("discL");
		String listturn = allRequestParam.get("sdt");
		String btN = allRequestParam.get("bt");
		String btF = allRequestParam.get("bt");
		
		Map<String,Object> param = new HashMap<String,Object>();
		if(btF.equalsIgnoreCase("Gerar Relatorio Faltas")) {
			param.put("disc", listdisc);
			param.put("t", listturn);
		}
		else{
			param.put("DISC", listdisc);
			param.put("TURN", listturn);
		}
		System.out.println("iinserted");
		System.out.println(listdisc);
		System.out.println(listturn);
		//param.put("cid", cid);
		//param.put("data", dt);
		
		byte [] bytes = null;
		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();
		
		
		
		File arquivo=null;
		System.out.println("-----------------------------------HereB29");
		try {
			Connection conn = gd.getC();
			if(btN != null && btN.equalsIgnoreCase("Gerar Relatorio Notas")) {
				arquivo = ResourceUtils.getFile("classpath:Notas.jasper");
				System.out.println("Notas");
			}
			if(btF != null && btF.equalsIgnoreCase("Gerar Relatorio Faltas")) {
				//arquivo = ResourceUtils.getFile("classpath:repFaltas.jasper");
				arquivo = ResourceUtils.getFile("classpath:daP1.jasper");
				System.out.println("Faltas");
			}
			System.out.println("-----------------------------------Here@");
			JasperReport report = 
					(JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report,param, conn);
		} catch (FileNotFoundException | JRException | ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			err = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if(err.equals("")) {
				InputStream is = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(is);
				header.setContentLength(bytes.length);
				header.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}
		
		return new ResponseEntity(resource,header,status);
		
	}
}
