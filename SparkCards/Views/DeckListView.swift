import SwiftUI

struct DeckListView: View {
    @State private var decks: [Deck] = []
    @State private var showingAddDeck = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Premium Banner
                PremiumBanner()
                
                // Deck List
                List(decks) { deck in
                    NavigationLink(destination: DeckDetailView(deck: deck)) {
                        DeckRowView(deck: deck)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("My Decks")
            .navigationBarItems(
                trailing: Button(action: { showingAddDeck = true }) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
            )
            .sheet(isPresented: $showingAddDeck) {
                AddDeckView(decks: $decks)
            }
        }
    }
}

struct PremiumBanner: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Image(systemName: "book.fill")
                    .foregroundColor(.blue)
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.green)
                
                Spacer()
                
                Button("GET PREMIUM") {
                    // Premium action
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(20)
            }
            .padding()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.6)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }
}

struct DeckRowView: View {
    let deck: Deck
    
    var body: some View {
        HStack {
            Image(systemName: "book.fill")
                .foregroundColor(.yellow)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(deck.name)
                    .font(.headline)
                Text("\(deck.cardCount) cards")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct AddDeckView: View {
    @Binding var decks: [Deck]
    @Environment(\.presentationMode) var presentationMode
    @State private var deckName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Deck")) {
                    TextField("Deck Name", text: $deckName)
                }
            }
            .navigationTitle("Add Deck")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    let newDeck = Deck(name: deckName)
                    decks.append(newDeck)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(deckName.isEmpty)
            )
        }
    }
}

#Preview {
    DeckListView()
} 