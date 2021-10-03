<?php

$servername = "mysql";
$username = "mysql";
$password = "mysql";
$dbname = "frpsscan";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT ip, port, valid FROM targets";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo $row['ip'] . "\t" . $row['port'] . "\n";
  }
} else {
  echo "0 results";
}
$conn->close();

?>