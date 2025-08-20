package test;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement; // <- This is the correct import
import org.openqa.selenium.chrome.ChromeDriver;
import org.junit.jupiter.api.*;

import java.time.Duration;

public class LoginTest {

    static WebDriver driver;

    @BeforeAll
    public static void setup() {
        System.setProperty("webdriver.chrome.driver", "D:\\selenium\\chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
    }

    @Test
    public void testSuccessfulLogin() {
        driver.get("http://localhost:8080/PahanaEdu/login.jsp");



        WebElement usernameField = driver.findElement(By.id("username"));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = driver.findElement(By.id("loginButton"));

        usernameField.sendKeys("admin");
        passwordField.sendKeys("admin");
        loginButton.click();

        driver.switchTo().alert().accept(); //

        String currentUrl = driver.getCurrentUrl();
        Assertions.assertTrue(currentUrl.contains("dashboard.jsp"), "Login failed! Not redirected to dashboard.");
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}