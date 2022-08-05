# LinuxMonitoring-v.2

![logo](./image/logo.png)

## Content

The project contains 6 bash scripts. Each script is stored in the `./src/0x/` directory, where x is a number
script. Each script is launched via `./main.sh`, the rights to run the file as an executable are already set.
There is a validation performed on regular expressions to run each script.

## Script `01`

This script generates folders and files of the selected size, in the specified directory.

Runs with 6 parameters, where:
1. Absolute path to the folder where the generation will be.
2. Number of folders.
3. List of letters used in the folder name.
4. The number of files in the created folders.
5. List of letters in the name and extension of files.
6. File size (KB).

If there is less than 1 GB left in the root partition, the script exits.
Also, after the completion of the work, a log will be created in which the names of the created files and folders will be indicated.

## Script `02`

This script pollutes the system in random places from the `/home` folder.

Runs with 3 parameters, where:
1. List of letters in the names of generated folders.
2. List of letters in the name and extension of the generated files.
3. File size (MB).

The script will exit when there is less than 1 GB left on the root partition.
After the work is completed, a log will be created in which the names of the created files and folders will be indicated, as well as
the start and end times of the script.

## Script `03`

This script clears the system of created files after running the second script.

Runs with 1 parameter (number from 1 to 3), where:
1. Cleaning by log file.
2. Cleanup by creation time.
3. Cleaning by the mask of the name of the created files.

## Script `04`

This script generates 5 nginx log files in combined format. Each of these logs contains information for 1 day.

Each log file contains:
1. IP.
2. Response code.
3. Method.
4. Date.
5. URL request agent.
6. Agent.

## Script `05`

This script analyzes the log files created by the fourth script and displays the entries.
Runs with 1 parameter (number from 1 to 4), where:
1. Sorted by response code.
2. Only with a unique IP.
3. With erroneous requests.
4. Only unique IPs, among erroneous requests.

## Script `06`

This script runs the GoAccess utility on port 5050, which parses the log files from the fourth script.
