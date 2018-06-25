package br.com.fatecpg.locadora;

import java.util.ArrayList;
import java.util.Date;

public class Leased {
    private long id;
    private String name;
    private String client;
    private Date begins;
    private Date end;
    private double price;

    public Leased(long id, String name, String client, Date begins) {
        this.id = id;
        this.name = name;
        this.client = client;
        this.begins = begins;
    }

    public Leased(long id, String name, String client, Date begins, Date end, double price) {
        this.id = id;
        this.name = name;
        this.client = client;
        this.begins = begins;
        this.end = end;
        this.price = price;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public Date getBegins() {
        return begins;
    }

    public void setBegins(Date begins) {
        this.begins = begins;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    public static Leased getLeased(long id) throws Exception{
        String SQL = "SELECT * FROM LEASED_MOVIES WHERE ID = ?";
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{id});
        if(list.isEmpty()){
            return null;
        }else{
            Object row[] = list.get(0);
            Leased l = new Leased((long)row[0], (String)row[1], (String)row[2], (Date)row[3]);
            return l;
        }
    }
    
    public static ArrayList<Leased> getLeaseds() throws Exception{
        String SQL = "SELECT * FROM LEASED_MOVIES WHERE END_PERIOD IS NULL ORDER BY BEGIN_PERIOD";
        ArrayList<Leased> periods = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for(int i = 0; i < list.size(); i++){
            Object row[] = list.get(i);
            Leased p = new Leased((long)row[0], (String)row[1], (String)row[2], (Date)row[3]);
            periods.add(p);
        }
        return periods;
    }
    
    public static void addLeased(String name, String client) throws Exception{
        String SQL = "INSERT INTO LEASED_MOVIES VALUES(default, ?, ?, ?, null, null)";
        Object parameters[] = {name, client, new Date()};    
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void finishLeased(long id, double price) throws Exception{
        String SQL = "UPDATE LEASED_MOVIES SET END_PERIOD = ?, PRICE = ? WHERE ID = ?";
        Date now = new Date();
        Object parameters[] = {new Date(), price, id};    
        DatabaseConnector.execute(SQL, parameters);
    }
}
