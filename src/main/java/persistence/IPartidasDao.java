package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Jogo;

public interface IPartidasDao {

	public String geraPartida() throws SQLException, ClassNotFoundException;
	public List<Jogo> listaPartida(String data) throws SQLException, ClassNotFoundException;
}
