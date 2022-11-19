public struct Ray {
    let origin: Vec3
    let direction: Vec3
    
    static let Dummy: Ray = Ray(Vec3.Dummy, Vec3.Dummy)
    
    public init(_ origin: Vec3, _ direction: Vec3) {
        self.origin = origin
        self.direction = direction
    }
    
    public func pointAt(_ t: Float) -> Vec3 {
        return origin + t * direction
    }
}
