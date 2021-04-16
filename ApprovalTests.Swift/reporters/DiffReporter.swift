class DiffReporter: FirstWorkingReporter {
    init() {
        super.init(
                iOSReporter(),
                MacReporter()
        )
    }
}
