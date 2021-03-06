package com.grupo6.service.bean;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.grupo6.config.TenantContext;
import com.grupo6.persistence.model.Entrada;
import com.grupo6.persistence.model.Espectaculo;
import com.grupo6.persistence.model.RealizacionEspectaculo;
import com.grupo6.persistence.model.Sector;
import com.grupo6.persistence.model.SuscripcionEspectaculo;
import com.grupo6.persistence.model.TipoEspectaculo;
import com.grupo6.persistence.model.Usuario;
import com.grupo6.persistence.repository.EntradaRepository;
import com.grupo6.persistence.repository.EspectaculoRepository;
import com.grupo6.persistence.repository.RealizacionEspectaculoRepository;
import com.grupo6.persistence.repository.SectorRepository;
import com.grupo6.persistence.repository.SuscripcionEspectaculoRepository;
import com.grupo6.persistence.repository.TipoEspectaculoRepository;
import com.grupo6.persistence.repository.UsuarioRepository;
import com.grupo6.rest.dto.EspectaculoConTealizacionesDTO;
import com.grupo6.rest.dto.EspectaculoDTO;
import com.grupo6.rest.dto.EspectaculoFullDTO;
import com.grupo6.rest.dto.EspectaculoUsuarioDTO;
import com.grupo6.rest.dto.RealizacionEspectaculoDTO;
import com.grupo6.rest.dto.RealizacionEspectaculoUsuarioDTO;
import com.grupo6.rest.dto.SectorDTO;
import com.grupo6.rest.dto.TipoEspectaculoDTO;
import com.grupo6.service.EspectaculoService;

@Service
public class EspectaculoServiceBean implements EspectaculoService {

	@Value("${imagenesPath}")
	private String imagenesPath;

	@Autowired
	private EspectaculoRepository espectaculoRepository;

	@Autowired
	private SectorRepository sectorRepository;

	@Autowired
	private EntradaRepository entradaRepository;

	@Autowired
	private TipoEspectaculoRepository tipoEspectaculoRepository;

	@Autowired
	private SuscripcionEspectaculoRepository suscripcionEspectaculoRepository;

	@Autowired
	private UsuarioRepository usuarioRepository;

	@Autowired
	private RealizacionEspectaculoRepository realizacionEspectaculoRepository;

	@Override
	public void agregarEspectaculo(EspectaculoDTO espectaculo) {

		Espectaculo e = new Espectaculo();
		e.setDescripcion(espectaculo.getDescripcion());
		e.setNombre(espectaculo.getNombre());
		for (TipoEspectaculoDTO te : espectaculo.getTipoEspectaculo()) {
			Optional<TipoEspectaculo> tE = tipoEspectaculoRepository.findOne(te.getId());
			e.getTipoEspectaculo().add(tE.get());
		}
		espectaculoRepository.save(e);
	}

	@Override
	public void modificarEspectaculo(EspectaculoDTO espDTO) {
		Espectaculo esp = new Espectaculo();
		esp.setDescripcion(espDTO.getDescripcion());
		esp.setId(espDTO.getId());
		esp.setNombre(espDTO.getNombre());
		for (TipoEspectaculoDTO te : espDTO.getTipoEspectaculo()) {
			Optional<TipoEspectaculo> tE = tipoEspectaculoRepository.findOne(te.getId());
			esp.getTipoEspectaculo().add(tE.get());
		}
		espectaculoRepository.save(esp);
	}

	@Override
	public List<EspectaculoDTO> obtenerEspectaculos() {
		List<EspectaculoDTO> lDTO = new ArrayList<EspectaculoDTO>();

		espectaculoRepository.findAll().forEach(x -> {
			EspectaculoDTO eDTO = new EspectaculoDTO(x);
			lDTO.add(eDTO);
		});
		return lDTO.stream().distinct().collect(Collectors.toList());
	}

	@Override
	public Page<Espectaculo> findAll(Pageable pageRequest) {
		return this.espectaculoRepository.findAll(pageRequest);
	}

	@Override
	public Page<Espectaculo> findAll(Specification<Espectaculo> entradaSpecification, Pageable pageRequest) {
		return this.espectaculoRepository.findAll(entradaSpecification, pageRequest);

	}

	@Override
	public Page<Espectaculo> findAll(Pageable pageRequest, String busqueda) {
		Date d = new Date();
		return this.espectaculoRepository.findAllWithSearh(pageRequest, busqueda, d);
	}

	@Override
	public Page<Espectaculo> findAllActivos(Pageable pageRequest) {
		Date d = new Date();
		return this.espectaculoRepository.findAllActivos(pageRequest, d);
	}

	@Override
	public List<Espectaculo> findAll() {
		Date d = new Date();
		return this.espectaculoRepository.findAllActivos(d);
	}

