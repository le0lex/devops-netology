package main
  import "fmt"
  func main() {
    x := []int{46,5,76,86,3,68,82,63,37,34,27,19,97,9,17,1,20,24,28}
    nul := 0
    for i, min := range x {
      if (i == 0) {
        nul = min
      } else {
        if (min < nul) {
          nul = min
        }
      }
      }
    fmt.Println("Hаименьший элемент: ", nul)
  }
