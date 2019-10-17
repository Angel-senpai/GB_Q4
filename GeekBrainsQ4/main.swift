//
//  main.swift
//  GeekBrainsQ4
//
//  Created by Даниил Мурыгин on 17.10.2019.
//  Copyright © 2019 Мурыгин Даниил. All rights reserved.
//

import Foundation


struct PlaneInfo {
    
    let mark:String
    
    let year:Date
    
    let color:CGColor
    
    let weightCapasity:Double
    
}

class Plane{
    
    enum EngineDo:String {
        case on = "Включен"
        case off = "Выключен"
    }
    enum WindowDo:String {
        case open = "Открыты"
        case close = "Закрыты"
    }
    enum Baggage {
        case addBaggage, getBaggage
    }
    enum GetInfo {
        case min,full
    }
    
    let info:PlaneInfo
    
    private(set) var engine: EngineDo = .off
    private(set) var window: WindowDo = .close
    private(set) var filledWeight: Double = 0
    
    init(_ planeInfo:PlaneInfo) {
        info = planeInfo
    }
    
    func planeWindow(_ state: WindowDo){
           self.window = state
       }

    func planeEngine(_ state: EngineDo){
           self.engine = state
       }
    
    func getInfo(infoCount:GetInfo){
        switch infoCount {
        case .min:
            print("Марка самолета:\(info.mark)",
                    "\nГод выпуска:\(info.year)",
                    "\nЦвет:\(info.color)")
        case .full:
            print("Марка самолета:\(info.mark)",
                    "\nГод выпуска:\(info.year)",
                    "\nЦвет:\(info.color)",
                    "\nЗаполнено грузом:\(filledWeight)|из|\(info.weightCapasity)",
                    "\nДвигатель:\(engine.rawValue)",
                    "\nОкна:\(window.rawValue)")
        }
    }
    
    func fillOrGetBaggage(_ value: Double, _ action: Baggage){
        
        switch action {
            case .addBaggage where value <= 0:
                print("Добавлено дуновение ветра")
        case .addBaggage where filledWeight + value > info.weightCapasity:
                print("Вместимость груза превышена!")
            case .addBaggage:
                filledWeight += value
                
            case .getBaggage where value >= filledWeight:
                filledWeight = 0
            case .getBaggage where value < 0:
            filledWeight += value
            case .getBaggage:
                filledWeight -= value
        }
    }
}

final class SportPlane: Plane {
    
    enum BoostSpeed:String {
        case on = "Включено"
        case off = "Выключено"
    }
    
    let maxSpeed:Double
    private(set) var boost:BoostSpeed = .off
    
    
    init(_ planeInfo:PlaneInfo,maxSpeed:Double) {
        
        let info = PlaneInfo(mark: planeInfo.mark,
                             year: planeInfo.year,
                             color: planeInfo.color,
                             weightCapasity: 0)
        self.maxSpeed = maxSpeed
        super.init(info)
    }
    
    func boostSpeed(_ action: BoostSpeed) {
        boost = action
    }
    
    override func fillOrGetBaggage(_ value: Double, _ action: Plane.Baggage) {
        print("Для облегчения конструкции спортивные самолеты были лишены возможности добавления груза на борт")
    }
    
    override func getInfo(infoCount: Plane.GetInfo) {
        switch infoCount {
          case .min:
              print("Марка самолета:\(info.mark)",
                      "\nГод выпуска:\(info.year)",
                        "\nЦвет:\(info.color)")
          case .full:
              print("Марка самолета:\(info.mark)",
                        "\nГод выпуска:\(info.year)",
                        "\nЦвет:\(info.color)",
                        "\nТурбо:\(boost.rawValue)",
                        "\nДвигатель:\(engine.rawValue)",
                        "\nОкна:\(window.rawValue)")
          }
    }
    
}

final class Fighter:Plane{
    
