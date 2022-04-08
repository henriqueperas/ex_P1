package model;

public class Jogo {
	private int codigoJogo;
	private String time1;
	private String time2;
	private int golsTime1;
	private int golsTime2;
	private String dataJogo;
	public int getCodigoJogo() {
		return codigoJogo;
	}
	public void setCodigoJogo(int codigoJogo) {
		this.codigoJogo = codigoJogo;
	}
	public String getTime1() {
		return time1;
	}
	public void setTime1(String time1) {
		this.time1 = time1;
	}
	public String getTime2() {
		return time2;
	}
	public void setTime2(String time2) {
		this.time2 = time2;
	}
	public int getGolsTime1() {
		return golsTime1;
	}
	public void setGolsTime1(int golsTime1) {
		this.golsTime1 = golsTime1;
	}
	public int getGolsTime2() {
		return golsTime2;
	}
	public void setGolsTime2(int golsTime2) {
		this.golsTime2 = golsTime2;
	}
	public String getDataJogo() {
		return dataJogo;
	}
	public void setDataJogo(String dataJogo) {
		this.dataJogo = dataJogo;
	}
	@Override
	public String toString() {
		return "Jogo [codigoJogo=" + codigoJogo + ", time1=" + time1 + ", time2=" + time2 + ", golsTime1=" + golsTime1
				+ ", golsTime2=" + golsTime2 + ", dataJogo=" + dataJogo + "]";
	}
}