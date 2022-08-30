package main
  import "fmt"
  func main() {
    var foot float64
      fmt.Print("Type foot: ")
      fmt.Scanf("%f", &foot)           
      result := foot * 0.3048 
      fmt.Println("Meters:", result )
        }
