#' Monitoring Penggunaan Energi
#'
#' Membuat ringkasan penggunaan energi pada setiap stasiun pengisian.
#'
#' @param df Data frame transaksi.
#'
#' @return Data frame ringkasan energi.
#' @export

monitor_energy_usage <- function(df){

  hasil <- aggregate(

    cbind(
      energi_kwh,
      pendapatan
    ) ~ nama_stasiun,

    data = df,

    sum

  )

  transaksi <- aggregate(

    id_transaksi ~ nama_stasiun,

    data = df,

    length

  )

  rata <- aggregate(

    energi_kwh ~ nama_stasiun,

    data = df,

    mean

  )

  names(transaksi)[2] <- "jumlah_transaksi"

  names(rata)[2] <- "rata_energi"

  hasil <- merge(
    hasil,
    transaksi,
    by = "nama_stasiun"
  )

  hasil <- merge(
    hasil,
    rata,
    by = "nama_stasiun"
  )

  hasil <- hasil[ ,
                  c(
                    "nama_stasiun",
                    "jumlah_transaksi",
                    "energi_kwh",
                    "rata_energi",
                    "pendapatan"
                  )
  ]

  names(hasil) <- c(
    "nama_stasiun",
    "jumlah_transaksi",
    "total_energi_kwh",
    "rata_energi_kwh",
    "total_pendapatan"
  )

  hasil

}
