package main

import (
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
)

func main() {

	host := os.Getenv("HOST")
	port := os.Getenv("PORT")
	targetHost := os.Getenv("TARGET_HOST")

	if host == "" {
		panic("HOST not set")
	}

	if port == "" {
		panic("PORT not set")
	}

	if targetHost == "" {
		panic("TARGET_HOST not set")
	}

	h := httputil.NewSingleHostReverseProxy(&url.URL{
		Scheme: "http",
		Host:   targetHost,
	})
	h.Director = func(r *http.Request) {
		r.Host = targetHost
		r.URL.Host = r.Host
		r.URL.Scheme = "http"
	}
	addr := fmt.Sprintf("%s:%s", host, port)

	log.Printf("starting proxy  %s -> %s:80\n", addr, targetHost)

	log.Fatalf("listen failed %s", http.ListenAndServe(addr, h))

}
