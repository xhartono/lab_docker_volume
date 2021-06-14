# Lab: Membangun Website dengan Docker Volume

---

## Tujuan Instruktional Khusus

Setelah menyelesaikan lab ini, Peserta akan dapat menggunakan volume pada docker container untuk dapat menyimpan data secara permanen, yang tidak hilang walaupun docker container dihapus (*remove*).

---

## Prosedur Pelaksanaan:

----

### Membuat Volume

```bash
$ docker volume create data_volume
data_volume
```
----
- Jika nama volume tidak disertakan Docker akan membuat volume dengan nama yang acak

```bash
$ docker volume create
2643a454f5bfb9592c2358ff624bc986b32a85848f80e42ee781d21c008b2f7a
```
----
### Menampilkan daftar Volume

- subperintah ls digunakan untuk menampilkan daftar volume

```bash
$ docker volume ls
DRIVER    VOLUME NAME
local     data_volume
local     2643a454f5bfb95...
```
----
### MengInspeksi Volume

- Untuk menampilkan detil informasi mengenai volume, dapat menggunakan subperintah inspect:

```bash
$ docker volume inspect data_volume
[
    {
        "CreatedAt": "2021-06-14T12:29:45+07:00",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/data_volume/_data",
        "Name": "data_volume",
        "Options": {},
        "Scope": "local"
    }
] 
```
----
### Menghapus Volume

```bash
$ docker volume rm data_volume
data_volume
```
----
### Memangkas Volume

- Untuk menghapus semua volume yang tidak digunakan (tidak dimount oleh container), dapat dihapus dengan perintah prune.

```bash
$ docker volume prune
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] 
```
---
### Menggunakan Volume pada Container

- Menggunakan opsi -v
- Lab berikut akan membuat WebSite, pilihan site template dapat dilihat pada: html5up.net

----

### Download html5 site template, dan unzip

```bash
$ take ~/labs/
$ mkdir web
$ wget --no-check-certificate https://html5up.net/aerial/download \
	-O temp.zip
$ unzip temp.zip -d web
$ rm temp.zip
```

----

#### Menggunakan NGINX

- Gunakan nginx image sebagai webserver untuk menjalankan WebSite.
- Container nginx menggunakan direktori web sebagai volume yang dimount pada direktori /usr/share/nginx/html

----
```bash
$ docker run 
	--rm
	--name mynginx \
	-p 8080:80 \
	-v $(pwd)/web:/usr/share/nginx/html 
	-d nginx
```
----
> Catatan:
> - --rm: akan menghapus container setelah container di hentikan (*stop*)
> - --name: memudahkan akses ke container dengan menggunakan name
> - -p : port mapping
> - v : volume mount
> -d : detach, jalankan container nginx di latar belakang
----
#### Akses website menggunakan Browser

```bash
$ curl localhost:8080
```

---

#### Tugas: Ubah Title pada website

----

#### Matikan container nginx.

```bash
$ docker stop mynginx
```

> Catatan:
>
> - Container mynginx setelah terhenti dengan perintah stop, secara otomatis akan dihapus dari daftar container, karena pada saat menjalankan (docker run) menggunakan opsi --rm

----
#### Ubah Title

```bash
$ sed -i 's/Adam Jensen/Inixindo/g' ./web/index.html
```

----

#### Jalankan kembali nginx container, dan lihat url **localhost:8080** pada browser:

```bash
$ docker run 
	--rm
	--name mynginx \
	-p 8080:80 \
	-v $(pwd)/web:/usr/share/nginx/html 
	-d nginx 
```

----

> Catatan:
>
> - Perhatikan meskipun container mynginx terhapus, website yang dimount melalui volume tidak ikut terhapus.

---

# Selesai
