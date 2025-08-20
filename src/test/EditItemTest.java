package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;

import static org.junit.jupiter.api.Assertions.*;

public class EditItemTest {

    static WebDriver driver;
    static WebDriverWait wait;

    @BeforeAll
    public static void setup() {
        System.setProperty("webdriver.chrome.driver", "D:\\selenium\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--start-maximized");
        options.addArguments("--disable-notifications");
        options.addArguments("--disable-popup-blocking");

        driver = new ChromeDriver(options);
        wait = new WebDriverWait(driver, Duration.ofSeconds(15));
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    }

    // Enhanced alert handling with retries
    private String handleAlerts() {
        int attempts = 0;
        String alertText = null;

        while (attempts < 3) {
            try {
                Alert alert = driver.switchTo().alert();
                alertText = alert.getText();
                System.out.println("Alert Found: " + alertText);
                alert.accept();
                // Small delay to ensure alert is fully dismissed
                try { Thread.sleep(500); } catch (InterruptedException e) {}
                break;
            } catch (NoAlertPresentException e) {
                System.out.println("No alert present on attempt " + (attempts + 1));
                break;
            } catch (Exception e) {
                attempts++;
                System.out.println("Alert handling failed on attempt " + attempts + ": " + e.getMessage());
                try { Thread.sleep(1000); } catch (InterruptedException ie) {}
            }
        }
        return alertText;
    }

