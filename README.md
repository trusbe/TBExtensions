# TBExtensions
This project mainly concentrates on some commonly used extension interfaces, which is convenient for rapid project development using Swift.

## Installation

#### CocoaPods

If you're using CocoaPods, just add this line to your Podfile:

```ruby
pod 'TBExtensions'
```

Install by running this command in your terminal:

```sh
pod install
```

Then import the library in all files where you use it:

```swift
import TBExtensions
```

## Usage

### extension Data
```swift
let  dataStr = "FFFE"
let data0 = Data(hex: dataStr)
data0?.hex
let data1 = Data([0x7f, 0x32, 0x33, 0x34])
data1.toString(as: .utf8)
data1.utf8String
data1.byte(at: 0)
data1.bytes()


let rData = Data.randomData(length: 5)
rData.hex
let index1 = Data([0x7f])
let index2 = Data([0x7f, 0x7f])
let index3 = Data([0x7f, 0x7f, 0x7f, 0x7f])
let index4 = Data([0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f])

index1.int8
index2.int16Little
index3.int32Little

index1.uint8
index2.uint16Little
index3.uint32Little

index2.int16Big
index3.int32Big
//index4.int64Big

index2.uint16Big
index3.uint32Big

```

### extension String
```swift
let str = "FE"
str.u8HexToDecimal
str.u8HexToBinary

let binary = "11101111"
binary.u8BinaryToDecimal
binary.u8BinaryToHex

let str16 = "FFFE"
str16.u16HexToDecimal
str16.u16HexToBinary

let binary16 = "1111111111111110"
binary16.u16BinaryToDecimal
binary16.u16BinaryToHex


let strL = "FFFFFFFFFFFFFE"
strL.utf8Data?.hex
strL.bytes
strL.data.hex

```

## Author and License

MIT License

Copyright (c) 2018 TrusBe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

