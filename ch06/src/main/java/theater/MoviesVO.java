package theater;

public class MoviesVO {

	private int movie_id;
	private String title;
	private String genre;
	private String release_date;
	
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRelease_date() {
		return release_date;
	}
	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}
	
	@Override
	public String toString() {
		return "MoviesVO [movie_id=" + movie_id + ", title=" + title + ", genre=" + genre + ", release_date="
				+ release_date + "]";
	}
	
}
