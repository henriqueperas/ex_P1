package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Jogo;

public class PartidasDao implements IPartidasDao {

	private GenericDao gDao;

	public PartidasDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String geraPartida() throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();

		String sql = "CALL sp_cria_partidas (?)";
		CallableStatement cs = con.prepareCall(sql);
		cs.execute();

		String saida = cs.getString(1);

		cs.close();
		con.close();
		return saida;
	}

	@Override
	public List<Jogo> listaPartida(String data) throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();

		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM jogos ORDER BY data_jogo";
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, data);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Jogo j = new Jogo();
			j.setTime1(rs.getString("time1"));
			j.setTime2(rs.getString("time2"));
			j.setGolsTime1(rs.getInt("golsTime1"));
			j.setGolsTime2(rs.getInt("golsTime2"));
			j.setDataJogo(rs.getString("data"));

			jogos.add(j);
		}
		return jogos;
	}

}