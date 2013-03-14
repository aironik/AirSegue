//
//  Vector.cpp
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 21.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __Vector_H_
#define __Vector_H_

#import <cmath>
#import <GLKit/GLKit.h>


namespace Surfaces {

template <int N>
struct VectorD {
    VectorD() {
        for (int i = 0; i < N; ++i) {
            v[i] = 0.0f;
        }
    }
    float v[N];
};

template<>
struct VectorD<2> {
    union {
        float v[2];
        struct { float x, y; };
        GLKVector2 glkVector;
    };

    VectorD()
            : x(0.0f)
            , y(0.0f)
    {
    }
    
    VectorD(float ax, float ay)
            : x(ax)
            , y(ay)
    {
    }

    VectorD &operator=(const GLKVector2 &other) {
        x = other.x;
        y = other.y;
        return *this;
    }
};

template <>
struct VectorD<3> {
    union {
        float v[3];
        struct { float x, y, z; };
        GLKVector3 glkVector;
    };

    VectorD()
            : x(0.0f)
            , y(0.0f)
            , z(0.0f)
    {
    }
    
    VectorD(float ax, float ay, float az)
            : x(ax)
            , y(ay)
            , z(az)
    {
    }

    VectorD &operator=(const GLKVector3 &other) {
        x = other.x;
        y = other.y;
        z = other.z;
        return *this;
    }
};

template <>
struct VectorD<4> {
    union {
        float v[4];
        struct { float x, y, z, w; };
        GLKVector4 glkVector;
    };

    VectorD()
            : x(0.0f)
            , y(0.0f)
            , z(0.0f)
            , w(0.0f)
    {
    }

    
    VectorD(float ax, float ay, float az, float aw)
            : x(ax)
            , y(ay)
            , z(az)
            , w(aw)
    {
    }

    VectorD &operator=(const GLKVector4 &other) {
        x = other.x;
        y = other.y;
        z = other.z;
        w = other.w;
        return *this;
    }
};
    
template <int N>
struct Vector : public VectorD<N>{
    Vector()
            : VectorD<N>()
    {
        for (int i = 0; i < N; ++i) {
            this->v[i] = 0.0f;
        }
    }

    Vector(float ax, float ay)
            : VectorD<2>(ax, ay)
    {
    }

    Vector(float ax, float ay, float az)
            : VectorD<3>(ax, ay, az)
    {
    }

    Vector(float ax, float ay, float az, float aw)
            : VectorD<4>(ax, ay, az, aw)
    {
    }

    Vector(const Vector &other) {
        for (int i = 0; i < N; ++i) {
            this->v[i] = other.v[i];
        }
    }
    
    Vector(const GLKVector2 &other)
            : VectorD<2>(other.x, other.y)
    {
    }
    
    Vector(const GLKVector3 &other)
            : VectorD<3>(other.x, other.y, other.z)
    {
    }

    Vector(const GLKVector4 &other)
            : VectorD<4>(other.x, other.y, other.y, other.w)
    {
    }
    
    Vector &operator=(const Vector &other) {
        for (int i = 0; i < N; ++i) {
            this->v[i] = other.v[i];
        };
        return *this;
    }

    bool operator==(const Vector &other) const {
        for (int i = 0; i < N; ++i) {
            if (this->v[i] != other.v[i]) {
                return false;
            }
        }
        return true;
    }

    bool operator!=(const Vector &other) const {
        return !operator==(other);
    }

    const Vector operator+(const Vector &other) const {
        return Vector(*this) += other;
    }

    const Vector operator-(const Vector &other) const {
        return Vector(*this) -= other;
    }

    const Vector operator/(const float &c) const {
        return Vector(*this) /= c;
    }

    const Vector operator*(const float &c) const {
        return Vector(*this) *= c;
    }

    Vector &operator+=(const Vector &other) {
        for (int i = 0; i < N; ++i) {
            this->v[i] += other.v[i];
        }
        return *this;
    }

    Vector &operator-=(const Vector &other) {
        for (int i = 0; i < N; ++i) {
            this->v[i] -= other.v[i];
        }
        return *this;
    }

    Vector &operator*=(const float c) {
        for (int i = 0; i < N; ++i) {
            this->v[i] *= c;
        }
        return *this;
    }

    Vector &operator/=(const float c) {
        for (int i = 0; i < N; ++i) {
            this->v[i] /= c;
        }
        return *this;
    }

    Vector absAllComponents() const {
        Vector result;
        for (int i = 0; i < N; ++i) {
            result.v[i] = std::abs(this->v[i]);
        }
        return result;
    }

    bool isEqualsWithInaccuracy(const Vector &other, float inaccuracy) {
        for (int i = 0; i < N; ++i) {
            if (std::abs(this->v[i] - other.v[i]) > inaccuracy) {
                return false;
            }
        }
        return true;
    }

    Vector<3> crossproduct(const Vector<3> &other) const {
        return Vector<3>(this->y * other.z - this->z * other.y, this->z * other.x - this->x * other.z, this->x * other.y - this->y * other.x);
    }

    float dotproduct(const Vector &other) const {
        float result = 0.0f;
        for (int i = 0; i < N; ++i) {
            result += this->v[i] * other.v[i];
        }
        return result;
    }

    float length() const {
        return std::sqrt(dotproduct(*this));
    }

    float distance(const Vector &other) const {
        return (other - *this).length();
    }

    Vector &normalize() {
        *this /= length();
        return *this;
    }
};

#define Vector2 Vector<2>
#define Vector3 Vector<3>
#define Vector4 Vector<4>
    
} // namespace Surfaces

#endif //__Vector3D_H_
