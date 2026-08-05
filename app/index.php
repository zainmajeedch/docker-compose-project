<?php
echo "<!DOCTYPE html>";
echo "<html>";
echo "<head>";
echo "<title>EclixTech Demo</title>";
echo "<style>
body{
    font-family: Arial, sans-serif;
    margin:40px;
}
table{
    border-collapse: collapse;
}
td{
    border:1px solid #ccc;
    padding:10px;
}
h1{
    color:#0b5ed7;
}
</style>";
echo "</head>";
echo "<body>";

echo "<h1>EclixTech Reverse Proxy Demo</h1>";

echo "<table>";

echo "<tr>";
echo "<td><strong>Host</strong></td>";
echo "<td>" . $_SERVER['HTTP_HOST'] . "</td>";
echo "</tr>";

echo "<tr>";
echo "<td><strong>Requested URL</strong></td>";
echo "<td>http://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'] . "</td>";
echo "</tr>";

echo "<tr>";
echo "<td><strong>PHP Version</strong></td>";
echo "<td>" . phpversion() . "</td>";
echo "</tr>";

echo "<tr>";
echo "<td><strong>Current File</strong></td>";
echo "<td>" . basename(__FILE__) . "</td>";
echo "</tr>";

echo "<tr>";
echo "<td><strong>Full File Path</strong></td>";
echo "<td>" . __FILE__ . "</td>";
echo "</tr>";

echo "<tr>";
echo "<td><strong>Document Root</strong></td>";
echo "<td>" . $_SERVER['DOCUMENT_ROOT'] . "</td>";
echo "</tr>";

echo "<tr>";
echo "<td><strong>Server Software</strong></td>";
echo "<td>" . $_SERVER['SERVER_SOFTWARE'] . "</td>";
echo "</tr>";

echo "</table>";

echo "</body>";
echo "</html>";
?>
