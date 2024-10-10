CREATE DATABASE GasStationShub;
USE GasStationShub;

--tao bang tram  xang (station va address la doc nhac)
CREATE TABLE GasStation (
  gas_station_id INT PRIMARY KEY IDENTITY(1,1),
  station_name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  UNIQUE (station_name, address)
);

-- tao bang hang hoa
CREATE TABLE Product (
  product_id INT PRIMARY KEY IDENTITY(1,1),
  product_name VARCHAR(100) NOT NULL,
  UNIQUE (product_name)
);

--tao bang tru bom
CREATE TABLE Pump (
   pump_id INT PRIMARY KEY IDENTITY(1,1),
   gas_station_id INT,
   product_id INT,
   FOREIGN KEY (gas_station_id) REFERENCES GasStation(gas_station_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- tao bang giao dich
CREATE TABLE Transactions (
   transaction_id INT PRIMARY KEY IDENTITY(1,1),
   gas_station_id INT,
   pump_id INT,
   product_id INT,
   transaction_datetime DATETIME NOT NULL,
   transaction_value DECIMAL(10, 2) NOT NULL,
   FOREIGN KEY (gas_station_id) REFERENCES GasStation(gas_station_id),
   FOREIGN KEY (pump_id) REFERENCES Pump(pump_id),
   FOREIGN KEY (product_id) REFERENCES Product(product_id)
);