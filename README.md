
<!-- README.md is generated from README.Rmd. Please edit README.Rmd and render it using devtools::build_readme(). -->

# greenChargeOps

`greenChargeOps` merupakan package R yang dikembangkan untuk membantu
operator stasiun pengisian kendaraan listrik (Electric Vehicle Charging
Station) dalam mengelola data operasional secara otomatis.

Package ini dibuat sebagai implementasi studi kasus **Sistem Pengisian
Energi Kendaraan Listrik PT Green Charge Indonesia**.

## Fitur

Package menyediakan beberapa fungsi utama:

- Menerima dan memvalidasi data transaksi pengisian kendaraan listrik.
- Melakukan monitoring penggunaan energi setiap stasiun.
- Mengelola perubahan tarif pengisian.
- Menghasilkan Key Performance Indicator (KPI) setiap stasiun.
- Mendukung pembuatan laporan operasional menggunakan R Markdown.

## Struktur Package

    greenChargeOps
    ├── R/
    │   ├── receive_data.R
    │   ├── monitor_energy.R
    │   ├── manage_tariff.R
    │   └── station_kpi.R
    │
    ├── data/
    │   └── data_transaksi.rda
    │
    ├── vignettes/
    │   └── laporan-operasional.Rmd
    │
    ├── tests/
    └── man/

## Installation

Install package menggunakan **devtools**.

``` r
# install.packages("devtools")

devtools::install_github("username/greenChargeOps")
```

Apabila package masih berada pada komputer lokal:

``` r
devtools::load_all()
```

## Dataset

Package menyediakan dataset simulasi:

``` r
library(greenChargeOps)

data(data_transaksi)

head(data_transaksi)
#>   id_transaksi nama_stasiun    tanggal jam_mulai durasi_menit energi_kwh
#> 1     TRX-0001    Stasiun C 2026-06-15     03:00           56       11.9
#> 2     TRX-0002    Stasiun C 2026-06-08     01:15           71       12.9
#> 3     TRX-0003    Stasiun A 2026-06-18     19:45           62        6.5
#> 4     TRX-0004    Stasiun A 2026-06-23     20:30           30        7.7
#> 5     TRX-0005    Stasiun C 2026-06-22     02:45           54       17.3
#> 6     TRX-0006    Stasiun A 2026-06-15     00:45           39       19.3
#>   tarif_per_kwh status_pengisian pendapatan bulan_transaksi metode_pembayaran
#> 1          3500          Success      41650            Juni          E-Wallet
#> 2          3500          Success      45150            Juni          E-Wallet
#> 3          3000          Success      19500            Juni          E-Wallet
#> 4          2500          Success      19250            Juni      Kartu Kredit
#> 5          2500          Success      43250            Juni      Kartu Kredit
#> 6          3000          Success      57900            Juni      Kartu Kredit
#>   jenis_kendaraan tahun_transaksi
#> 1           Mobil            2026
#> 2           Mobil            2026
#> 3           Mobil            2026
#> 4           Mobil            2026
#> 5           Mobil            2026
#> 6           Mobil            2026
```

## Contoh Penggunaan

### Validasi Data

``` r
transaksi <- receive_charging_data(data_transaksi)

head(transaksi)
#>   id_transaksi nama_stasiun    tanggal jam_mulai durasi_menit energi_kwh
#> 1     TRX-0001    Stasiun C 2026-06-15     03:00           56       11.9
#> 2     TRX-0002    Stasiun C 2026-06-08     01:15           71       12.9
#> 3     TRX-0003    Stasiun A 2026-06-18     19:45           62        6.5
#> 4     TRX-0004    Stasiun A 2026-06-23     20:30           30        7.7
#> 5     TRX-0005    Stasiun C 2026-06-22     02:45           54       17.3
#> 6     TRX-0006    Stasiun A 2026-06-15     00:45           39       19.3
#>   tarif_per_kwh status_pengisian pendapatan bulan_transaksi metode_pembayaran
#> 1          3500          Success      41650            Juni          E-Wallet
#> 2          3500          Success      45150            Juni          E-Wallet
#> 3          3000          Success      19500            Juni          E-Wallet
#> 4          2500          Success      19250            Juni      Kartu Kredit
#> 5          2500          Success      43250            Juni      Kartu Kredit
#> 6          3000          Success      57900            Juni      Kartu Kredit
#>   jenis_kendaraan tahun_transaksi
#> 1           Mobil            2026
#> 2           Mobil            2026
#> 3           Mobil            2026
#> 4           Mobil            2026
#> 5           Mobil            2026
#> 6           Mobil            2026
```

