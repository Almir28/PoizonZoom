//
//  News.swift
//  NikeStore
//
//  Created by Almir Khialov on 01.07.2024.
//
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct NewsArticle: Identifiable, Codable {
    @DocumentID var id: String?
    let title: String
    let summary: String
    let content: String
    let imageURL: String
    let date: String
    let author: String
}

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = [
        NewsArticle(
                    title: "Travis Scott x Air Jordan 1 Low OG «Triple Mocha» выйдут в 2025 году",
                    summary:"Трэвис Скотт и Jordan продолжают расширять свое партнерство и выпустят в следующем году новую вариацию Air Jordan 1 Low под названием «Velvet Brown» или «‎Triple Mocha». Кроссовки станут в ряд с «Black Phantom», «Sail Black» и другими хайповыми выпусками низких «единичек» этого тандема.",
         
                    content: "Трэвис Скотт и Jordan продолжают расширять свое партнерство и выпустят в следующем году новую вариацию Air Jordan 1 Low под названием «Velvet Brown» или «‎Triple Mocha». Кроссовки станут в ряд с «Black Phantom», «Sail Black» и другими хайповыми выпусками низких «единичек» этого тандема.\nОни выполнены в коричнево-черной цветовой гамме из премиальной ворсистой замши с перфорацией на носке для лучшей вентиляции стопы. Большой перевернутый логотип Swoosh, а также фирменные детали Трэвиса Скотта подчеркивают дизайн, в том числе «Cactus Jack» на язычке, боковой панели и стельке.Кроме того, на заднике правого кроссовка изображен Air Jordan Wings, а на левом – знаменитый смайлик. Ниже можно найти живые фото и видео этого коллаба.\n\n**Дата выхода Travis Scott x Air Jordan 1 Low OG «Triple Mocha»**\n\nTravis Scott x Air Jordan 1 Low OG «Triple Mocha» появятся в продаже весной 2025 года на Nike.com и у избранных ритейлеров в мужской сетке размеров. Приобрести пару можно будет за 150 долларов.\n\nОставайтесь с нами и подписывайтесь на наши Telegram и VK, чтобы не пропустить релиз и другие интересные события сникер-культуры, включая еще больше совместных выпусков Трэвиса с брендом Jordan.\n\n\nTravis Scott x Air Jordan 1 Low OG «Triple Mocha»\nЦвет: Dark Mocha/Black-Velvet Brown\nКод модели: DM7866-202\nДата релиза: Весна 2025\nЦена: $150",
                    imageURL:"https://sneakerfreak.ru/wp-content/uploads/2024/06/knowing_kicks_449438339_1613893259403648_1409330871827200288_n-scaled.jpg",
                    date: "1 июля 2024",
                    author:""
                    
                ),
                
                NewsArticle(
                    title: "Прогресс в области квантовых вычислений",
                    summary: "Титосэ Абэ снова объединились с Nike, чтобы выпустить совместные трейловые Zegamadome, сочетающие в себе моду и функциональность.",
                    content: "Титосэ Абэ снова объединились с Nike, чтобы выпустить совместные трейловые Zegamadome, сочетающие в себе моду и функциональность.\n\nКроссовки имеют прочный верх из сетки и замши для бега по пересеченной местности и элементы походных ботинок. Такой микс создает уникальный внешний вид, ориентированный на производительность. Совместный брендинг sacai и Nike подчеркивает дизайн модели.\nВ мидсоли Zegamadome используется пена ZoomX для комфорта, а аутсоль Vibram обеспечивает сцепление на любой поверхности. Сникеры выдержат походные нагрузки и при этом выглядят стильно.sacai x Nike Zegamadome выйдут весной/летом 2025 года в размерах унисекс. Цена пары пока не разглашается.\n\nОставайтесь с нами и подписывайтесь на наши Telegram и VK, чтобы не пропустить релиз и другие интересные события сникер-культуры, включая еще больше выпусков sacai с Nike и не только.\n\nsacai x Nike Zegamadome\nДата релиза: Весна/лето 2025",
                    imageURL:"https://sneakerfreak.ru/wp-content/uploads/2024/06/sacai-x-Nike-Zegamadome-1.jpg",
                    date: "1 июля 2024",
                    author: ""
                ),
                
                NewsArticle(
                    title: "Bad Banny засветился в новой коллаборации с adidas",
                    summary: "Неделя моды в Париже стала свидетелем неповторимого Bad Bunny. Только что выпустив свою последнюю коллаборацию Gazelle Indoor «San Juan», пуэрториканский музыкант засветился в следующем проекте – в «балетных» кроссовках adidas.",
                    content: "Неделя моды в Париже стала свидетелем неповторимого Bad Bunny. Только что выпустив свою последнюю коллаборацию Gazelle Indoor «San Juan», пуэрториканский музыкант засветился в следующем проекте – в «балетных» кроссовках adidas.\nОни представляют собой необычные сочетание чистых линий и формы классических балеток с фирменными деталями adidas Originals, а также Gum-подошвой, парусиновым верхом, культовыми «тремя полосками» и удобными резинками на щиколотках.\n«Мода – это выражение того, кто мы есть, и в этой коллекции я хотел объединить свою любовь к уличной одежде с изяществом балета», – прокомментировал Bad Bunny.Официальное название этих кроссовок Bad Banny x adidas остается неизвестным, но скоро появится больше подробностей. Следите за нашими обновлениями.",
                    imageURL:"https://sneakerfreak.ru/wp-content/uploads/2024/06/Bad-Banny-x-adidas-1.jpg",
                    date: "1 июля 2024",
                    author: ""
                )
            
            ]
    
    private var db = Firestore.firestore()
    
    init() {
        fetchNews()
    }
    
    func fetchNews() {
        db.collection("news").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.articles = documents.compactMap { queryDocumentSnapshot -> NewsArticle? in
                return try? queryDocumentSnapshot.data(as: NewsArticle.self)
            }
        }
    }
}

struct NewsView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                NavigationLink(destination: NewsDetailView(article: article)) {
                    NewsCardView(article: article)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Новости")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewsCardView: View {
    let article: NewsArticle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: article.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 200)
            .clipped()
            .cornerRadius(10)
            
            Text(article.title)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(article.summary)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text(article.author)
                    .font(.caption)
                    .foregroundColor(.blue)
                Spacer()
                Text(article.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct NewsDetailView: View {
    let article: NewsArticle
    @Environment(\.presentationMode) var presentationMode
    @State private var showShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                AsyncImage(url: URL(string: article.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .clipped()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(article.author)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Spacer()
                        Text(article.String, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Divider()
                    
                    Text(article.content)
                        .font(.body)
                        .lineSpacing(8)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.primary)
            },
            trailing: Button(action: {
                showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.primary)
            }
        )
        .sheet(isPresented: $showShareSheet) {
            ActivityViewController(activityItems: [article.title, URL(string: article.imageURL)!])
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}
