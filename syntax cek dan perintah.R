library(usethis)

use_roxygen_md()

use_mit_license("PT Green Charge Indonesia")

use_readme_rmd()

use_testthat()



#
use_package("dplyr")
use_package("ggplot2")
use_package("forecast")
use_package("knitr")
use_package("kableExtra")
use_package("rmarkdown")

#
use_r("receive_data")

use_r("monitor_energy")

use_r("manage_tariff")

use_r("station_kpi")

#
use_vignette("laporan-operasional")

#
use_test("basic")

devtools::document()

system("git status")
}


#git konek

system("git init")
system("git add .")
system('git commit -m "Initial commit greenChargeOps"')
system("git branch -M main")
system("git branch")
usethis::use_github()

devtools::install()
pkgdown::build_site()
