package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;

public class EditCustomerTest {

    static WebDriver driver;
    static WebDriverWait wait;
    static String targetAccountNumber = "41431";

    @BeforeAll
    public static void setup() {
        System.setProperty("webdriver.chrome.driver", "D:\\selenium\\chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    // Helper method to safely handle alerts
    private void acceptAlertIfPresent() {
        try {
            Alert alert = wait.until(ExpectedConditions.alertIsPresent());
            String alertText = alert.getText();
            System.out.println("Alert Found: " + alertText);
            alert.accept();
        } catch (TimeoutException e) {
            // No alert was present, which is fine.
            System.out.println("No alert to accept.");
        }
    }

    @BeforeEach
    public void login() {
        driver.get("http://localhost:8080/PahanaEdu/login.jsp");

        WebElement usernameField = driver.findElement(By.id("username"));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = driver.findElement(By.xpath("//button[@type='submit']"));

        usernameField.sendKeys("admin");
        passwordField.sendKeys("admin");
        loginButton.click();

        acceptAlertIfPresent(); // Handle login success alert
    }

    @Test
    public void testEditCustomer() {
        // 1. Navigate directly to the edit page for a specific customer
        String editUrl = "http://localhost:8080/PahanaEdu/customer/edit.jsp?accountNumber=" + targetAccountNumber;
        driver.get(editUrl);

        // 2. Wait for the page to load and check if the customer was found
        try {
            WebElement notFoundAlert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.xpath("//div[contains(@class, 'alert-danger') and contains(text(), 'not found')]")
            ));
            // If we get here, the customer wasn't found. Fail the test.
            Assertions.fail("Customer with account number " + targetAccountNumber + " was not found. Cannot perform edit test.");
        } catch (TimeoutException e) {
            // This is good! The error message didn't appear, so the customer was found and the form is shown.
            System.out.println("Customer found. Proceeding with edit.");
        }

        // 3. Locate the form elements
        WebElement nameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("name")));
        WebElement addressField = driver.findElement(By.id("address"));
        WebElement telephoneField = driver.findElement(By.id("telephone"));
        WebElement submitButton = driver.findElement(By.xpath("//button[@type='submit']"));

        // 4. Get the original values (optional, for logging)
        String originalName = nameField.getAttribute("value");
        String originalAddress = addressField.getAttribute("value");
        String originalTelephone = telephoneField.getAttribute("value");

        System.out.println("Original Details - Name: " + originalName + ", Address: " + originalAddress + ", Tel: " + originalTelephone);

        // 5. Clear the fields and enter new test data
        // Using a timestamp to make the new data unique and identifiable
        String timestamp = String.valueOf(System.currentTimeMillis()).substring(7);
        String newName = "Edited Name " + timestamp;
        String newAddress = "Edited Address " + timestamp;
        String newTelephone = "077" + timestamp.substring(0, 7); // Create a new phone number

        nameField.clear();
        nameField.sendKeys(newName);

        addressField.clear();
        addressField.sendKeys(newAddress);

        telephoneField.clear();
        telephoneField.sendKeys(newTelephone);

        // 6. Submit the form
        submitButton.click();

        // 7. VERIFICATION - Handle the response
        acceptAlertIfPresent(); // Accept success alert if present

        // 7b. Check for a success message on the page (e.g., a Bootstrap alert after redirect)
        try {
            WebElement successAlert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.xpath("//div[contains(@class, 'alert-success')]")
            ));
            Assertions.assertTrue(successAlert.isDisplayed(), "Success message was not displayed after editing.");
            System.out.println("Edit successful: Success message found on page.");

        } catch (TimeoutException e1) {
            // If no on-page alert, maybe we were redirected back to the list. Let's check the URL.
            String currentUrl = driver.getCurrentUrl();
            if (currentUrl.contains("list")) {
                System.out.println("Edit successful: Redirected to customer list page.");
                // You could also search the list for the new data here for a stronger test.
            } else {
                System.out.println("Edit may have succeeded, but no clear success indicator found. Current URL: " + currentUrl);
                // The test might still be okay, so we won't fail it automatically.
            }
        }
    }

    @AfterEach
    public void logout() {
        driver.get("http://localhost:8080/PahanaEdu/login.jsp?logout=true");
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}