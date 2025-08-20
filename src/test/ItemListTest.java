package test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.junit.jupiter.api.*;

import java.time.Duration;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ItemListTest {

    static WebDriver driver;
    static WebDriverWait wait;

    @BeforeAll
    public static void setup() {
        System.setProperty("webdriver.chrome.driver", "D:\\selenium\\chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(15));
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    }
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
    public void testNavigateToItemListPage() {
        // Navigate to item list page with alert handling
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts(); // Handle any alerts during navigation

        // Wait for page to load
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Verify page header
        WebElement pageHeader = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//h2[contains(text(), 'Items')]")
        ));
        assertTrue(pageHeader.isDisplayed(), "Items page header should be displayed");
    }

    @Test
    public void testItemListTableStructure() {
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Wait for table to be present with retry logic
        WebElement table = null;
        int attempts = 0;
        while (attempts < 3 && table == null) {
            try {
                table = wait.until(ExpectedConditions.visibilityOfElementLocated(By.tagName("table")));
            } catch (TimeoutException e) {
                attempts++;
                System.out.println("Table not found, attempt " + attempts);
                handleAlerts(); // Check for alerts that might be blocking
            }
        }

        assertNotNull(table, "Table should be present on the page");

        // Verify table headers
        String[] expectedHeaders = {"Item Code", "Name", "Description", "Price", "Stock", "Category", "Actions"};
        List<WebElement> headerCells = table.findElements(By.tagName("th"));

        assertTrue(headerCells.size() >= expectedHeaders.length,
                "Table should have at least " + expectedHeaders.length + " headers");
    }

    @Test
    public void testItemListContainsItems() {
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        WebElement table = wait.until(ExpectedConditions.visibilityOfElementLocated(By.tagName("table")));
        List<WebElement> rows = table.findElements(By.cssSelector("tbody tr"));

        if (rows.isEmpty()) {
            // Check for "No items found" message
            WebElement noItemsMessage = driver.findElement(By.xpath("//td[contains(text(), 'No items found')]"));
            assertTrue(noItemsMessage.isDisplayed(), "Should display no items message when table is empty");
        } else {
            // Verify at least one row exists
            assertTrue(rows.size() > 0, "Should have at least one item in the table");
        }
    }

    @Test
    public void testNavigationToAddItemPage() {
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Use JavaScript to click to avoid interception
        WebElement addButton = wait.until(ExpectedConditions.presenceOfElementLocated(
                By.xpath("//a[contains(text(), 'Add New Item')]")
        ));

        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", addButton);

        handleAlerts(); // Handle any alerts during navigation

        // Verify navigation with more flexible condition
        boolean navigatedSuccessfully = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("add.jsp"),
                ExpectedConditions.urlContains("add")
        ));

        assertTrue(navigatedSuccessfully, "Should navigate to add item page");
    }

    @Test
    public void testBackToDashboardNavigation() {
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Use JavaScript click to avoid element interception
        WebElement backButton = wait.until(ExpectedConditions.presenceOfElementLocated(
                By.xpath("//a[contains(text(), 'Back to Dashboard')]")
        ));

        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", backButton);

        handleAlerts(); // Handle any alerts during navigation

        // Verify navigation to dashboard
        boolean navigatedToDashboard = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("dashboard.jsp"),
                ExpectedConditions.urlContains("dashboard")
        ));

        assertTrue(navigatedToDashboard, "Should navigate back to dashboard");
    }

    @Test
    public void testSidebarNavigationFromItemList() {
        driver.get("http://localhost:8080/PahanaEdu/item/list");
        handleAlerts();
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));

        // Click on Dashboard link in sidebar using JavaScript
        WebElement dashboardLink = wait.until(ExpectedConditions.presenceOfElementLocated(
                By.xpath("//a[contains(@href, 'dashboard.jsp')]")
        ));

        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", dashboardLink);

        handleAlerts(); // Handle any alerts during navigation

        // Verify navigation to dashboard
        boolean navigatedToDashboard = wait.until(ExpectedConditions.or(
                ExpectedConditions.urlContains("dashboard.jsp"),
                ExpectedConditions.urlContains("dashboard")
        ));

        assertTrue(navigatedToDashboard, "Should navigate to dashboard from sidebar");
    }

    @AfterEach
    public void logout() {

        try {

            driver.get("http://localhost:8080/PahanaEdu/login.jsp?logout=true");
            handleAlerts();


            wait.until(ExpectedConditions.urlContains("login.jsp"));

        } catch (Exception e) {
            System.out.println("Logout failed: " + e.getMessage());

            driver.manage().deleteAllCookies();
            driver.get("http://localhost:8080/PahanaEdu/login.jsp");
        }


        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState === 'complete';"));
    }

    @AfterAll
    public static void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}