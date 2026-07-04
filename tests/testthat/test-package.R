library(testthat)

test_that("Dataset tersedia", {

  data(data_transaksi)

  expect_s3_class(
    data_transaksi,
    "data.frame"
  )

  expect_gt(
    nrow(data_transaksi),
    0
  )

})

test_that("Receive charging data bekerja", {

  data(data_transaksi)

  hasil <- receive_charging_data(data_transaksi)

  expect_s3_class(
    hasil,
    "data.frame"
  )

})

test_that("Monitor energy bekerja", {

  data(data_transaksi)

  hasil <- receive_charging_data(data_transaksi)

  monitor <- monitor_energy_usage(hasil)

  expect_equal(
    nrow(monitor),
    3
  )

})

test_that("Manage tariff bekerja", {

  data(data_transaksi)

  hasil <- receive_charging_data(data_transaksi)

  tarif <- manage_tariff(
    hasil,
    3500
  )

  expect_true(
    "selisih_pendapatan" %in%
      names(tarif)
  )

})

test_that("KPI berhasil dibuat", {

  data(data_transaksi)

  hasil <- receive_charging_data(data_transaksi)

  tarif <- manage_tariff(
    hasil,
    3500
  )

  kpi <- get_station_kpi(tarif)

  expect_equal(
    nrow(kpi),
    3
  )

})
