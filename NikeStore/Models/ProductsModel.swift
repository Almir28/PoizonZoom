//
//  Products.swift
//  NikeStore
//
//  Created by Almir Khialov on 19.06.2024.
//

import FirebaseFirestore
import FirebaseCore
import SwiftUI

struct ProductsModel: Identifiable, Hashable, Codable {
    var id: String
    var title: String
    var brand: String
    var description: String
    var images: [String]
    var sizes: [Int]
    var reviews: [ReviewModel]
    var price: Int
    var category: String // Убедитесь, что это свойство существует
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ProductsModel, rhs: ProductsModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ReviewModel: Identifiable, Hashable, Codable {
    var id: String
    var userName: String
    var image: String
    var review: String
    var rating: Int
}

struct BrandModel: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

var sampleReview: ReviewModel = .init(id: "abc", userName: "Naveen", image: "", review: "Крутые кроссовки...", rating: 4)


//КРОССОВКИ
let sampleProducts: [ProductsModel] = [
    .init(id:"U2L1LApbPtqYbJlT7xKV", title: "Nike Dunk Low Retro", brand:"Nike", description: "Познакомьтесь с новым поколением технологии Dunk. Nike Dunk Low Retro оснащены нашей системой динамической воздушной подушки с двумя трубками с разным давлением, создающей реактивное ощущение при каждом шаге. Это приводит к футуристическому дизайну, достаточно комфортному для ношения от дня до ночи. Вперед - почувствуйте нереальное.", images: ["https://static.street-beat.ru/upload/resize_cache/iblock/a17/500_500_1/soizqi5ywi0pnjwjn8ogjo09ys9zq20n.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/837/500_500_1/ie5jhewaal81r661abg1cclgtsjepwd0.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/8ca/500_500_1/s4474sw8kvdivcaekmqip8a741bc4o95.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/ea1/500_500_1/c0h9xo9nldrmw6vqem9dgo1uxpzo6vqo.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/e2b/500_500_1/pu18ei25al6i39y2pdz0qbe2anoi6p3s.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/b12/500_500_1/qzlpiyufnkxlmovhmpdjnqpu546k1m50.jpg"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 12900, category: "Shoes"),


    
    
        .init(id:"qgRIZcTKto07Tvxpq9oh", title: "Nike Air Force 1 '07 SE", brand:"Nike", description: "Созданные для игры на паркете, но привнесенные в уличную моду, эти иконические баскетбольные кроссовки 80-х годов возвращаются с классическими деталями и стилем прошлых лет. Синтетические кожаные наложения придают кроссовкам Nike Dunk винтажный вид, а мягкий низкий воротник обеспечивает комфорт и позволяет вам играть где угодно.", images: ["https://static.street-beat.ru/upload/resize_cache/iblock/0ea/500_500_1/m8n3pmkzxdacr11nv7v9lqgjqt2hhadb.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/34a/500_500_1/ihdpzxix8hweq47uwv40g83nbaiolfyu.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/360/500_500_1/xkpl8fwprl4t3njvghz7vh380ktpe3q7.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/747/500_500_1/vluo1969os2t9nynr2cizg0fg7r6jsf7.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/02b/500_500_1/ib6nu3yxokzbzkggvmo0mab6mhuhv9lt.jpg"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 15900, category: "Shoes"),
    
    
        .init(id:"JKx96wsgTgfJokK6iLrF", title: "Nike Air Force 1 07", brand:"Nike", description: "Приветствуйте следующее поколение технологии Air. Air Max Dn оснащен нашей системой динамической воздушной единицы с двумя давлением, создающей реактивное ощущение с каждым шагом. Это приводит к футуристическому дизайну, достаточно комфортному для ношения от дня до ночи. Вперед - почувствуйте нереальное.", images: ["https://static.street-beat.ru/upload/resize_cache/iblock/13d/500_500_1/rqhnwkorv3j46k355wtb3cm3ey7vu23v.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/221/500_500_1/3phflk5f551rf7ioxqd5negapjj0upmu.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/b59/500_500_1/3f6n9kdwtxbnq0crmbe01dnhagy85eku.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/26e/500_500_1/4vmxyjji3yupbsocm161o2yj6ak2szy6.jpg","https://static.street-beat.ru/upload/resize_cache/iblock/2bb/500_500_1/r5ht27jofub2vqdw4tp8dvgkkrjcxvi3.jpg"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 9900, category: "Shoes"),
    
    
    
    
    
    
    
    
 //Adidas
    
        .init(id:"lEGq0RJgr8Fe5Fgg1YhJ", title: "GAZELLE SHOES", brand:"Adidas", description: "Верно воссоздавая любимый дизайн 1991 года, эти кроссовки adidas Gazelle демонстрируют премиальный верх из замши с мягким ворсом и минималистичный стиль 90-х. Подошва из резины обеспечивает комфорт на протяжении всего дня и надежное сцепление, будь то прогулка по городским улицам или приключения вдали. Эти кроссовки, возрождение классического наследия, связывают вас с десятилетиями спорта и культуры с каждым шагом.", images: ["https://assets.adidas.com/images/w_1880,f_auto,q_auto/a200a8d34e654a3aafeba80b016c5b10_9366/BY9144_01_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/f6826fcf04254c21876fa6bb00dcf216_9366/BY9144_02_standard_hover.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/4d08e5ca755443a9bcc8a6bb00dce9ef_9366/BY9144_03_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/b7f1075ce6254f0db97ca80b016c8b2e_9366/BY9144_04_standard.jpg"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 14900, category: "Shoes"),
    
        .init(id:"WFxsBDANU1xpkTnTiucU", title: "HANDBALL SPEZIAL SHOES", brand:"Adidas", description: "КЛАССИЧЕСКИЕ КОРТОВЫЕ КРОССОВКИ, ВОЗВРАЩЕННЫЕ В СОВРЕМЕННОСТЬ. Вступите в ретро-стиль и комфорт на весь день с этими кроссовками adidas Handball Spezial. Изначально разработанные для занятий в помещении в 70-х годах, эта пара низкопрофильных кроссовок готова покорять корт и улицы. Премиальный верх из замши дополнен контрастной строчкой для акцента современной элегантности, в то время как дизайн T-образного мыска сохраняет внешний вид в прошлом.", images: ["https://assets.adidas.com/images/w_940,f_auto,q_auto/6218f8cc55984cfe92d1a96d0110ac7e_9366/DB3021_01_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/96c5eb48a9074ee9889aa96d0110ca89_9366/DB3021_02_standard_hover.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/89ca78bab363419a82ffa96d0110db67_9366/DB3021_03_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/89ca78bab363419a82ffa96d0110db67_9366/DB3021_03_standard.jpg"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 12900, category: "Shoes"),
    
    
    
        .init(id:"hZLJqTgasltaD94429RU", title: "HANDBALL SPEZIAL SHOES", brand:"Adidas", description: "КЛАССИЧЕСКИЕ КОРТОВЫЕ КРОССОВКИ, ВОЗВРАЩЕННЫЕ В СОВРЕМЕННОСТЬ. Вступите в ретро-стиль и комфорт на весь день с этими кроссовками adidas Handball Spezial. Изначально разработанные для занятий в помещении в 70-х годах, эта пара низкопрофильных кроссовок готова покорять корт и улицы. Премиальный верх из замши дополнен контрастной строчкой для акцента современной элегантности, в то время как дизайн T-образного мыска сохраняет внешний вид в прошлом.", images: ["https://assets.adidas.com/images/w_940,f_auto,q_auto/685ed00544c04291bc642f27b1056694_9366/IG6191_01_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/a9c4a01410b74803870eaa52ef60a55f_9366/IG6191_02_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/3cb15356f15742d6b033cabb937dba58_9366/IG6191_03_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/72dec985a1414dd9bc0a338e54b12fcd_9366/IG6191_04_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/c742a67340d345cfa0d1f34346dfbea9_9366/IG6191_05_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/0874c4d489874c04b14747f0a9da656c_9366/IG6191_06_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/4d8123242d0046628b160719b93aa6a2_9366/IG6191_09_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/3515f634ce0146a99273dda7b31c059e_9366/IG6191_15_hover_standard.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/e6c37249359c4b81840c13e550f8757a_9366/IG6191_41_detail.jpg","https://assets.adidas.com/images/w_1880,f_auto,q_auto/465611a2a4e3405db18f2bef7ef28a81_9366/IG6191_42_detail.jpg"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 14900, category: "Shoes"),
    
    
    
    
    
    
    
    
  //Puma
        .init(id:"FtP4FwHWSuPOYoPH9Gyi", title: "FENTY x PUMA Creeper Phatty", brand:"Puma", description: "Rihanna и PUMA приходят на землю с Creeper Phatty Earth Tone. Изготовленные из роскошной, высококачественной замши, новые FENTY x PUMA", images: ["https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/399865/02/sv01/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/mod01/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/mod02/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/sv03/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/sv04/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/dt01/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/dt02/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/dt03/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/399865/01/dt05/fnd/PNA/fmt/png/FENTY-x-PUMA-Creeper-Phatty-Earth-Tone-Women's-Sneakers"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 9900, category: "Shoes"),
    
    
        .init(id:"6n2GJDLkxB5CKuQLnvHt", title: "PUMA x BMW M MOTORSPORT", brand:"Puma", description: "Слияние увлекательного мира искусства, автомобилей и моды, PUMA x BMW M Motorsport создали уникальную капсулу в ограниченном количестве.", images: ["https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/sv01/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/mod01/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/mod01/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/bv/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/sv02/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/sv03/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/sv04/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/dt01/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_900,h_900/global/308184/01/dt02/fnd/PNA/fmt/png/PUMA-x-BMW-M-MOTORSPORT-Suede-Calder-Men's-Sneakers"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 11900, category: "Shoes"),
    
        .init(id:"RO9HKmOcjY6wOWVzW2Be", title: "LOVE MARATHON CA Pro Sneakers",brand:"Puma", description: "Завяжи шнурки и гордо стань с LOVE MARATHON CA Pro Sneakers. Украшенные вдохновленной гордостью цветовой гаммой, эти кроссовки привносят", images: ["https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/sv01/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/mod01/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/mod02/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/bv/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/sv02/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/sv03/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers","https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1050,h_1050/global/398576/01/sv04/fnd/PNA/fmt/png/LOVE-MARATHON-CA-Pro-Sneakers"],sizes: [40, 41, 42, 43, 44, 45, 46], reviews: [sampleReview], price: 10900, category: "Shoes"),
    

   //-----------------------------------------------------------------------------------------------------------------------------------------------------
    
    //Bottoms
    
    //Vakko
    .init(id:"JM3Sh1rzTZVgAWVWggnx",
          title: "VİZON PANTOLON",
          brand:"Vakko",
          description: "Визоновые брюки Vakko выделяются боковыми карманами и окантовкой задних карманов. Эта модель, привлекающая внимание своим хлопковым смешанным материалом, имеет застежку на молнию и пуговицу.",
          images: ["https://cdn.vakko.com/mnresize/595/892/8683820482649-01.jpg",
                   "https://cdn.vakko.com/mnresize/595/892/8683820482649-02.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-03.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-04.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-05.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-06.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-07.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-08.jpg",
                   "https://cdn.vakko.com/mnresize/394/590/8683820482649-09.jpg"
                  ],
          sizes: [46, 48, 50 ,52, 54, 56, 58, 60],
          reviews: [sampleReview],
          price: 19000,
          category: "Bottoms"),
    
    
        .init(id:"bWErVT0AdzuYGWY17fUK",
              title: "ЗЕЛЕНАЯ ТОЛСТОВКА С КАПЮШОНОМ",
              brand:"Vakko",
              description: "Светло-зеленая толстовка с длинным рукавом Vakko привлекает внимание своей хлопчатобумажной тканью и передними карманами. Эта модель, которая выделяется капюшоном с кружевом, имеет застежку-молнию в передней средней части.",
              images: [ "https://cdn.vakko.com/mnresize/595/892/8683820803499-01.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-02.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-03.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-04.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-05.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-06.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-07.jpg",
                        "https://cdn.vakko.com/mnresize/595/892/8683820803499-08.jpg"
                        
                      ],
              sizes: [46, 48, 50 ,52, 54, 56],
              reviews: [sampleReview],
              price: 17900,
              category: "Tops"),
        
    ]
    
