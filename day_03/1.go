package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

const Input = "./input"
const SmallInput = "./small_input"

func Btos(b bool) string {
	if b {
		return "1"
	}
	return "0"
}

type DiagnosticReport struct {
	numberOfLines int
	lineBits      []int
}

func newDiagnosticReport(lineSize int) *DiagnosticReport {
	lineBits := make([]int, lineSize)
	for i := 0; i < lineSize; i++ {
		lineBits[i] = 0
	}
	return &DiagnosticReport{numberOfLines: 0, lineBits: lineBits}
}

func (d *DiagnosticReport) addLine(line string) {
	d.numberOfLines++

	for pos, c := range line {
		n, _ := strconv.Atoi(string(c))
		d.lineBits[pos] += n
	}
}

func (d *DiagnosticReport) getBits(useMostCommon bool) string {
	half := d.numberOfLines / 2

	bits := ""
	for _, bitCount := range d.lineBits {
		if bitCount > half {
			bits += Btos(useMostCommon)
		} else {
			bits += Btos(!useMostCommon)
		}
	}

	return bits
}

func (d *DiagnosticReport) getGammaRate() int {

	gammaBits := d.getBits(true)
	value, _ := strconv.ParseInt(gammaBits, 2, 64)

	return int(value)
}

func (d *DiagnosticReport) getEpsilonRate() int {

	epsilonBits := d.getBits(false)
	value, _ := strconv.ParseInt(epsilonBits, 2, 64)

	return int(value)
}

func main() {
	file, err := os.Open(Input)
	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()

	scanner := bufio.NewScanner(file)

	var report *DiagnosticReport

	for scanner.Scan() {
		if report == nil {
			report = newDiagnosticReport(len(scanner.Text()))
		}
		report.addLine(scanner.Text())
	}

	gamma := report.getGammaRate()
	epsilon := report.getEpsilonRate()

	fmt.Printf("Gamma: %d\n", gamma)
	fmt.Printf("Epsilon: %d\n", epsilon)
	fmt.Printf("Checksum: %d\n", gamma*epsilon)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
