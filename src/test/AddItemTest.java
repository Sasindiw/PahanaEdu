package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;

public class AddItemTest {

    static WebDriver driver;
    static WebDriverWait wait;

    @BeforeAll
    public static void setup() {
        System.setProperty("webdriver.chrome.driver", "D:\\selenium\\chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    // Helper method to safely handle alerts
    private String acceptAlertIfPresent() {
        try {
            Alert alert = driver.switchTo().alert();
            String alertText = alert.getText();
            System.out.println("Alert Found: " + alertText);
            alert.accept();
            return alertText;
        } catch (NoAlertPresentException e) {
            // No alert was present, which is fine.
            System.out.println("No alert to accept.");
            return null;
        }
    }

    @BeforeEach
    public void login() {
        // 1. Handle any leftover alert from previous logout FIRST
        acceptAlertIfPresent();

        // 2. Now navigate to the login page
        driver.get("http://localhost:8080/PahanaEdu/login.jsp");

        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("username")));
        WebElement passwordField = driver.findElement(By.id("password"));
        // Wait for the button to be clickable, not just present
        WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[@type='submit']")));

        usernameField.sendKeys("admin");
        passwordField.sendKeys("admin");
        loginButton.click();

        acceptAlertIfPresent(); // Handle login success alert
    }

    @Test
    public void testAddNewItem_Success() {
        // 1. Navigate directly to the Add Item page
        driver.get("http://localhost:8080/PahanaEdu/item/add.jsp");

        // 2. Wait for the form to load and identify elements
        WebElement itemCodeField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("item_code")));
        WebElement nameField = driver.findElement(By.id("name"));
        WebElement descriptionField = driver.findElement(By.id("description"));
        WebElement priceField = driver.findElement(By.id("price"));
        WebElement stockField = driver.findElement(By.id("stock"));
        WebElement categoryField = driver.findElement(By.id("category"));
        // WAIT for the submit button to be CLICKABLE
        WebElement submitButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[@type='submit']")));

        // 3. Generate unique test data
        String timestamp = String.valueOf(System.currentTimeMillis());
        String itemCode = "ITEM-" + timestamp.substring(7);
        String itemName = "Selenium Test Item " + timestamp.substring(9);

        // 4. Fill out the form
        itemCodeField.sendKeys(itemCode);
        nameField.sendKeys(itemName);
        descriptionField.sendKeys("This is a test item created by an automated Selenium test.");
        priceField.sendKeys("999.50");
        stockField.sendKeys("100");
        categoryField.sendKeys("Test Category");

        // 5. Use JavaScript to click the button if normal click is intercepted
        try {
            submitButton.click();
        } catch (ElementClickInterceptedException e) {
            System.out.println("Normal click failed, using JavaScript click as a workaround.");
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", submitButton);
        }

        // 6. Handle the success alert that appears after adding the item
        String alertText = acceptAlertIfPresent();

        // 7. VERIFICATION - Check if the alert contained the success message
        Assertions.assertNotNull(alertText, "No alert was displayed after adding item.");
        Assertions.assertTrue(alertText.toLowerCase().contains("success"),
                "Alert did not contain success message. Actual message: " + alertText);

        System.out.println("Success! Message: " + alertText);
    }

    @AfterEach
    public void logout() {
        // Navigate to logout URL and handle the alert it creates
        driver.get("http://localhost:8080/PahanaEdu/login.jsp?logout=true");
        acceptAlertIfPresent(); // Accept the "logged out" alert immediately
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}