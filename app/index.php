<?php
$host = $_SERVER['HTTP_HOST'];
?>

<!DOCTYPE html>
<html>
<head>
    <title>EclixTech</title>
</head>
<body>
    <h1>EclixTech Reverse Proxy Demo</h1>

    <p><strong>Application:</strong> Docker Compose + Nginx + PHP</p>

    <p><strong>Request Host:</strong> <?php echo htmlspecialchars($host); ?></p>

    <?php if (strpos($host, ':8081') !== false): ?>
        <h2>Request came through the Reverse Proxy (Port 8081)</h2>
    <?php else: ?>
        <h2>Request came directly to the Main Nginx (Port 8080)</h2>
    <?php endif; ?>

    <p>PHP Version: <?php echo phpversion(); ?></p>
</body>
</html>