### Monitoring Energi

``` r
monitor_energy_usage(transaksi)
#>   nama_stasiun jumlah_transaksi total_energi_kwh rata_energi_kwh
#> 1    Stasiun A              464           6318.1        13.61659
#> 2    Stasiun B              355           4853.8        13.67268
#> 3    Stasiun C              353           4925.1        13.95212
#>   total_pendapatan
#> 1         18806650
#> 2         14784250
#> 3         14944250
```

### Mengubah Tarif

``` r
tarif <- manage_tariff(
  transaksi,
  tarif_baru = 3500
)

head(tarif)
#>   id_transaksi nama_stasiun    tanggal jam_mulai durasi_menit energi_kwh
#> 1     TRX-0001    Stasiun C 2026-06-15     03:00           56       11.9
#> 2     TRX-0002    Stasiun C 2026-06-08     01:15           71       12.9
#> 3     TRX-0003    Stasiun A 2026-06-18     19:45           62        6.5
#> 4     TRX-0004    Stasiun A 2026-06-23     20:30           30        7.7
#> 5     TRX-0005    Stasiun C 2026-06-22     02:45           54       17.3
#> 6     TRX-0006    Stasiun A 2026-06-15     00:45           39       19.3
#>   tarif_per_kwh status_pengisian pendapatan bulan_transaksi metode_pembayaran
#> 1          3500          Success      41650            Juni          E-Wallet
#> 2          3500          Success      45150            Juni          E-Wallet
#> 3          3500          Success      22750            Juni          E-Wallet
#> 4          3500          Success      26950            Juni      Kartu Kredit
#> 5          3500          Success      60550            Juni      Kartu Kredit
#> 6          3500          Success      67550            Juni      Kartu Kredit
#>   jenis_kendaraan tahun_transaksi tarif_lama pendapatan_lama selisih_pendapatan
#> 1           Mobil            2026       3500           41650                  0
#> 2           Mobil            2026       3500           45150                  0
#> 3           Mobil            2026       3000           19500               3250
#> 4           Mobil            2026       2500           19250               7700
#> 5           Mobil            2026       2500           43250              17300
#> 6           Mobil            2026       3000           57900               9650
```

### Menghasilkan KPI

``` r
get_station_kpi(tarif)
#>   nama_stasiun total_energi_kwh total_pendapatan jumlah_transaksi total_durasi
#> 1    Stasiun A           6318.1         22113350              464        24837
#> 2    Stasiun B           4853.8         16988300              355        19374
#> 3    Stasiun C           4925.1         17237850              353        19448
#>   utilisasi_persen kategori
#> 1            57.49     Fair
#> 2            44.85     Fair
#> 3            45.02     Fair
```

## Output Package

Package dapat digunakan untuk menghasilkan:

- Ringkasan transaksi pengisian kendaraan listrik.
- Monitoring penggunaan energi.
- Monitoring pendapatan.
- KPI setiap stasiun pengisian.
- Laporan operasional bulanan berbasis R Markdown.
- Visualisasi operasional.
- Forecast kebutuhan energi.

## Repository

Repository package dapat disimpan pada GitHub untuk memudahkan
dokumentasi, pengembangan, dan kolaborasi.

## Author

**PT Green Charge Indonesia**

Universitas Islam Indonesia

Praktikum Komputasi Statistik

2026
