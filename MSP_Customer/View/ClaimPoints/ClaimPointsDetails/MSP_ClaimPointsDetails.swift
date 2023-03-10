//
//  MSP_ClaimPointsDetails.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 07/02/23.
//

import UIKit
import SDWebImage
import CoreData
import Firebase
import Lottie

class MSP_ClaimPointsDetails: BaseViewController, popUpDelegate, SendDetailsDelegate1 {
  
    
    
        func statusDipTap(_ vc: MSP_DropDownVC) {}
        func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {}
        func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
        
        func qtyValue(_ cell: MSP_ClaimPointsDetailsTVC) {
            guard let tappedIndexPath = self.claimPointListTableView.indexPath(for: cell) else{return}



            if cell.qtyTF.tag == Int("\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")") {
                print("\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")")
                let finalValues = cell.remarksTF.text ?? ""
                let finalValue = cell.qtyTF.text ?? ""
                cell.qtyTF.text = finalValue

                let a = 1000
                let cellQty = finalValue
                let divideData = Double(a) * (Double(cellQty) ?? 0)
                print(divideData,"kjhdksjhdk")
    //            cell.qtyKGTF.text = "\(divideData)"


                let filterValue = String(divideData)

                let filteredValue = filterValue.split(separator: ".")
                print(filterValue)
                if filteredValue.count > 1{
                    if filteredValue[1].count <= 3{
                        cell.qtyKGTF.text = "\(divideData)"
                    }else if filteredValue[1].count >= 3{
                     print("Clear")
                        let filteerValue = String(filteredValue[1]).prefix(3)
                        print(filteerValue)
                       let finalval = "\(filteredValue[0]).\(filteerValue)"
                        print(finalval)
                        cell.qtyKGTF.text = "\(finalval)"
                        self.quantityKGValues = "\(finalval)"

                    }else{
                        cell.qtyKGTF.text = "\(divideData)"
                    }
                }else if filteredValue.count == 1{
                    if filteredValue[1].count <= 3{
                        cell.qtyKGTF.text = "\(divideData)"
                    }else{
                     print("Clear")
                        let filteerValue = String(filteredValue[0]).prefix(3)
    //                   let finalval = "\(filteredValue[0]).\(filteerValue)"
                        cell.qtyKGTF.text = "\(filteerValue)"
                    }
                }else{
                    cell.qtyKGTF.text = "\(divideData)"
                }


                if finalValue  == "0" || finalValue == "0.0" || filterValue == "0.0" || filterValue == "0"{
                    self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                    print(filterArray.count)
                    if filterArray.count >= 1{
                       
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                        selectedQty.qunantity = ""
                        selectedQty.quantityKG = ""
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                        persistanceservice.context.delete(claimToRemove)
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                    }
                }else if finalValue != "" && finalValue != "0" && finalValue != " " && finalValue != "-1" && finalValue != "00" && finalValue != "000" && finalValue != "0000"  && finalValue != "0000" && finalValue != "00000" && finalValue != "000000" && finalValue != "0000000" && finalValue != "00000000" && finalValue != "000000000" && finalValue != "0000000000" {

                    if finalValue.contains("."){
                        print("Go for next")
                        let sortedBy = finalValue.split(separator: ".")
                        print(sortedBy, "sortedBy")
                        print(sortedBy.count)
                        if sortedBy.count > 1 {

                            if sortedBy[1].count <= 3{
                                
                                

                                self.quantity.append(finalValue)
                                let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                selectedQty.qunantity = "\(Double(finalValue) ?? 0)"
                                print("\(quantityKGValues)")
                                selectedQty.quantityKG = "\(divideData)"
                                selectedQty.remarks = "\(finalValues)"
                                persistanceservice.saveContext()
                                self.fetchCartDetails()
                                
                                let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                print(filterArray.count)
                                if filterArray.count > 1{
                                    let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                    persistanceservice.context.delete(claimToRemove)
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                }
                                
                            }else if sortedBy[1].count > 3{
                                let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                print(filterArray.count)
                                if filterArray.count >= 1{
                                    let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                    selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                    selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                    selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                    selectedQty.qunantity = ""
                                    selectedQty.quantityKG = ""
                                    selectedQty.remarks = "\(finalValues)"
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                    let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                    persistanceservice.context.delete(claimToRemove)
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                }
                            }
                        }else{
                           // print(sortedBy[0])
                            if sortedBy.count == 1 {
                                if sortedBy[0].count <= 3{
                               
                                    self.quantity.append(finalValue)
                                    let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                    selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                    selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                    selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                    selectedQty.qunantity = "\(Double(finalValue) ?? 0)"
                                    selectedQty.quantityKG = "\(divideData)"
                                    selectedQty.remarks = "\(finalValues)"
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                    print(filterArray.count)
                                    if filterArray.count > 1{
                                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                        persistanceservice.context.delete(claimToRemove)
                                        persistanceservice.saveContext()
                                        self.fetchCartDetails()
                                    }
                                }else if sortedBy[0].count > 3{
                                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                    print(filterArray.count)
                                    if filterArray.count >= 1{
                                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                        selectedQty.qunantity = ""
                                        selectedQty.quantityKG = ""
                                        selectedQty.remarks = "\(finalValues)"
                                        persistanceservice.saveContext()
                                        self.fetchCartDetails()
                                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                        persistanceservice.context.delete(claimToRemove)
                                        persistanceservice.saveContext()
                                        self.fetchCartDetails()
                                    }
                                }
                            }else{
                                self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                                let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                print(filterArray.count)
                                if filterArray.count >= 1{
                                    let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                    selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                    selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                    selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                    selectedQty.qunantity = ""
                                    selectedQty.quantityKG = ""
                                    selectedQty.remarks = "\(finalValues)"
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                    let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                    persistanceservice.context.delete(claimToRemove)
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                }
                            }

                        }

                    }else{
                          
                        self.quantity.append(finalValue)
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                        selectedQty.qunantity = "\(Double(finalValue) ?? 0)"
                        selectedQty.quantityKG = "\(divideData)"
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                        print(filterArray.count)
                        if filterArray.count > 1{
                            let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                            persistanceservice.context.delete(claimToRemove)
                            persistanceservice.saveContext()
                            self.fetchCartDetails()
                        }
                    }


                }else{
                    self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                    print(filterArray.count)
                    if filterArray.count > 1{
                        
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                        selectedQty.qunantity = ""
                        selectedQty.quantityKG = ""
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                        persistanceservice.context.delete(claimToRemove)
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                    }

                }
            }
        }
        
        
        func qtyKgValue(_ cell: MSP_ClaimPointsDetailsTVC) {
            guard let tappedIndexPath = self.claimPointListTableView.indexPath(for: cell) else{return}
            print(Int("\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"),"Prd")
            if cell.qtyKGTF.tag == Int("\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")") {
                print(cell.qtyKGTF.text?.count,"kudhsush")
                let finalValues = cell.remarksTF.text ?? ""
                let finalValue = cell.qtyKGTF.text ?? ""
                cell.qtyKGTF.text = finalValue
                print(finalValue,"dhskjhdk")
                print(Double(finalValue)?.rounded(), "RoundedValue")

                let filteredValuess = finalValue.split(separator: ".")
                print(filteredValuess)
                if filteredValuess.count > 1{
                    print(filteredValuess[0])
                    print(filteredValuess[1])
                    let firstHalf = "\(filteredValuess[0])".last
                    let secondHalf = "\(filteredValuess[1])".first
                    print("\(firstHalf)")
                    print("\(secondHalf)")

                    if Int("\(secondHalf!)")! > Int("\(firstHalf!)")! &&  Int("\(secondHalf!)")! >= 5{
                        //let calc = "\(firstHalf!)" + 1
                        let calc = Int("\(firstHalf!)")! + 1
                        self.finalCalcValuess = "\(calc)"
                        print(calc)
                        print(self.finalCalcValuess)
                    }else{
                        self.finalCalcValuess = "\(firstHalf!)"
                    }
                }


                let a = 1000
                let cellQty = finalValue
                let divideData = (Double(cellQty) ?? 0) / Double(a)
                print(divideData,"Qsdfsadfsdafasdf")


                let filterValue = String(divideData)

                let filteredValue = filterValue.split(separator: ".")
                print(filteredValue.count)

                if filteredValue.count > 1{
                    if filteredValue[1].count <= 3{
                        cell.qtyTF.text = "\(divideData)"
                    }else if filteredValue[1].count >= 3{
                     print("Clear")
                        let filteerValue = String(filteredValue[1]).prefix(2)
                        print(filteerValue)
                        let finalval = "\(filteredValue[0]).\(filteerValue)\(self.finalCalcValuess)"
                        print(finalval)
                        cell.qtyTF.text = "\(finalval)"
                        self.quantityValue = "\(finalval)"

                    }
                }else if filteredValue.count == 1{
                    if filteredValue[1].count <= 3{
                        cell.qtyTF.text = "\(divideData)"
                        self.quantityValue = "\(divideData)"
                    }else{
                     print("Clear")
                        let filteerValue = String(filteredValue[0]).prefix(3)
    //                   let finalval = "\(filteredValue[0]).\(filteerValue)"
                        cell.qtyTF.text = "\(filteerValue)"
                        self.quantityValue = "\(filteerValue)"
                    }
                }

                    if finalValue  == "0" || finalValue == "0.0" || filterValue == "0.0" || filterValue == "0" || self.quantityValue == "0.0" || self.quantityValue == "0.00" || self.quantityValue == "0.000"{
                    self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                    print(filterArray.count)
                    if filterArray.count >= 1{
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                        selectedQty.qunantity = ""
                        selectedQty.quantityKG = ""
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                        persistanceservice.context.delete(claimToRemove)
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                    }
                }else if finalValue != "" && finalValue != "0" && finalValue != " " && finalValue != "-1" && finalValue != "00" && finalValue != "000" && finalValue != "0000"  && finalValue != "0000" && finalValue != "00000" && finalValue != "000000" && finalValue != "0000000" && finalValue != "00000000" && finalValue != "000000000" && finalValue != "0000000000" {

                    if finalValue.contains("."){
                        print("Go for next")
                        let sortedBy = finalValue.split(separator: ".")
                        print(sortedBy, "sortedBy")

                        if sortedBy.count > 1 {
                            if sortedBy[1].count <= 3{
                                self.quantityKG.append(finalValue)

                                let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"

                                selectedQty.quantityKG = "\(Double(finalValue) ?? 0)"

                                print("\(divideData)")
                                selectedQty.qunantity = "\(self.quantityValue)"
                                selectedQty.remarks = "\(finalValues)"
                                persistanceservice.saveContext()
                                self.fetchCartDetails()
                                
                                let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                print(filterArray.count)
                                if filterArray.count > 1{
                                    let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                    persistanceservice.context.delete(claimToRemove)
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                }
                            }else if sortedBy[1].count > 3{
                                let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                print(filterArray.count)
                                if filterArray.count >= 1{
                                  
                                    let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                    selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                    selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                    selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                    selectedQty.qunantity = ""
                                    selectedQty.quantityKG = ""
                                    selectedQty.remarks = "\(finalValues)"
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                    let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                    persistanceservice.context.delete(claimToRemove)
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                }
                            }
                        }else{
//                            print(sortedBy[0])
                            if sortedBy.count == 1 {
                                if sortedBy[0].count <= 3{

                                    self.quantityKG.append(finalValue)

                                    let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                    selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                    selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                    selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                    selectedQty.quantityKG = "\(Double(finalValue) ?? 0)"
                                    print("\(divideData)")
                                    selectedQty.qunantity = "\(divideData)"
                                    selectedQty.remarks = "\(finalValues)"
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                    
                                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                    print(filterArray.count)
                                    if filterArray.count > 1{
                                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                        persistanceservice.context.delete(claimToRemove)
                                        persistanceservice.saveContext()
                                        self.fetchCartDetails()
                                    }
                                }else if sortedBy[0].count > 3{
                                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                    print(filterArray.count)
                                    if filterArray.count >= 1{
                                       
                                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                        selectedQty.qunantity = ""
                                        selectedQty.quantityKG = ""
                                        selectedQty.remarks = "\(finalValues)"
                                        persistanceservice.saveContext()
                                        self.fetchCartDetails()
                                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                        persistanceservice.context.delete(claimToRemove)
                                        persistanceservice.saveContext()
                                        self.fetchCartDetails()
                                    }
                                }
                            }else{
                                self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                                let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                                print(filterArray.count)
                                if filterArray.count >= 1{
                                  
                                    let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                                    selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                                    selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                                    selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                                    selectedQty.qunantity = ""
                                    selectedQty.quantityKG = ""
                                    selectedQty.remarks = "\(finalValues)"
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                    let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                                    persistanceservice.context.delete(claimToRemove)
                                    persistanceservice.saveContext()
                                    self.fetchCartDetails()
                                }
                            }

                        }

                    }else{
                        self.quantityKG.append(finalValue)
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                        selectedQty.quantityKG = "\(Double(finalValue) ?? 0)"
                        selectedQty.qunantity = "\(divideData)"
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        
                        let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                        print(filterArray.count)
                        if filterArray.count > 1{
                            let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                            persistanceservice.context.delete(claimToRemove)
                            persistanceservice.saveContext()
                            self.fetchCartDetails()
                        }
                    }


                }else{
                    self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                    let filterArray = self.claimPointsDetailsArray.filter{Int($0.productId ?? "1") == Int(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1") }
                    print(filterArray.count)
                    if filterArray.count >= 1{
                    
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productCode ?? "")"
                        selectedQty.productId = "\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"
                        selectedQty.qunantity = ""
                        selectedQty.quantityKG = ""
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        let claimToRemove = self.claimPointsDetailsArray[tappedIndexPath.row]
                        persistanceservice.context.delete(claimToRemove)
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                    }

                }
            }
        }
        

        
        func remarksValue(_ cell: MSP_ClaimPointsDetailsTVC) {
            guard let tappedIndexPath = self.claimPointListTableView.indexPath(for: cell) else{return}
            if cell.remarksTF.tag == Int("\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"){
                let finalValues = cell.remarksTF.text ?? ""
               // cell.remarksTF.text = finalValues
                
                
                
                
                for data in self.claimPointsDetailsArray{
                    if Int(data.productId ?? "-1") == Int("\(self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1")"){
                        if data.qunantity ?? "" == "" && data.qunantity ?? "" == "0" && data.qunantity ?? "" == " " && data.quantityKG ?? "" == "" && data.quantityKG ?? "" == "0" && data.quantityKG ?? "" == " "{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "Enter quantiy"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)

                            }
                        }else{
                          
                                print(finalValues, "Entered Remarks")
                                data.productId = self.claimPointsDetailsArray[tappedIndexPath.row].productId ?? "-1"
                                data.remarks = finalValues
                                print(data.remarks,"ksjdksj")
                                //data.qunantity = cell.qtyTF.text ?? ""
                                print(data.qunantity,"ererrer")
                                //data.quantityKG = cell.qtyKGTF.text ?? ""
                                print(data.quantityKG,"dfdf")
                                persistanceservice.saveContext()

                                self.fetchCartDetails()
                        }
                    }
                    

                }


            }
            self.claimPointListTableView.reloadData()
        }
        
        func dealerDipTap(_ vc: MSP_DropDownVC) {
            self.selectDealerlbl.text = vc.selectedDealerName
            self.selectedDealerId = vc.selectedDealerId
            print(vc.selectedDealerId)
        }
    
        
        
        @IBOutlet var selectDealerView: UIView!
        @IBOutlet weak var noDataFoundLbl: UILabel!
        @IBOutlet weak var selectDealerlbl: UILabel!
        @IBOutlet weak var countLbl: UILabel!
        @IBOutlet var selectDelarLbl: UILabel!
        @IBOutlet weak var submitBtn: GradientButton!
        @IBOutlet weak var claimPointListTableView: UITableView!
        @IBOutlet weak var loaderAnimatedView: AnimationView!
        @IBOutlet weak var loaderView: UIView!
        private var animationView11: AnimationView?
        
        @IBOutlet var searchPointsArrayTF: UITextField!
        @IBOutlet var searchview: UIView!
        var fromSideMenu = ""
        let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
        var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
        var claimPointsDetailsArray = [ClaimPointsArray]()
        var VM1 = HistoryNotificationsViewModel()
        var VM = ClaimPointDetailsVM()
        var selectedDealerId = -1
        var enteredQty = 0
        var enteredRemarks = ""
        var enteredProductCode = ""
        var newproductArray: [[String:Any]] = []
        var productCode = [String]()
        var quantity = [String]()
        var remarks = [String]()
        var quantityKG = [String]()
        var afterFilteredValue = [String]()
        
        var quantityValue = ""
        var quantityKGValues = ""
        var finalCalcValuess = ""
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.VM.VC = self
           // self.clearTable()
            self.newproductArray.removeAll()
            self.loaderView.isHidden = true
            self.noDataFoundLbl.isHidden = true
           // self.submitBtn.isHidden = false
            self.claimPointListTableView.register(UINib(nibName: "MSP_ClaimPointsDetailsTVC", bundle: nil), forCellReuseIdentifier: "MSP_ClaimPointsDetailsTVC")
            self.claimPointListTableView.delegate = self
            self.claimPointListTableView.dataSource = self
