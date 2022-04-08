package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Grupo;
import model.Time;

public class GrupoDao implements IGrupoDao {

	private GenericDao gDao;

	public GrupoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String separaGrupos() throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();

		String sql = "CALL sp_separa_grupos (?)";
		CallableStatement cs = con.prepareCall(sql);
		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(1);
		
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public List<Grupo> listaGrupos() throws SQLException, ClassNotFoundException {
		List<Grupo> grupos  = new ArrayList<Grupo>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM grupos");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			t.setNomeTime(rs.getString("time"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			
			Grupo g = new Grupo();
			g.setTime(t);
			g.setGrupo(rs.getString("grupo"));
			
			grupos.add(g);
		}
		return grupos;
	}

	@Override
	public List<Grupo> listaGrupo(String letra) throws SQLException, ClassNotFoundException {
List<Grupo> grupos = new ArrayList<Grupo>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM grupos WHERE grupo = ? ";
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, letra);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			t.setNomeTime(rs.getString("time"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			
			Grupo g = new Grupo();
			g.setTime(t);
			g.setGrupo(rs.getString("grupo"));
			
			grupos.add(g);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return grupos;
	}

}