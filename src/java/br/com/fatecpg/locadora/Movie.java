package br.com.fatecpg.locadora;

import java.util.ArrayList;
import java.util.Date;

public class Movie {
    private long id;
    private String genre;
    private String name;
    private Date release;
    private String stock;

    public Movie(long id, String genre, String name, Date release, String stock) {
        this.id = id;
        this.genre = genre;
        this.name = name;
        this.release = release;
        this.stock = stock;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getRelease() {
        return release;
    }

    public void setRelease(Date release) {
        this.release = release;
    }
    
    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }
    
     public static ArrayList<Movie> getMovies() throws Exception{
        String SQL = "SELECT * FROM MOVIES";
        ArrayList<Movie> movies = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        
       for(int i=0; i<list.size();i++){
            Object row[] = list.get(i);
            Movie u = new Movie(
                      (long) row[0]
                    , (String)row[1]
                    , (String)row[2]
                    , (Date)row[3]
                    , (String)row[4]);
            movies.add(u);
        }
        return movies;
    }
    public static void addMovie(String name, String genre, Date release, String stock)
           throws Exception{
        String SQL = "INSERT INTO MOVIES VALUES("
                +"default"
                +", ?"
                +", ?"
                +", ?"
                +", ?"
                +")";

        Object parameters[] = {genre, name, release, stock};
        DatabaseConnector.execute(SQL, parameters);
    }
        public static void removeMovie(long id)
           throws Exception{
        String SQL = "DELETE FROM MOVIES WHERE ID =?";
        Object parameters[] = {id};
        DatabaseConnector.execute(SQL, parameters);
    }
}
