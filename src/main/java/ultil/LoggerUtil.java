package ultil;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.logging.*;

public class LoggerUtil {
    private static final Logger logger = Logger.getLogger("MyAppLogger");

    static {
        try {
            // Đường dẫn mặc định ở ổ D
            Path logPath = Path.of("D:/mylogs/app.log").toAbsolutePath();
            Files.createDirectories(logPath.getParent());

            logger.setUseParentHandlers(false); // Tắt log mặc định

            FileHandler fileHandler = new FileHandler(logPath.toString(), true);
            fileHandler.setEncoding(StandardCharsets.UTF_8.name());
            fileHandler.setLevel(Level.ALL);
            fileHandler.setFormatter(new SimpleFormatter());

            logger.addHandler(fileHandler);
            logger.setLevel(Level.ALL);

            // In ra console đường dẫn file log
            System.out.println("Logs sẽ được ghi vào file: " + logPath);

        } catch (IOException e) {
            System.err.println("Không thể tạo logger: " + e.getMessage());
        }
    }

    public static Logger getLogger() {
        return logger;
    }
}