//            self.claimPointListTableView.estimatedRowHeight = 100
//            self.claimPointListTableView.rowHeight = UITableView.automaticDimension
         //   self.claimPointListTableView.reloadData()
            
        

            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.loaderView.isHidden = true
            self.fetchCartDetails()
            
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "Claim Points")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])
        }
        
        @objc func goToDashoardApi() {
            self.navigationController?.popViewController(animated: true)
        }
        @objc func sendToClaimStatus() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_ClaimStatusVC") as! MSP_ClaimStatusVC
            //vc.isComingFrom = "ClaimPoints"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        @IBAction func notificationBtn(_ sender: Any) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        @IBAction func backBtn(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        
        
        @IBAction func submitButton(_ sender: Any) {
            print(selectedDealerId,"ID")
            print(claimPointsDetailsArray.count,"claimsCount")
           if self.claimPointsDetailsArray.count == 0{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Enter quantiy"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    
                }
            }else if self.claimPointsDetailsArray.count != 0{
                
                let filterArray = self.claimPointsDetailsArray.filter{$0.qunantity ?? "" == "0" || $0.qunantity ?? "" == "0.0" || $0.qunantity ?? "" == "" || $0.quantityKG ?? "" == "0.0" || $0.quantityKG ?? "" == ""}
                
                if filterArray.count != 0 {
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Enter quantiy"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                        
                    }
                }else{
                    let filterArray1 = self.claimPointsDetailsArray.filter{$0.remarks ?? "" == "" || $0.remarks?.count ?? 0 == 0 || $0.remarks?.isEmpty == true}
                    
                    if filterArray1.count != 0 {
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Enter Site Name & Contact"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }else{
                        self.claimPointsSubmissionApi()
                    }
                }
            }
        }
        
        func claimPointsApi(){
            self.VM.myClaimsPointsArray.removeAll()
            let parameters = [
                "ActorId": "\(userID)",
                "ProductDetails": [
                    "ActionType" : "18"
                ]
            ] as [String : Any]
            print(parameters)
            self.VM.claimPointsAPI(parameters: parameters) { response in
                self.VM.myClaimsPointsArray = response?.lsrProductDetails ?? []
                print(self.VM.myClaimsPointsArray.count, "Planner List Cout")
                DispatchQueue.main.async {
                    if self.VM.myClaimsPointsArray.count != 0 {
                        self.claimPointListTableView.isHidden = false
                        self.noDataFoundLbl.isHidden = true
                        self.claimPointListTableView.reloadData()
                        
                    }else{
                        self.claimPointListTableView.isHidden = true
                        self.noDataFoundLbl.isHidden = false
                        self.selectDealerView.isHidden = true
                        self.selectDelarLbl.isHidden = true
                    }
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }
        }
        
        
        func notificationListApi(){
            let parameters = [
                "ActionType": 0,
                "ActorId": "\(userID)",
                "LoyaltyId": self.loyaltyId
            ] as [String: Any]
            print(parameters)
            self.VM1.notificationListApi(parameters: parameters) { response in
                DispatchQueue.main.async {
                    self.loaderView.isHidden = true
                    self.stopLoading()
                    self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
                    print(self.VM1.notificationListArray.count)
                    
                    
                    if self.VM1.notificationListArray.count > 0{
                        self.countLbl.text = "\(self.VM1.notificationListArray.count)"
                    }else{
                        self.countLbl.isHidden = true
                    }
                    
                }
            }
            
        }
        
        
        func totalValues(){
            self.newproductArray.removeAll()
            for data in self.claimPointsDetailsArray{
                print(data.productCode,"kjhdj")
                if data.productCode ?? "" != ""{
                    let x = String("\(data.productCode ?? "")").split(separator: "~")
                    //print(x[1])
                    let collectedValues:[String:Any] = [
                        "ProductCode": "\(x[1])",
                        "Quantity": "\(data.qunantity ?? "")",
                        "Remarks": "\(data.remarks ?? "")"
                    ]
                    self.newproductArray.append(collectedValues)
                }
               
            }
        }
        
        
        func claimPointsSubmissionApi(){
            self.totalValues()
            let parameters = [
                "ActorId": "\(self.userID)",
                "ProductSaveDetailList": self.newproductArray as [[String: Any]],
                "RitailerId": self.selectedDealerId,
                "SourceDevice": 1
            ]as [String : Any]
            print(parameters)
            self.VM.claimPointsSubmissionApi(parameters: parameters) { response in
                DispatchQueue.main.async {
                    self.loaderView.isHidden = true
                    self.stopLoading()
                    print(response?.returnMessage ?? "", "Return Message")
                    if response?.returnMessage ?? "" == "1"{
                        
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ClaimPointsPopUpVC") as! MSP_ClaimPointsPopUpVC
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsComeFrom = "ClaimPointsSubmission"
                            vc!.descriptionInfo = "Claim points submission failed. Try again later!"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
            }
        }
        func playAnimation(){
                       animationView11 = .init(name: "Loader_v4")
                         animationView11!.frame = loaderAnimatedView.bounds
                         // 3. Set animation content mode
                         animationView11!.contentMode = .scaleAspectFit
                         // 4. Set animation loop mode
                         animationView11!.loopMode = .loop
                         // 5. Adjust animation speed
                         animationView11!.animationSpeed = 0.5
                        loaderAnimatedView.addSubview(animationView11!)
                         // 6. Play animation
                         animationView11!.play()

                   }
        
    }
    extension MSP_ClaimPointsDetails: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.claimPointsDetailsArray.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_ClaimPointsDetailsTVC") as? MSP_ClaimPointsDetailsTVC
            cell?.delegate = self
            cell?.selectionStyle = .none
            cell?.productNameLbl.text = self.claimPointsDetailsArray[indexPath.row].productName ?? ""
            cell?.qtyTF.tag = Int("\(self.claimPointsDetailsArray[indexPath.row].productId ?? "-1")") ?? -1
            cell?.qtyKGTF.tag = Int("\(self.claimPointsDetailsArray[indexPath.row].productId ?? "-1")") ?? -1
            cell?.remarksTF.tag = Int("\(self.claimPointsDetailsArray[indexPath.row].productId ?? "-1")") ?? -1
            cell?.qtyTF.text = self.claimPointsDetailsArray[indexPath.row].qunantity ?? ""
            cell?.remarksTF.text = self.claimPointsDetailsArray[indexPath.row].remarks ?? ""
            cell?.qtyKGTF.text = self.claimPointsDetailsArray[indexPath.row].quantityKG ?? ""
                   




            let imageUrl = self.claimPointsDetailsArray[indexPath.row].productImage ?? ""
            if imageUrl != " " || imageUrl != "" || imageUrl != nil{
                let totalImgURL = productCatalogueImgURL + imageUrl
                cell?.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "MSP-logo (1)"))
            }else{
                cell?.productImage.image = UIImage(named: "MSP-logo (1)")
            }


            return cell!
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 280
        }
        func fetchCartDetails(){
//            self.claimPointsDetailsArray.removeAll()
            let fetchRequest:NSFetchRequest<ClaimPointsArray> = ClaimPointsArray.fetchRequest()
            do{
                self.claimPointsDetailsArray = try persistanceservice.context.fetch(fetchRequest)
                print(self.claimPointsDetailsArray.count, "Saved Data")
                if self.claimPointsDetailsArray.count == 0{
                    self.submitBtn.isHidden = true
                    self.noDataFoundLbl.isHidden = false

                }else{
                    self.submitBtn.isHidden = false
                    self.noDataFoundLbl.isHidden = true
                    for data in self.claimPointsDetailsArray{
                        print(data.productId ?? "", "product Id")
                        print(data.qunantity ?? "", "quantity")
                        print(data.quantityKG ?? "", "quantity KG")
                    }
                }
                self.claimPointListTableView.reloadData()
            }catch{
                print("error while fetching data")
            }

        }
        func clearTable(){

            let context = persistanceservice.persistentContainer.viewContext

            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ClaimPointsArray")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    }
