library(testthat)

library(greenChargeOps)

test_that("Package berjalan",{

  expect_true(TRUE)

})

test_that("Dataset tersedia",{

  data("data_transaksi",
       package="greenChargeOps")

  expect_gt(nrow(data_transaksi),0)

})
