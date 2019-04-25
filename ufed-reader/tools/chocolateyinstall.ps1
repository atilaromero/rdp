$url = "http://cdn5.cellebrite.org/Forensic/Physical%20Analyzer/UFED_Reader/UFEDReader_$($PackageVersion).zip"

Install-ChocolateyZipPackage $PackageName $url $env:userprofile\Desktop
