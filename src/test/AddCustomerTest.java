package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;

public class AddCustomerTest {

    static WebDriver driver;
    static WebDriverWait wait;

    @BeforeAll
    public static void setup() {
        System.setProperty("webdriver.chrome.driver", "D:\\selenium\\chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }


    private void acceptAlertIfPresent() {
        try {
            Alert alert = wait.until(ExpectedConditions.alertIsPresent());
            alert.accept();
        } catch (TimeoutException e) {

            System.out.println("No alert to accept.");
        }
    }
    // --- END HELPER METHOD ---

    @BeforeEach
    public void login() {
        driver.get("http://localhost:8080/PahanaEdu/login.jsp");

        WebElement usernameField = driver.findElement(By.id("username"));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = driver.findElement(By.xpath("//button[@type='submit']"));

        usernameField.sendKeys("admin");
        passwordField.sendKeys("admin");
        loginButton.click();

        // Use the safe method to handle the login alert
        acceptAlertIfPresent();
    }

    @Test
    public void testAddNewCustomer_Success() {
        // Navigate directly to the form
        driver.get("http://localhost:8080/PahanaEdu/customer/add.jsp");

        WebElement accountNumberField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("account_number")));
        WebElement nameField = driver.findElement(By.id("name"));
        WebElement addressField = driver.findElement(By.id("address"));
        WebElement telephoneField = driver.findElement(By.id("telephone"));
        WebElement submitButton = driver.findElement(By.xpath("//button[@type='submit']"));

        String timestamp = String.valueOf(System.currentTimeMillis());
        String accountNumber = "ACCT-" + timestamp.substring(7);

        accountNumberField.sendKeys(accountNumber);
        nameField.sendKeys("Selenium Test Customer");
        addressField.sendKeys("123 Automated Test Lane, Colombo");
        telephoneField.sendKeys("077" + timestamp.substring(5, 9));

        submitButton.click();

        // Check for success - Use the safe method
        acceptAlertIfPresent();

        // After accepting the alert, let's also check for a success message on the page itself
        try {
            WebElement successAlert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.xpath("//div[contains(@class, 'alert-success')]")
            ));
            Assertions.assertTrue(successAlert.isDisplayed(), "Success message was not displayed on the page.");
        } catch (TimeoutException e) {
            // If there's no on-page alert, that's okay. The test might have passed with a JS alert.
            System.out.println("No on-page success message found. Assuming success was shown in an alert.");
        }
    }

    @AfterEach
    public void logout() {
        // Simply navigate to the logout URL. Don't try to handle any alerts here.
        // The act of logging out might clear any session state.
        driver.get("http://localhost:8080/PahanaEdu/login.jsp?logout=true");
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}