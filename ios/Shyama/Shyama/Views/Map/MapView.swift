import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Map(position: $cameraPosition) {
                    Marker("Adwoa Beauty",
                           systemImage: "scissors",
                           coordinate: CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855))

                    Marker("Camille Rose Salon",
                           systemImage: "paintbrush",
                           coordinate: CLLocationCoordinate2D(latitude: 40.7308, longitude: -73.9973))

                    Marker("Dr. Michelle Henry, MD",
                           systemImage: "stethoscope",
                           coordinate: CLLocationCoordinate2D(latitude: 40.7614, longitude: -73.9776))
                }
                .ignoresSafeArea()

                Text("Find BIPOC beauty & care")
                    .font(Font.Shyama.footnote.weight(.medium))
                    .foregroundStyle(Color.ink)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .glassEffect(.regular, in: .capsule)
                    .padding(.top, 16)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapView()
}
