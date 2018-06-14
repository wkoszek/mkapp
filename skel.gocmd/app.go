// You can use this code for fun.
package main

import (
	"fmt"
	"io/ioutil"
	"log"
)

// @todo: list a directory
// @todo: split data into lines
// @todo: open a socket
// @todo: write/open/read a file
// @todo: parse a regex
// @todo: how to read a json file without pre-recording a structure
// @todo: find a way to parse yaml file

func main() {
	fmt.Println("wojtek")

	data, err := ioutil.ReadFile("/etc/hosts")
	checkerr(err)

	// convert from bytes to string

	fmt.Printf("%s", data)
	l := data.Split("\n")
	fmt.Println(l)

	unix := UnixEmulMake()
	unix.mkdir("mkdir")
	unix.touch("
	unix.cp("asd", "asd")
}

func checkerr(err error) {
	if (err != nil) {
		log.Fatal("error")
	}
}
