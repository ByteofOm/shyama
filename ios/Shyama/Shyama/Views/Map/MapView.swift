import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    @State private var selectedFilter = 0
    private let filters = ["All", "Black-owned", "BIPOC-friendly", "Hair", "Skin"]

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                Marker("Mahogany Hair Studio",
                       systemImage: "scissors",
                       coordinate: CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855))
                .tint(Color.accent)

                Marker("Shea Skin Bar",
                       systemImage: "sparkles",
                       coordinate: CLLocationCoordinate2D(latitude: 40.7308, longitude: -73.9973))
                .tint(Color.primary)

                Marker("Honeycomb Nails",
                       systemImage: "paintbrush",
                       coordinate: CLLocationCoordinate2D(latitude: 40.7200, longitude: -74.0100))
                .tint(Color.good)

                Marker("Dr. Michelle Henry, MD",
                       systemImage: "stethoscope",
                       coordinate: CLLocationCoordinate2D(latitude: 40.7614, longitude: -73.9776))
                .tint(Color.warn)
            }
            .ignoresSafeArea()
            .preferredColorScheme(.dark)

            VStack(spacing: 0) {
                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.inkMuted)
                    Text("Search salons, spas, nail…")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.inkMuted)
                    Spacer()
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.accent)
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
                                selectedFilter = i
                            } label: {
                                Text(filters[i])
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(selectedFilter == i ? Color.canvas : Color.ink)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 7)
                                    .background(
                                        selectedFilter == i ? Color.accent : .clear,
                                        in: Capsule()
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                .padding(.top, 10)

                Spacer()

                // Bottom sheet — featured pin
                VStack(alignment: .leading, spacing: 14) {
                    // Handle
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.inkMuted.opacity(0.5))
                        .frame(width: 40, height: 4)
                        .frame(maxWidth: .infinity)

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("✓ VERIFIED BLACK-OWNED")
                                .font(.system(size: 9, weight: .semibold))
                                .tracking(1)
                                .foregroundStyle(Color.accent)
                            Text("Mahogany Hair Studio")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundStyle(Color.ink)
                        }
                        Spacer()
                        Text("A")
                            .font(.system(size: 36, weight: .bold, design: .serif))
                            .italic()
                            .foregroundStyle(Color.good)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(["4c specialist", "Locs", "0.8 mi", "Open now"], id: \.self) { tag in
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
                        Button("Details") {}
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.ink)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color.mist, in: Capsule())

                        Button("Directions") {}
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.canvas)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color.accent, in: Capsule())
                    }
                }
                .padding(20)
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 28))
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
    }
}

#Preview {
    MapView()
}
