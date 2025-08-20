package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;
import java.util.List;

public class CustomerListTest {

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

    @BeforeEach
    public void login() {
        driver.get("http://localhost:8080/PahanaEdu/login.jsp");

        WebElement usernameField = driver.findElement(By.id("username"));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = driver.findElement(By.xpath("//button[@type='submit']"));

        usernameField.sendKeys("admin"); // Correct username
        passwordField.sendKeys("admin"); // Correct password
        loginButton.click();

        // Use the safe method to handle the login alert
        acceptAlertIfPresent();
    }

    @Test
    public void testCustomerListPageLoads() {
        // 1. Navigate directly to the Customer List page
        driver.get("http://localhost:8080/PahanaEdu/customer/list");

        // 2. Verify the page title or a key element to confirm it loaded
        WebElement pageTitle = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//h2[contains(text(), 'Customer Accounts')]")
        ));
        Assertions.assertTrue(pageTitle.isDisplayed(), "Customer List page did not load correctly.");

        // 3. Check that the data table is present
        WebElement customerTable = driver.findElement(By.tagName("table"));
        Assertions.assertTrue(customerTable.isDisplayed(), "Customer table is not displayed.");

        // 4. (Optional) Check if the table has rows of data
        // Find all rows in the table body (<tr> tags inside <tbody>)
        List<WebElement> tableRows = driver.findElements(By.cssSelector("table tbody tr"));

        if (tableRows.isEmpty()) {
            // If no rows, check for the "No customers found" message
            WebElement noDataMessage = driver.findElement(By.xpath("//td[contains(text(), 'No customers found')]"));
            Assertions.assertTrue(noDataMessage.isDisplayed(), "Expected 'No customers found' message was not displayed for an empty list.");
            System.out.println("Test passed: Customer list is empty, and the appropriate message is shown.");
        } else {
            // If rows are found, verify that data is displayed in the first row
            WebElement firstAccountNumberCell = tableRows.get(0).findElement(By.xpath("./td[1]")); // First column (Account Number)
            String accountNumber = firstAccountNumberCell.getText();
            Assertions.assertFalse(accountNumber.isEmpty(), "The first customer's account number is empty.");
            System.out.println("Test passed: Customer list loaded with data. First account number: " + accountNumber);

            // Optional: You could also verify other columns or actions links exist
            WebElement editButton = tableRows.get(0).findElement(By.linkText("Edit"));
            WebElement deleteButton = tableRows.get(0).findElement(By.linkText("Delete"));
            Assertions.assertTrue(editButton.isDisplayed() && deleteButton.isDisplayed(), "Action buttons (Edit/Delete) are not displayed for customers.");
        }
    }

    @AfterEach
    public void logout() {
        // Navigate to logout URL
        driver.get("http://localhost:8080/PahanaEdu/login.jsp?logout=true");
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}