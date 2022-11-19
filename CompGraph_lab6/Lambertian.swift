public class Lambertian: Material {
    let albedo: Vec3
    
    public init(albedo: Vec3) {
        self.albedo = albedo
    }
    
    public func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Vec3, scattered: inout Ray) -> Bool {
        let target: Vec3 = rec.p + rec.normal + randomInUnitSphere()
        scattered = Ray(rec.p, target - rec.p)
        attenuation = albedo
        return true
    }
}
