//Simple core-java program for otp verification 

import javax.mail.Authenticator;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
//import sun.util.logging.PlatformLogger;

public class Mailing {

    public static void sendMail(String recepient, String otp) throws MessagingException {
        System.out.println("Preparing to send mail");
        Properties properties = new Properties();

        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        String myAccountEmail = "beardyboy0401@gmail.com";
        String password = "shriNATH0401";

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(myAccountEmail, password);
            }
        });
        Message message = prepareMessage(session, myAccountEmail, recepient, otp);

        Transport.send(message);
        System.out.println("Message sent successfully!");
    }

    private static Message prepareMessage(Session session, String myAccountEmail, String recepient, String otp) throws MessagingException {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(myAccountEmail));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
        message.setSubject("First mail from Java!");
        message.setText("Your One time password is: " + otp);
        return message;
    }
}
