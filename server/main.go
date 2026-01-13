package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("Serving static files")
	http.Handle("/", http.FileServer(http.Dir("./public")))
	http.ListenAndServe(":3000", nil)
}
