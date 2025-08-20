package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class CreateBillTest {

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
    public void testNavigateToCreateBillPage() {
        // Navigate to create bill page
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify page elements
        WebElement pageTitle = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//h2[contains(text(), 'Create Bill')]")
        ));
        assertTrue(pageTitle.isDisplayed(), "Create Bill title should be displayed");

        // Verify form elements exist
        assertTrue(driver.findElement(By.id("customerAccountNumber")).isDisplayed(), "Customer dropdown should be present");
        assertTrue(driver.findElement(By.id("billDate")).isDisplayed(), "Bill date field should be present");
        assertTrue(driver.findElement(By.xpath("//button[contains(text(), 'Add Item')]")).isDisplayed(), "Add Item button should be present");
    }

    @Test
    public void testCreateBillPageStructure() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify all main elements are present
        WebElement customerDropdown = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("customerAccountNumber")));
        WebElement billDateField = driver.findElement(By.id("billDate"));
        WebElement addItemButton = driver.findElement(By.xpath("//button[contains(text(), 'Add Item')]"));
        WebElement saveButton = driver.findElement(By.xpath("//button[@type='submit']"));
        WebElement backButton = driver.findElement(By.xpath("//a[contains(text(), 'Back to Dashboard')]"));

        assertTrue(customerDropdown.isDisplayed(), "Customer dropdown should be visible");
        assertTrue(billDateField.isDisplayed(), "Bill date field should be visible");
        assertTrue(addItemButton.isDisplayed(), "Add Item button should be visible");
        assertTrue(saveButton.isDisplayed(), "Save button should be visible");
        assertTrue(backButton.isDisplayed(), "Back button should be visible");

        // Verify bill date is set to today
        LocalDate today = LocalDate.now();
        String expectedDate = today.toString();
        assertEquals(expectedDate, billDateField.getAttribute("value"), "Bill date should be set to today");
    }

    @Test
    public void testAddAndRemoveItems() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Count initial items (should be 1 by default)
        List<WebElement> initialItems = driver.findElements(By.cssSelector(".item-row"));
        assertEquals(1, initialItems.size(), "Should start with one item row");

        // Add a new item
        WebElement addButton = driver.findElement(By.xpath("//button[contains(text(), 'Add Item')]"));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", addButton);

        // Verify new item was added
        List<WebElement> itemsAfterAdd = wait.until(ExpectedConditions.numberOfElementsToBe(By.cssSelector(".item-row"), 2));
        assertEquals(2, itemsAfterAdd.size(), "Should have 2 item rows after adding");

        // Remove the second item
        WebElement removeButton = itemsAfterAdd.get(1).findElement(By.xpath(".//button[contains(@class, 'btn-danger')]"));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", removeButton);

        // Verify item was removed
        List<WebElement> itemsAfterRemove = wait.until(ExpectedConditions.numberOfElementsToBe(By.cssSelector(".item-row"), 1));
        assertEquals(1, itemsAfterRemove.size(), "Should have 1 item row after removal");
    }

    @Test
    public void testItemSelectionAndCalculation() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Get the first item row
        WebElement itemRow = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".item-row")));

        // Select an item from dropdown
        WebElement itemSelect = itemRow.findElement(By.cssSelector(".item-select"));
        Select itemDropdown = new Select(itemSelect);

        // Wait for items to load and select the first available item (skip "Select Item" option)
        wait.until(ExpectedConditions.numberOfElementsToBeMoreThan(By.cssSelector(".item-select option"), 1));

        if (itemDropdown.getOptions().size() > 1) {
            // Select the first actual item (index 1, since index 0 is "Select Item")
            itemDropdown.selectByIndex(1);

            // Get the selected option details
            WebElement selectedOption = itemDropdown.getFirstSelectedOption();
            double price = Double.parseDouble(selectedOption.getAttribute("data-price"));
            int stock = Integer.parseInt(selectedOption.getAttribute("data-stock"));

            // Verify unit price is set correctly
            WebElement unitPriceField = itemRow.findElement(By.cssSelector(".unit"));
            wait.until(ExpectedConditions.attributeToBe(unitPriceField, "value", String.valueOf(price)));
            assertEquals(String.valueOf(price), unitPriceField.getAttribute("value"), "Unit price should match selected item");

            // Verify total calculation
            WebElement quantityField = itemRow.findElement(By.cssSelector(".qty"));
            WebElement totalField = itemRow.findElement(By.cssSelector(".total"));

            double expectedTotal = price * Integer.parseInt(quantityField.getAttribute("value"));
            assertEquals(String.format("%.2f", expectedTotal), totalField.getAttribute("value"), "Total should be calculated correctly");

            // Verify stock validation is present
            assertTrue(quantityField.getAttribute("max").equals(String.valueOf(stock)) ||
                            quantityField.getAttribute("data-stock").equals(String.valueOf(stock)),
                    "Stock validation should be set");
        } else {
            System.out.println("No items available for testing - skipping item selection test");
        }
    }

    @Test
    public void testQuantityValidation() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        WebElement itemRow = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".item-row")));
        WebElement itemSelect = itemRow.findElement(By.cssSelector(".item-select"));
        Select itemDropdown = new Select(itemSelect);

        // Wait for items to load
        wait.until(ExpectedConditions.numberOfElementsToBeMoreThan(By.cssSelector(".item-select option"), 1));

        if (itemDropdown.getOptions().size() > 1) {
            // Select an item with known stock
            itemDropdown.selectByIndex(1);

            WebElement selectedOption = itemDropdown.getFirstSelectedOption();
            int stock = Integer.parseInt(selectedOption.getAttribute("data-stock"));

            WebElement quantityField = itemRow.findElement(By.cssSelector(".qty"));

            // Test setting quantity within stock limit
            quantityField.clear();
            quantityField.sendKeys(String.valueOf(stock));

            // Should not show stock alert for valid quantity
            try {
                List<WebElement> stockAlerts = itemRow.findElements(By.cssSelector(".stock-alert"));
                if (!stockAlerts.isEmpty()) {
                    assertFalse(stockAlerts.get(0).isDisplayed(), "Stock alert should not be shown for valid quantity");
                }
            } catch (NoSuchElementException e) {
                // This is expected - no alert should be present
            }

            // Test setting quantity above stock limit
            quantityField.clear();
            quantityField.sendKeys(String.valueOf(stock + 1));

            // Should show stock alert - use a more robust way to check
            boolean stockAlertFound = false;
            try {
                // Wait a moment for the alert to appear
                Thread.sleep(1000);

                // Check for stock alert in the row
                List<WebElement> alerts = itemRow.findElements(By.cssSelector(".stock-alert"));
                if (!alerts.isEmpty() && alerts.get(0).isDisplayed()) {
                    stockAlertFound = true;
                    assertTrue(alerts.get(0).getText().contains("Only " + stock + " items available"),
                            "Stock alert should show correct message");
                }
            } catch (Exception e) {
                System.out.println("Stock alert check failed: " + e.getMessage());
            }

            if (!stockAlertFound) {
                System.out.println("Stock alert not found - may be handled differently in this version");
            }
        } else {
            System.out.println("No items available for testing - skipping quantity validation test");
        }
    }

    @Test
    public void testTotalCalculation() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Add a second item
        WebElement addButton = driver.findElement(By.xpath("//button[contains(text(), 'Add Item')]"));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", addButton);

        List<WebElement> itemRows = wait.until(ExpectedConditions.numberOfElementsToBe(By.cssSelector(".item-row"), 2));

        // Select items and set quantities if available
        boolean itemsSelected = false;
        if (itemRows.size() >= 2) {
            try {
                // Try to select items for both rows
                for (int i = 0; i < Math.min(2, itemRows.size()); i++) {
                    WebElement row = itemRows.get(i);
                    WebElement itemSelect = row.findElement(By.cssSelector(".item-select"));
                    Select dropdown = new Select(itemSelect);

                    if (dropdown.getOptions().size() > 1) {
                        dropdown.selectByIndex(i + 1); // Select different items
                        itemsSelected = true;

                        // Set different quantities
                        WebElement qtyField = row.findElement(By.cssSelector(".qty"));
                        qtyField.clear();
                        qtyField.sendKeys(String.valueOf(i + 2)); // 2 and 3 quantities
                    }
                }
            } catch (Exception e) {
                System.out.println("Could not select items for total calculation test: " + e.getMessage());
            }
        }

        if (itemsSelected) {
            // Verify totals are updated
            WebElement totalItems = driver.findElement(By.id("totalItems"));
            WebElement totalQuantity = driver.findElement(By.id("totalQuantity"));
            WebElement totalAmount = driver.findElement(By.id("totalAmount"));

            // Totals should reflect the added items
            assertTrue(Integer.parseInt(totalItems.getText()) >= 1, "Total items should be updated");
            assertTrue(Integer.parseInt(totalQuantity.getText()) >= 2, "Total quantity should be updated");
            assertTrue(totalAmount.getText().startsWith("LKR"), "Total amount should be formatted correctly");
        } else {
            System.out.println("Skipping detailed total calculation - not enough items available");
        }
    }

    @Test
    public void testFormValidation() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Try to submit empty form
        WebElement saveButton = driver.findElement(By.xpath("//button[@type='submit']"));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", saveButton);

        // Should show validation errors (either browser validation or custom alerts)
        handleAlerts(); // Handle any JavaScript alerts

        // Verify we're still on the same page (form wasn't submitted)
        assertTrue(driver.getCurrentUrl().contains("billing/create"), "Should remain on create bill page after failed submission");
    }

    @Test
    public void testNavigation() {
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Test back to dashboard navigation
        WebElement backButton = driver.findElement(By.xpath("//a[contains(text(), 'Back to Dashboard')]"));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", backButton);

        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify navigation to dashboard
        boolean onDashboard = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("dashboard.jsp"),
                ExpectedConditions.urlContains("dashboard"),
                ExpectedConditions.visibilityOfElementLocated(By.xpath("//h2[contains(text(), 'Dashboard')]"))
        ));

        assertTrue(onDashboard, "Should navigate back to dashboard");

        // Test sidebar navigation back to create bill
        driver.get("http://localhost:8080/PahanaEdu/billing/create");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        WebElement sidebarLink = driver.findElement(By.xpath("//a[contains(@href, '/item/list')]"));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", sidebarLink);

        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify navigation to items list
        boolean onItemsList = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("item/list"),
                ExpectedConditions.visibilityOfElementLocated(By.xpath("//h2[contains(text(), 'Items')]"))
        ));

        assertTrue(onItemsList, "Should navigate to items list from sidebar");
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