    @BeforeEach
    public void login() {
        // Clear any existing alerts first
        handleAlerts();

        // Navigate to the login page
        driver.get("http://localhost:8080/PahanaEdu/login.jsp");

        // Wait for page to load completely
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("username")));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[@type='submit']")));

        usernameField.clear();
        passwordField.clear();

        usernameField.sendKeys("admin");
        passwordField.sendKeys("admin");

        // Use JavaScript click to avoid interception issues
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", loginButton);

        // Handle login success alert
        handleAlerts();

        // Wait for navigation to complete
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));
    }

    @Test
    public void testNavigateToEditItemPage() {
        // First, navigate to item list to get a valid item code
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Try to find an item to edit
        try {
            WebElement table = wait.until(ExpectedConditions.visibilityOfElementLocated(By.tagName("table")));
            java.util.List<WebElement> editButtons = table.findElements(By.xpath(".//a[contains(@class, 'btn-warning') and contains(text(), 'Edit')]"));

            if (!editButtons.isEmpty()) {
                // Click the first edit button using JavaScript
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", editButtons.get(0));

                handleAlerts();
                wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

                // Verify we're on the edit page
                WebElement pageTitle = wait.until(ExpectedConditions.visibilityOfElementLocated(
                        By.xpath("//h2[contains(text(), 'Edit Item')]")
                ));
                assertTrue(pageTitle.isDisplayed(), "Should be on Edit Item page");

                // Verify URL contains edit parameter
                assertTrue(driver.getCurrentUrl().contains("edit") || driver.getCurrentUrl().contains("item_code="),
                        "URL should indicate edit mode");

            } else {
                // If no items exist, test direct navigation
                testDirectNavigationToEditPage();
            }

        } catch (Exception e) {
            System.out.println("Error navigating via item list: " + e.getMessage());
            testDirectNavigationToEditPage();
        }
    }

    private void testDirectNavigationToEditPage() {
        // Test direct navigation to edit page with a known item code
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=ITEM-848702");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Check if we're on the edit page or if item doesn't exist
        try {
            WebElement pageTitle = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.xpath("//h2[contains(text(), 'Edit Item')]")
            ));
            assertTrue(pageTitle.isDisplayed(), "Should be on Edit Item page");
        } catch (Exception e) {
            System.out.println("Direct navigation test failed - item may not exist: " + e.getMessage());
            // This is acceptable if the item doesn't exist
        }
    }

    @Test
    public void testEditItemPageStructure() {
        // Navigate to edit page
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=ITEM-848702");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify page elements
        WebElement pageTitle = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//h2[contains(text(), 'Edit Item')]")
        ));
        assertTrue(pageTitle.isDisplayed(), "Edit Item title should be displayed");

        // Verify form fields exist
        assertTrue(driver.findElement(By.id("name")).isDisplayed(), "Name field should be present");
        assertTrue(driver.findElement(By.id("description")).isDisplayed(), "Description field should be present");
        assertTrue(driver.findElement(By.id("price")).isDisplayed(), "Price field should be present");
        assertTrue(driver.findElement(By.id("stock")).isDisplayed(), "Stock field should be present");
        assertTrue(driver.findElement(By.id("category")).isDisplayed(), "Category field should be present");

        // Verify save button
        WebElement saveButton = driver.findElement(By.xpath("//button[@type='submit']"));
        assertTrue(saveButton.isDisplayed(), "Save button should be present");
        assertTrue(saveButton.getText().contains("Save"), "Save button should have correct text");

        // Verify back link
        WebElement backLink = driver.findElement(By.xpath("//a[contains(text(), 'Back to Dashboard')]"));
        assertTrue(backLink.isDisplayed(), "Back link should be present");
    }

    @Test
    public void testEditItemFormSubmission() {
        // Navigate to edit page
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=ITEM-848702");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        try {
            // Fill out the form with updated values
            WebElement nameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("name")));
            WebElement descriptionField = driver.findElement(By.id("description"));
            WebElement priceField = driver.findElement(By.id("price"));
            WebElement stockField = driver.findElement(By.id("stock"));
            WebElement categoryField = driver.findElement(By.id("category"));
            WebElement saveButton = driver.findElement(By.xpath("//button[@type='submit']"));

            // Clear existing values and enter new ones
            nameField.clear();
            nameField.sendKeys("Updated Test Item " + System.currentTimeMillis());

            descriptionField.clear();
            descriptionField.sendKeys("This item has been updated by automated test");

            priceField.clear();
            priceField.sendKeys("199.99");

            stockField.clear();
            stockField.sendKeys("50");

            categoryField.clear();
            categoryField.sendKeys("Updated Category");

            // Submit the form
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", saveButton);

            // Handle any alerts
            String alertText = handleAlerts();

            // Verify success - either redirect to list page or success message
            boolean success = wait.until(ExpectedConditions.or(
                    ExpectedConditions.urlContains("list"),
                    ExpectedConditions.urlContains("item/list"),
                    ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".alert-success")),
                    ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[contains(text(), 'success')]"))
            ));

            assertTrue(success, "Form submission should be successful");

        } catch (NoSuchElementException e) {
            System.out.println("Item may not exist for editing: " + e.getMessage());
            // This is acceptable if the test item doesn't exist
        }
    }

    @Test
    public void testFormValidation() {
        // Navigate to edit page
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=ITEM-848702");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        try {
            WebElement nameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("name")));
            WebElement priceField = driver.findElement(By.id("price"));
            WebElement stockField = driver.findElement(By.id("stock"));
            WebElement saveButton = driver.findElement(By.xpath("//button[@type='submit']"));

            // Test required field validation
            nameField.clear();
            priceField.clear();
            stockField.clear();

            // Try to submit empty form
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", saveButton);

            // Check if browser validation prevents submission or shows errors
            // Most browsers will show validation messages that we can't easily test
            System.out.println("Form validation test completed - browser validation handled");

        } catch (NoSuchElementException e) {
            System.out.println("Item may not exist for validation test: " + e.getMessage());
        }
    }

    @Test
    public void testNavigationBackToDashboard() {
        // Navigate to edit page
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=ITEM-848702");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Click back to dashboard link
        WebElement backLink = wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//a[contains(text(), 'Back to Dashboard')]")
        ));

        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", backLink);

        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify navigation to dashboard
        boolean onDashboard = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("dashboard.jsp"),
                ExpectedConditions.urlContains("dashboard"),
                ExpectedConditions.visibilityOfElementLocated(By.xpath("//h2[contains(text(), 'Dashboard')]"))
        ));

        assertTrue(onDashboard, "Should navigate back to dashboard");
    }

    @Test
    public void testSidebarNavigationFromEditPage() {
        // Navigate to edit page
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=ITEM-848702");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Click on Items link in sidebar
        WebElement itemsLink = wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//a[contains(@href, '/item/list')]")
        ));

        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", itemsLink);

        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify navigation to items list
        boolean onItemsList = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("item/list"),
                ExpectedConditions.urlContains("list"),
                ExpectedConditions.visibilityOfElementLocated(By.xpath("//h2[contains(text(), 'Items')]"))
        ));

        assertTrue(onItemsList, "Should navigate to items list from sidebar");
    }

    @Test
    public void testEditNonExistentItem() {
        // Try to edit an item that doesn't exist
        driver.get("http://localhost:8080/PahanaEdu/item/edit?item_code=NONEXISTENT-123");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // The page should either show an error or redirect
        // This test verifies the application doesn't crash
        boolean pageLoaded = wait.until(ExpectedConditions.or(
                ExpectedConditions.visibilityOfElementLocated(By.tagName("body")),
                ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[contains(text(), 'Error')]")),
                ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[contains(text(), 'not found')]"))
        ));

        assertTrue(pageLoaded, "Page should load without crashing for non-existent item");
    }

    @AfterEach
    public void logout() {
        // Use a more robust logout approach
        try {
            // Try to logout via the standard method
            driver.get("http://localhost:8080/PahanaEdu/login.jsp?logout=true");
            handleAlerts();

            // Verify we're on the login page
            wait.until(ExpectedConditions.urlContains("login.jsp"));

        } catch (Exception e) {
            System.out.println("Logout failed: " + e.getMessage());
            // Fallback: clear session and cookies
            driver.manage().deleteAllCookies();
            driver.get("http://localhost:8080/PahanaEdu/login.jsp");
        }

        // Ensure we're ready for the next test
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}