package br.com.fatecpg.locadora;

import java.util.ArrayList;
import java.util.Date;

public class Price {
    private long id;
    private Date timestamp;
    private double price;

    public Price(long id, Date timestamp, double price) {
        this.id = id;
        this.timestamp = timestamp;
        this.price = price;
    }    
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    public static Double getCurrentPrice() throws Exception{
        String SQL = "SELECT new_price FROM PRICES ORDER BY timestamp desc FETCH FIRST 1 ROWS ONLY";
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        if(list.isEmpty()){
            return null;
        }else{
            Object row[] = list.get(0);
            return (Double)row[0];
        }
    }
    
    public static ArrayList<Price> getPrices() throws Exception{
        String SQL = "SELECT * FROM PRICES";
        ArrayList<Price> prices = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for(int i = 0; i < list.size(); i++){
            Object row[] = list.get(i);
            Price u = new Price((long)row[0], (Date)row[1], (Double)row[2]);
            prices.add(u);
        }
        return prices;
    }
    public static void addPrice(Date date, double price) throws Exception{
        String SQL = "INSERT INTO PRICES VALUES( default, ?, ?)";
        Object parameters[] = {date, price};    
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void removePrice(long id) throws Exception{
        String SQL = "DELETE FROM PRICES WHERE ID = ?";
        Object parameters[] = {id};    
        DatabaseConnector.execute(SQL, parameters);
    }
}
