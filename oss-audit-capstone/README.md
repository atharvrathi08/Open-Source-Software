# OSS Audit Capstone

## Student Details
- **Student Name:** `Atharv Rathi`
- **Roll Number:** `24BCE11139`
- **Chosen Open-Source Software:** `git`



## Repository Contents
- `scripts/01_system_identity.sh` - System Identity Report
- `scripts/02_foss_package_inspector.sh` - FOSS Package Inspector
- `scripts/03_disk_permission_auditor.sh` - Disk and Permission Auditor
- `scripts/04_log_file_analyzer.sh` - Log File Analyzer
- `scripts/05_manifesto_generator.sh` - Open Source Manifesto Generator
- `report/REPORT_TEMPLATE.md` - Full report structure template

## Dependencies / Requirements
- Linux environment with `bash`
- For Script 2:
  - Either `rpm` (RPM-based distros) or `dpkg` (Debian-based distros)
- For Script 4:
  - A readable log file (example: `/var/log/messages` or distro equivalents)

## How to Run

1. Make scripts executable:
```bash
chmod +x scripts/*.sh
```

2. Run Script 1:
```bash
./scripts/01_system_identity.sh
```

3. Run Script 2 (package inspector):
```bash
./scripts/02_foss_package_inspector.sh <package_name>
```
Example:
```bash
./scripts/02_foss_package_inspector.sh httpd
```

4. Run Script 3 (disk + permissions auditor):
```bash
./scripts/03_disk_permission_auditor.sh [config_dir]
```
If `config_dir` is not provided, the script will attempt common locations based on your `SOFTWARE_CHOICE` (see the script top section).

5. Run Script 4 (log analyzer):
```bash
./scripts/04_log_file_analyzer.sh <log_file> [keyword]
```
Example:
```bash
./scripts/04_log_file_analyzer.sh /var/log/syslog ERROR
```

6. Run Script 5 (manifesto generator):
```bash
./scripts/05_manifesto_generator.sh
```

The script will create a text file like `manifesto_<username>.txt` in the current directory.