	@Override
	public void desSuscribirseTipoEspectaculo(Long idTipoEspectaculo, String email) {
		Usuario u = usuarioRepository.findByEmail(email).get();
		TipoEspectaculo te = tipoEspectaculoRepository.findOne(idTipoEspectaculo).get();
		Optional<SuscripcionEspectaculo> se = suscripcionEspectaculoRepository.findByUsuarioAndTipoEspectaculo(u, te);
		if (se.isPresent()) {
			suscripcionEspectaculoRepository.delete(se.get());
		} else {
			// no existia la suscripcion
		}

	}

	@Override
	@Transactional
	public void suscribirseTipoEspectaculo(Long idTipoEspectaculo, String email) {
		Usuario u = usuarioRepository.findByEmail(email).get();
		TipoEspectaculo te = tipoEspectaculoRepository.findOne(idTipoEspectaculo).get();
		Optional<SuscripcionEspectaculo> se = suscripcionEspectaculoRepository.findByUsuarioAndTipoEspectaculo(u, te);
		if (!se.isPresent()) {
			SuscripcionEspectaculo s = new SuscripcionEspectaculo();
			s.setTipoEspectaculo(te);
			s.setUsuario(u);
			s.setFecha(new Date());
			suscripcionEspectaculoRepository.save(s);
		} else {
			// ya existe la suscripción no hago nada
		}

	}

	@Override
	public void desSuscribirseAEspectaculo(Long idEspectaculo, String email) {
		Usuario u = usuarioRepository.findByEmail(email).get();
		Espectaculo e = espectaculoRepository.findOne(idEspectaculo).get();
		Optional<SuscripcionEspectaculo> se = suscripcionEspectaculoRepository.findByUsuarioAndEspectaculo(u, e);
		if (se.isPresent()) {
			suscripcionEspectaculoRepository.delete(se.get());
		} else {
			// no existia la suscripcion
		}

	}

	@Override
	public void suscribirseAEspectaculo(Long idEspectaculo, String email) {
		Usuario u = usuarioRepository.findByEmail(email).get();
		Espectaculo e = espectaculoRepository.findOne(idEspectaculo).get();
		Optional<SuscripcionEspectaculo> se = suscripcionEspectaculoRepository.findByUsuarioAndEspectaculo(u, e);
		if (!se.isPresent()) {
			SuscripcionEspectaculo s = new SuscripcionEspectaculo();
			s.setUsuario(u);
			s.setEspectaculo(e);
			s.setFecha(new Date());
			suscripcionEspectaculoRepository.save(s);
		} else {
			// ya existia la suscripcion
		}

	}

	@Override
	public List<EspectaculoFullDTO> obtenerEspectaculosSugeridosOsuario(String email) {
		// TODO si se suscribio a un Espectaculo se le va a mostrar todas las
		// futuras realizaciones de ese espectaculo si se suscribió a una
		// realizacion de un espectaculo solo se le va a mostrar la realizacion
		// a la que se suscribio si se susbribió a un tipo de espectaculo se le
		// va a mostrar espectaculos de ese tipo con sus realizaciones. El orden
		// es el siguiente: suscripcion a una realizacion suscripcion a un
		// espectaculo suscripcion a un tipo de espectaculo

		// Junto todas las realizaciones de espectaculo ordenadas las paso a set
		// para sacar las repetidas las agrupo por espectaculo y ahi contruyo
		// EspectaculoFullDTO para retornar
		Optional<Usuario> user = usuarioRepository.findByEmail(email);
		List<SuscripcionEspectaculo> suscLuist = suscripcionEspectaculoRepository.findByUsuario(user.get());
		List<EspectaculoFullDTO> ret = new ArrayList<EspectaculoFullDTO>();
		List<RealizacionEspectaculo> realEspectList = new ArrayList<RealizacionEspectaculo>();

		// filtramos por los tres tipos de suscripcion que tenemos
		suscLuist.stream().filter(x -> x.getRealizacionEspectaculo() != null).forEach(suscEsp -> {

			realEspectList
					.add(realizacionEspectaculoRepository.findOne(suscEsp.getRealizacionEspectaculo().getId()).get());
		});
		suscLuist.stream().filter(x -> x.getEspectaculo() != null).forEach(espec -> {
			realEspectList.addAll(realizacionEspectaculoRepository
					.findByEspectaculoAndFechaAfter(espec.getEspectaculo(), new Date()));
		});

		suscLuist.stream().filter(x -> x.getTipoEspectaculo() != null).forEach(tipoEspec -> {

			List<Espectaculo> espectList = espectaculoRepository.finBytipoEspectaculo(tipoEspec.getId(), new Date());
			for (Espectaculo esp : espectList) {
				realEspectList.addAll(realizacionEspectaculoRepository.findByEspectaculoAndFechaAfter(esp, new Date()));
			}

		});
		// elemino las realizaciones repetidas si las hubiera
		Set<RealizacionEspectaculo> hs = new HashSet<>();
		hs.addAll(realEspectList);
		realEspectList.clear();
		realEspectList.addAll(hs);
		for (RealizacionEspectaculo re : realEspectList) {
			Espectaculo esp = re.getEspectaculo();
			Espectaculo espect = (espectaculoRepository.findOneActive(esp.getId(), new Date()));
			if (espect != null) {
				EspectaculoFullDTO espectFullDTO = new EspectaculoFullDTO(espect);
				ret.add(espectFullDTO);
			}

		}
		Set<EspectaculoFullDTO> espectFullDTOHash = new HashSet<EspectaculoFullDTO>();
		espectFullDTOHash.addAll(ret);
		ret.clear();
		ret.addAll(espectFullDTOHash);
		return ret;

	}

