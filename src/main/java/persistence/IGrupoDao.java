package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Grupo;

public interface IGrupoDao {
	
	public String separaGrupos() throws SQLException, ClassNotFoundException;
	public List<Grupo> listaGrupos() throws SQLException, ClassNotFoundException;
	public List<Grupo> listaGrupo(String letra) throws SQLException, ClassNotFoundException;
}