    enum WeaponSystem:String{
        case on = "К бою готов"
        case off = "Боевые системы отключены"
    }
    
    private(set) var system:WeaponSystem = .off
    private(set) var amunitionCount:Int
    private(set)var rocketCount:Int
    
    init(_ planeInfo:PlaneInfo, weaponfulling:Int,countRocket:Int) {
        
        let info = PlaneInfo(mark: planeInfo.mark,
                             year: planeInfo.year,
                             color: planeInfo.color,
                             weightCapasity: 0)
        
        self.amunitionCount = weaponfulling
        self.rocketCount = countRocket
        
        super.init(info)
    }
    
    func fireInTheGun(_ countPuyPuy: Int){
        if system != .on {
            print("Ошибка!\nСистемы не в боевой готовности")
            return
        }
        if amunitionCount - countPuyPuy < 0 {
            print("Патроны закончились!")
            amunitionCount = 0
            return
        }
        print("Произведен огонь из орудий")
        amunitionCount -= countPuyPuy
        print("Осталось патрон в основном орудии --- \(amunitionCount)")
    }
    
    func systemFighter(_ action:WeaponSystem) {
        system = action
    }
    
    func  rocketFire(_ countRocket: Int){
        if system != .on {
            print("Ошибка!\nСистемы не в боевой готовности")
            return
        }
        if amunitionCount - countRocket < 0 {
            print("Ракеты закончились!")
            rocketCount = 0
            return
        }
        
        print("Произведен запуск ракет")
        
        rocketCount -= countRocket
        print("Осталось ракет --- \(rocketCount)")
    }
    
    func reload(amunition:Int,rocket:Int) {
        
        amunitionCount = amunition
        rocketCount = rocket
        
        print("Произведена перезарядка!")
        
    }
    
    override func fillOrGetBaggage(_ value: Double, _ action: Plane.Baggage) {
           print("Для облегчения конструкции боевые самолеты были лишены возможности добавления груза на борт")
       }
    override func planeWindow(_ state: Plane.WindowDo) {
        print("Для большей безопасности была отключена возможность открытия окон в боевых самолетах")
    }
    
    override func getInfo(infoCount: Plane.GetInfo) {
        switch infoCount {
            
          case .min:
              print("Марка самолета:\(info.mark)",
                      "\nГод выпуска:\(info.year)",
                        "\nЦвет:\(info.color)")
          case .full:
              print("Марка самолета:\(info.mark)",
                        "\nГод выпуска:\(info.year)",
                        "\nЦвет:\(info.color)",
                        "\nКоличество боекомплекта пушки:\(amunitionCount)",
                        "\nКоличество ракет:\(rocketCount)",
                        "\nСтатус боевых систем:\(system)",
                        "\nДвигатель:\(engine.rawValue)",
                        "\nОкна:\(window.rawValue)")
          }
    }
    
}


var plane = Plane(PlaneInfo(mark: "Boeng",
                            year: Date(),
                            color: .black,
                            weightCapasity: 100_000))

plane.fillOrGetBaggage(66_000, .addBaggage)
plane.planeEngine(.on)

plane.getInfo(infoCount: .full)

var sportPlane = SportPlane(PlaneInfo(mark: "bigBoy",
                                      year: Date(),
                                      color: .white,
                                      weightCapasity: 100),
                            maxSpeed: 1200)

sportPlane.boostSpeed(.on)
sportPlane.planeEngine(.on)

sportPlane.getInfo(infoCount: .full)


var warPlane = Fighter(PlaneInfo(mark: "Mig-17",
                                 year: Date(),
                                 color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                 weightCapasity: 100),
                       weaponfulling: 1000,
                       countRocket: 15)

warPlane.fireInTheGun(10)
warPlane.fillOrGetBaggage(19, .addBaggage)
warPlane.planeWindow(.close)
warPlane.systemFighter(.on)
warPlane.rocketFire(10)

warPlane.getInfo(infoCount: .full)