	@Override
	@Transactional
	public EspectaculoConTealizacionesDTO FindOne(String id) {
		Espectaculo esp = espectaculoRepository.findOneActive(Long.parseLong(id), new Date());
		if (esp == null) {
			return null;
		} else {
			EspectaculoConTealizacionesDTO ret = new EspectaculoConTealizacionesDTO(esp);
			ret.setRealizacionEspectaculo(new ArrayList<RealizacionEspectaculoDTO>());
			List<RealizacionEspectaculo> list = this.realizacionEspectaculoRepository.findByEspectaculoAndFechaAfter(
					espectaculoRepository.findOne(Long.parseLong(id)).get(), new Date());
			list.stream().forEach(x -> {
				RealizacionEspectaculoDTO respDTO = new RealizacionEspectaculoDTO(x);
				List<Sector> sectores = sectorRepository.findBySalaId(x.getSala().getId());
				sectores.stream().forEach(sec -> {
					Optional<Entrada> ent = entradaRepository.findByRealizacionEspectaculoAndSector(x, sec).findFirst();

					SectorDTO sectorDTO = new SectorDTO();
					if (ent.isPresent()) {
						sectorDTO.setPrecio(ent.get().getPrecio());
					}
					sectorDTO.setCapacidad(sec.getCapacidad());
					sectorDTO.setId(sec.getId());
					sectorDTO.setNombre(sec.getNombre());
					respDTO.getSectores().add(sectorDTO);

				});

				ret.getRealizacionEspectaculo().add(respDTO);

			});
			return ret;
		}

	}

	@Override
	public List<EspectaculoUsuarioDTO> obtenerEspectaculosOsuario(String email) {
		List<EspectaculoUsuarioDTO> ret = new ArrayList<EspectaculoUsuarioDTO>();

		Optional<Usuario> user = usuarioRepository.findByEmail(email);
		List<Entrada> entradas = entradaRepository.findByUsuario(user.get());
		entradas.stream().forEach(entrada -> {
			RealizacionEspectaculo re = entrada.getRealizacionEspectaculo();
			if (re.getFecha().after(new Date())) {
				EspectaculoUsuarioDTO esp = new EspectaculoUsuarioDTO(re.getEspectaculo());
				RealizacionEspectaculoUsuarioDTO reso = new RealizacionEspectaculoUsuarioDTO(re);
				esp.setIdAsiento(entrada.getNumeroAsiento());
				esp.setRealizacionEspectaculo(reso);
				ret.add(esp);
				Optional<Sector> sec = sectorRepository.findOne(entrada.getSector().getId());
				SectorDTO sectorDTO = new SectorDTO();
				sectorDTO.setPrecio(entrada.getPrecio());
				sectorDTO.setCapacidad(sec.get().getCapacidad());
				sectorDTO.setId(sec.get().getId());
				sectorDTO.setNombre(sec.get().getNombre());
				reso.setSector(sectorDTO);

			}
		});
		return ret;

	}
	
	@Override
	public  List<byte[]> obtenerImagenesEspectaculo(Long espetactuloId){
		
		String tenantName = (String)TenantContext.getCurrentTenant();
		String pathImagen = imagenesPath + "\\" + tenantName + "\\" + String.valueOf(espetactuloId) + "\\";
		File[] files = Paths.get(pathImagen).toFile().listFiles();
		List <byte[]> ret = new ArrayList<byte[]>();
		if (files ==null){
			return null;
		}
		for(File f: files){
			Path path = Paths.get(f.getAbsolutePath());
			byte[] data;
			try {
				data = Files.readAllBytes(path);
				ret.add(data);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return ret;
		
	}

	@Override
	public List<Espectaculo> findAllHoy() {
		Date ahora = new Date();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		Date maniana = cal.getTime();
		return this.espectaculoRepository.findAllHoy(ahora, maniana);
	}
 
}
