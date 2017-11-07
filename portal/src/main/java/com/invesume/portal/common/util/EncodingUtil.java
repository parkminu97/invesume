package com.invesume.portal.common.util;


import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class EncodingUtil {
    private StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
    
    public EncodingUtil() {
        pbeEnc.setAlgorithm("PBEWithMD5AndDES");
        pbeEnc.setPassword("SAMPLE");
    }
    
    public String encrypt(String data) {
        return pbeEnc.encrypt(data);
    }
    
    public String decrypt(String data) {
        return pbeEnc.decrypt(data);
    }
    
    public static void main(String[] args) throws Exception {
        EncodingUtil eu = new EncodingUtil();
        String guest = "guest";
        
        String database_name = "admin";
        String database_name2 = "SoftwithExtranet";
        String database_username = "cross";
        String database_password = "~cross007";
        String database_port = "11121";
        String web_ip = "192.168.1.194";
        String web_port = "8082";
        String web_contextpath = "/crossnet_ap";
        String server_port = "1000";
        String mail_userName = "";
        String mail_password = "";
        String root_dir = "/usr/local/homepage_files/";
        String api_key = "NCS55AC394A0094C";
        String api_secret = "4i2bg9MIAMmnUXXQbArBcA==";

        System.out.println("api_key:" + eu.encrypt(api_key));
        System.out.println("api_secret:" + eu.decrypt(api_secret));
        
        System.out.println("enc_guest:" + eu.encrypt(guest));
        System.out.println("enc_database_name:" + eu.encrypt(database_name));
        System.out.println("enc_database_name2:" + eu.encrypt(database_name2));
        System.out.println("enc_database_username:" + eu.encrypt(database_username));
        System.out.println("enc_database_password:" + eu.encrypt(database_password));
        System.out.println("enc_database_port:" + eu.encrypt(database_port));
        System.out.println("enc_mail_userName:" + eu.encrypt(mail_userName));
        System.out.println("enc_mail_password:" + eu.encrypt(mail_password));
        System.out.println("enc_web_ip:" + eu.encrypt(web_ip));
        System.out.println("enc_web_port:" + eu.encrypt(web_port));
        System.out.println("enc_web_contextpath:" + eu.encrypt(web_contextpath));
        System.out.println("enc_server_port:" + eu.encrypt(server_port));
        System.out.println("enc_root_dir:" + eu.encrypt(root_dir));

    }
}