library(usethis)

set.seed(2026)

n_transaksi <- 1200
tanggal_seq <- seq(
  as.Date("2026-06-01"),
  as.Date("2026-06-30"),
  by = "day"
)
data_transaksi <- data.frame(

  id_transaksi =
    sprintf(
      "TRX-%04d",
      1:n_transaksi
    ),

  nama_stasiun =
    sample(
      c(
        "Stasiun A",
        "Stasiun B",
        "Stasiun C"
      ),
      n_transaksi,
      replace = TRUE,
      prob = c(
        0.4,
        0.3,
        0.3
      )
    ),

  tanggal =
    sample(
      tanggal_seq,
      n_transaksi,
      replace = TRUE
    )
)
data_transaksi$jam_mulai <-
  sprintf(
    "%02d:%02d",

    sample(
      0:23,
      n_transaksi,
      replace = TRUE
    ),

    sample(
      c(
        0,
        15,
        30,
        45
      ),
      n_transaksi,
      replace = TRUE
    )
  )
data_transaksi$durasi_menit <-
  pmax(

    round(

      rnorm(
        n_transaksi,
        mean = 55,
        sd = 15
      )

    ),

    10

  )
data_transaksi$energi_kwh <-
  round(

    rgamma(
      n_transaksi,
      shape = 4,
      rate = 0.3
    ),

    1

  )
data_transaksi$tarif_per_kwh <-
  sample(

    c(
      2500,
      3000,
      3500
    ),

    n_transaksi,

    replace = TRUE

  )
data_transaksi$tarif_per_kwh <-
  sample(

    c(
      2500,
      3000,
      3500
    ),

    n_transaksi,

    replace = TRUE

  )
data_transaksi$status_pengisian <-
  sample(

    c(
      "Success",
      "Failed"
    ),

    n_transaksi,

    replace = TRUE,

    prob = c(
      0.97,
      0.03
    )

  )
data_transaksi$pendapatan <-
  data_transaksi$energi_kwh *
  data_transaksi$tarif_per_kwh
data_transaksi$bulan_transaksi <-
  format(
    data_transaksi$tanggal,
    "%B"
  )
data_transaksi$metode_pembayaran <-
  sample(
    c("QRIS","Kartu Kredit","E-Wallet"),
    n_transaksi,
    replace = TRUE,
    prob = c(0.5,0.2,0.3)
  )

data_transaksi$jenis_kendaraan <-
  sample(
    c("Mobil","Motor"),
    n_transaksi,
    replace = TRUE,
    prob = c(0.8,0.2)
  )
data_transaksi$tahun_transaksi <-
  as.numeric(
    format(
      data_transaksi$tanggal,
      "%Y"
    )
  )
use_data(
  data_transaksi,
  overwrite = TRUE
)
str(data_transaksi)
