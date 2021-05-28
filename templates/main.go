package main

import (
	"fmt"
	"net/http"
)

func main() {
	r := http.NewServeMux()
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "Hello world!")
	})

	serverAddress := fmt.Sprintf("0.0.0.0:%s", "<% index .Params `containerPort` %>")
	server := &http.Server{Addr: serverAddress, Handler: r}

	fmt.Printf("Serving at http://%s/", serverAddress)
	server.ListenAndServe()
}
