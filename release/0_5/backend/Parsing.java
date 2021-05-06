import java.util.*;
import java.io.*;

public class Parsing{
    static results result = new results(); // result class
    static ArrayList<String> col_status = new ArrayList<String> ();
    static ArrayList<String> cur = new ArrayList<String> ();
    static String temp;
    static String arr[];
    static boolean starts = false;
    static String json = null;

    static class results{
        int total_count;
        GPU gpu;
        KERNEL kernel;
        CPU cpu;
        DtoH dtoh;
        HtoD htod;
        String json;

        results(){
            total_count = 0;
            gpu = new GPU();
            kernel = new KERNEL();
            cpu = new CPU();
            dtoh = new DtoH();
            htod = new HtoD();
        }
        String printStatus(){
            kernel.get_Total();
            dtoh.get_Total();
            htod.get_Total();
            json = "{" +
                "\"TotalCounts\":" + Integer.toString(this.total_count) +
                ",\"GpupageFaultsGroups\":" + Integer.toString(gpu.getGpu_page_faults_groups()) + 
                ",\"GpupageFaults\":" + Integer.toString(gpu.getGpu_page_faults()) + 
                ",\"KernelCounts\":" + Integer.toString(kernel.getKernelCounts()) + 
                ",\"KernelTime\":" + Double.toString(kernel.getKernelTime()) + 
                ",\"DtoHTime\":" + Double.toString(dtoh.getTotal()) + 
                ",\"HtoDTime\":" + Double.toString(htod.getTotal()) +
                "}";
            return json;
        }
    }
    static class GPU{
        int GPU_count;
        int GPU_page_faults;
        void show_status(){
            System.out.println("GPU page Faults groups : " + GPU_count);
            System.out.println("GPU page Faults : " + GPU_page_faults);
        }
        int getGpu_page_faults_groups(){
            return this.GPU_count;
        }
        int getGpu_page_faults(){
            return this.GPU_page_faults;
        }
    }

    static class KERNEL{
        ArrayList<String> time = new ArrayList<String>();
        double Total_time;
        int count;
        void show_status(){
            get_Total();
            System.out.println("KERNEL Counts : " + count);
            System.out.println("KERNEL Time : " + Total_time);
        }
        int getKernelCounts(){
            return count;
        }
        double getKernelTime(){
            return Total_time;
        }
        void get_Total(){
            double t = 0;
            for(int i = 0; i<count; i++){
                if(time.get(i).contains("ms")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"ms");
                    t = Double.parseDouble(tst.nextToken());
                }
                else if(time.get(i).contains("us")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"us");
                    t = Double.parseDouble(tst.nextToken()) / 1000;
                }
                else if(time.get(i).contains("ns")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"ns");
                    t = Double.parseDouble(tst.nextToken()) / 1000000;
                }
                else{
                    System.out.println("KERNEL Total() err");
                    return;
                }
                Total_time += t;
            }
        }
    }

    static class CPU{

    }

    static class DtoH{
        int count;
        ArrayList<String> time = new ArrayList<String>();
        double Total_time;

        void show_status(){
            get_Total();
            System.out.println("DtoH Time : " + Total_time);
        }
        double getTotal(){
            return Total_time;
        }
        void get_Total(){
            double t = 0;
            for(int i = 0; i<count; i++){
                if(time.get(i).contains("ms")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"ms");
                    t = Double.parseDouble(tst.nextToken());
                }
                else if(time.get(i).contains("us")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"us");
                    t = Double.parseDouble(tst.nextToken()) / 1000;
                }
                else if(time.get(i).contains("ns")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"ns");
                    t = Double.parseDouble(tst.nextToken()) / 1000000;
                }
                else{
                    System.out.println("DtoH Total() err");
                    return;
                }
                Total_time += t;
            }
        }
    }

    static class HtoD{
        int count;
        ArrayList<String> time = new ArrayList<String>();
        double Total_time;

        void show_status(){
            get_Total();
            System.out.println("HtoD Time : " + Total_time);
        }
        
        double getTotal(){
            return Total_time;
        }

        void get_Total(){
            double t = 0;
            for(int i = 0; i<count; i++){
                if(time.get(i).contains("ms")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"ms");
                    t = Double.parseDouble(tst.nextToken());
                }
                else if(time.get(i).contains("us")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"us");
                    t = Double.parseDouble(tst.nextToken()) / 1000;
                }
                else if(time.get(i).contains("ns")){
                    StringTokenizer tst = new StringTokenizer(time.get(i),"ns");
                    t = Double.parseDouble(tst.nextToken()) / 1000000;
                }
                else{
                    System.out.println("HtoD Total() err");
                    return;
                }
                Total_time += t;
            }
        }
    }
    static String getJson(){
        return json;
    }

    public static void main(String[] argc){
        try {
            File files = new File("./SF1_Qnum1.log");
            BufferedReader br = new BufferedReader(new FileReader(files));
            while((temp = br.readLine()) != null){

                if(starts){
                    result.total_count++;
                    arr = temp.split("  ");
                    cur = new ArrayList<String> ();
                    for(int k = 0; k < arr.length; k++){
                        if(!arr[k].equals(""))
                            cur.add(arr[k].trim());
                    }
                    if(cur.size() == 0){ // result: 가 올때까지 Parsing X
                        result.total_count--;
                        starts = false;
                        continue;
                    }

                    if(cur.get(cur.size()-1).contains("CPU")){
                        //System.out.println("CPU");
                    }
                    else if(cur.get(cur.size() - 1).contains("GPU")){
                        result.gpu.GPU_page_faults += Integer.parseInt(cur.get(10));
                        result.gpu.GPU_count++;
                    }
                    else if(cur.get(cur.size() - 1).contains("DtoH")){
                        result.dtoh.time.add(cur.get(1));
                        result.dtoh.count++;
                    }
                    else if(cur.get(cur.size() - 1).contains("HtoD")){
                        result.htod.time.add(cur.get(1));
                        result.htod.count++;
                    }
                    else if(cur.get(cur.size() - 1).contains("kern") | cur.get(cur.size() - 1).contains("hash") ){
                        result.kernel.time.add(cur.get(1));
                        result.kernel.count++;
                    }
                    else{
                       //System.out.println(temp); //Memory page thrash
                    }
                }

                if(temp.contains("result:") && !starts) { // parsing start
                    starts = true;
                    temp = br.readLine();
                    arr = temp.split("  ");
                    for(int k = 0; k<arr.length; k++){
                        if(!arr[k].equals(""))
                            col_status.add(arr[k]);
                    }
                }
            }
            br.close();
        }
        catch (FileNotFoundException e){ System.out.println(e); }
        catch(IOException e){ System.out.println(e); }
        json = result.printStatus();
        System.out.println(getJson());
    }
}
