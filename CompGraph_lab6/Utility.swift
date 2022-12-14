import Foundation
import simd

typealias Pixel = UInt32

extension Pixel {
    init(r: UInt8, g: UInt8, b: UInt8) {
        let r = UInt32(r)
        let g = UInt32(g)
        let b = UInt32(b)
        self = r << 24 | g << 16 | b << 8 | 0xFF
    }
}

func randomInUnitSphere() -> Vec3 {
    var p: Vec3
    repeat {
        p = 2.0 * Vec3(Float(drand48()), Float(drand48()), Float(drand48())) - Vec3(1, 1, 1)
    } while p.squaredLength >= 1.0
    return p
}

func reflect(v: Vec3, n: Vec3) -> Vec3 {
    return Vec3(simd_reflect(v.model, n.model))
     
}

func refract(v: Vec3, n: Vec3, niOverNt: Float, refracted: inout Vec3) -> Bool {
    let uv: Vec3 = v.unitVector
    let dt: Float = uv • n
    let discriminant: Float = 1.0 - niOverNt * niOverNt * (1 - dt * dt)
    if discriminant > 0 {
        refracted = niOverNt * (uv - n * dt) - n * discriminant.squareRoot()
        return true
    }
    
    return false
}

func schlick(cosine: Float, refIdx: Float) -> Float {
    var r0: Float = (1 - refIdx) / (1 + refIdx)
    r0 = r0 * r0
    return r0 + (1 - r0) * powf(1 - cosine, 5)
}
