import SwiftUI
import MapKit
import UIKit

private struct ChampaignBusiness: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let tags: [String]
    let grade: String
    let verified: Bool
    let note: String
    let coordinate: CLLocationCoordinate2D
    let phone: String
}

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.1164, longitude: -88.2434),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )
    @State private var selectedBusiness: ChampaignBusiness? = nil
    @State private var selectedFilter = 0
    private let filters = ["All", "Black-owned", "Hair", "Skin", "Nails"]

    private let businesses: [ChampaignBusiness] = [
        ChampaignBusiness(
            name: "Crown & Curl Natural Hair Studio",
            category: "Hair Salon",
            tags: ["4C specialist", "Locs", "Natural", "Braids"],
            grade: "A",
            verified: true,
            note: "Black-owned. The only 4C specialist in Champaign with dedicated locs care. Ruby's file: dry scalp protocol available.",
            coordinate: CLLocationCoordinate2D(latitude: 40.1158, longitude: -88.2419),
            phone: "(217) 555-0142"
        ),
        ChampaignBusiness(
            name: "Mahogany Beauty Lounge",
            category: "Spa & Waxing",
            tags: ["BIPOC-owned", "Facials", "Waxing", "Dry-skin aware"],
            grade: "A−",
            verified: true,
            note: "BIPOC-owned. Staff trained in hyperpigmentation and dry skin on melanated skin. Champaign's go-to for inclusive facial services.",
            coordinate: CLLocationCoordinate2D(latitude: 40.1182, longitude: -88.2451),
            phone: "(217) 555-0198"
        ),
        ChampaignBusiness(
            name: "The Glow Suite",
            category: "Skincare Bar",
            tags: ["BIPOC-friendly", "Microdermabrasion", "Melanin-aware"],
            grade: "B+",
            verified: false,
            note: "Urbana location. Treatment menu includes melanin-safe chemical peels and dermaplaning. Ask for the 'deeper skin' peel menu.",
            coordinate: CLLocationCoordinate2D(latitude: 40.1106, longitude: -88.2073),
            phone: "(217) 555-0211"
        ),
        ChampaignBusiness(
            name: "Dr. Aisha Thompson, MD — Derm",
            category: "Dermatology",
            tags: ["BIPOC derm", "Dry skin", "Insurance accepted", "Champaign"],
            grade: "A",
            verified: true,
            note: "Black female dermatologist. Specialist in dry skin conditions, melasma, and folliculitis on deeper skin tones. Telehealth available.",
            coordinate: CLLocationCoordinate2D(latitude: 40.1220, longitude: -88.2355),
            phone: "(217) 555-0177"
        ),
    ]

    private var filteredBusinesses: [ChampaignBusiness] {
        let f = filters[selectedFilter]
        switch f {
        case "Black-owned": return businesses.filter { $0.verified }
        case "Hair": return businesses.filter { $0.category.contains("Hair") }
        case "Skin": return businesses.filter { $0.category.contains("Skin") || $0.category.contains("Derm") || $0.category.contains("Spa") }
        case "Nails": return businesses.filter { $0.tags.contains("Nails") }
        default: return businesses
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition, selection: .constant(nil)) {
                ForEach(filteredBusinesses) { biz in
                    Annotation(biz.name, coordinate: biz.coordinate) {
                        Button { selectedBusiness = biz } label: {
                            ZStack {
                                Circle()
                                    .fill(biz.verified ? Color.accent : Color.surface)
                                    .frame(width: selectedBusiness?.id == biz.id ? 48 : 36,
                                           height: selectedBusiness?.id == biz.id ? 48 : 36)
                                    .shadow(color: Color.accent.opacity(0.4), radius: 8)
                                Text(gradeEmoji(biz.grade))
                                    .font(.system(size: selectedBusiness?.id == biz.id ? 20 : 14))
                            }
                            .animation(.spring(response: 0.3), value: selectedBusiness?.id)
                        }
                    }
                }
            }
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.inkMuted)
                    Text("Champaign-Urbana BIPOC care")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.inkMuted)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .glassEffect(.regular, in: .capsule)
                .padding(.horizontal, 16)
                .padding(.top, 16)

                // Filter chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(filters.indices, id: \.self) { i in
                            Button {
                                withAnimation(.spring(response: 0.3)) { selectedFilter = i }
                            } label: {
                                Text(filters[i])
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(selectedFilter == i ? Color(hex: "F4EBDE") : Color.ink)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedFilter == i ? Color.accent : Color.surface.opacity(0.8),
                                        in: Capsule()
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                Spacer()

                // Bottom sheet
                if let biz = selectedBusiness {
                    businessSheet(biz)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                    nearbyList
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .animation(.spring(response: 0.35), value: selectedBusiness?.id)
    }

    // MARK: - Business detail sheet

    private func businessSheet(_ biz: ChampaignBusiness) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.inkMuted.opacity(0.4))
                    .frame(width: 40, height: 4)
                    .frame(maxWidth: .infinity)
            }

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    if biz.verified {
                        Text("✓ VERIFIED BLACK-OWNED")
                            .font(.system(size: 9, weight: .semibold))
                            .tracking(1)
                            .foregroundStyle(Color.accent)
                    }
                    Text(biz.name)
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundStyle(Color.ink)
                    Text(biz.category)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.inkMuted)
                }
                Spacer()
                Text(biz.grade)
                    .font(.system(size: 38, weight: .black, design: .serif))
                    .italic()
                    .foregroundStyle(Color.good)
            }

            Text(biz.note)
                .font(.system(size: 12))
                .foregroundStyle(Color.inkSoft)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(biz.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.inkSoft)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.mist, in: Capsule())
                    }
                }
            }

            HStack(spacing: 10) {
                Button {
                    openDirections(to: biz)
                } label: {
                    Text("Directions")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "F4EBDE"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(Color.accent, in: Capsule())
                }

                Button {
                    callBusiness(biz.phone)
                } label: {
                    Text("Call")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.ink)
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(Color.mist, in: Capsule())
                }

                Button { selectedBusiness = nil } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.inkMuted)
                        .frame(width: 46, height: 46)
                        .background(Color.mist, in: Circle())
                }
            }
        }
        .padding(20)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 28))
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
    }

    // MARK: - Collapsed nearby list

    private var nearbyList: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.inkMuted.opacity(0.4))
                    .frame(width: 40, height: 4)
                    .frame(maxWidth: .infinity)
            }
            Text("\(filteredBusinesses.count) spots near Champaign-Urbana")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.ink)
                .padding(.horizontal, 4)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filteredBusinesses) { biz in
                        Button { selectedBusiness = biz } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(biz.name)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Color.ink)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Text(biz.grade)
                                        .font(.system(size: 22, weight: .black, design: .serif))
                                        .italic()
                                        .foregroundStyle(Color.good)
                                }
                                if biz.verified {
                                    Text("✓ Black-owned")
                                        .font(.system(size: 9, weight: .semibold))
                                        .foregroundStyle(Color.accent)
                                }
                                Text(biz.category)
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.inkMuted)
                            }
                            .padding(14)
                            .frame(width: 200)
                            .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
            }
        }
        .padding(16)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 28))
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
    }

    // MARK: - Actions

    private func openDirections(to biz: ChampaignBusiness) {
        let item = MKMapItem(placemark: MKPlacemark(coordinate: biz.coordinate, addressDictionary: nil))
        item.name = biz.name
        item.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault])
    }

    private func callBusiness(_ phone: String) {
        let formatted = phone.filter { $0.isNumber }
        if let url = URL(string: "tel:\(formatted)") {
            UIApplication.shared.open(url)
        }
    }

    private func gradeEmoji(_ grade: String) -> String {
        switch grade.prefix(1) {
        case "A": return "★"
        case "B": return "◆"
        default:  return "●"
        }
    }
}

#Preview {
    MapView()
}
