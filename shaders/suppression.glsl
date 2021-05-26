precision mediump float;
varying vec2 uv;
uniform sampler2D texture0;
uniform sampler2D texture1;
uniform vec2 size;

vec2 off(float grad) {
	if (grad < 1.0/16.0) {
		return vec2(0.0, -1.0);
	} else if (grad < 3.0/16.0) {
		return vec2(-1.0, -1.0);
	} else if (grad < 5.0/16.0) {
		return vec2(-1.0, 0.0);
	} else if (grad < 7.0/16.0) {
		return vec2(-1.0, 1.0);
	} else if (grad < 9.0/16.0) {
		return vec2(0.0, 1.0);
	} else if (grad < 11.0/16.0) {
		return vec2(1.0, 1.0);
	} else if (grad < 13.0/16.0) {
		return vec2(1.0, 0.0);
	} else if (grad < 15.0/16.0) {
		return vec2(1.0, -1.0);
	} else {
		return vec2(0.0, -1.0);
	}
}

void main() {
	vec3 val = texture2D(texture0, uv).rgb;
	vec3 grad = texture2D(texture1, uv).rgb;
	
	vec2 offR = off(grad.r) / size;
	vec2 offG = off(grad.g) / size;
	vec2 offB = off(grad.b) / size;

	float r0 = texture2D(texture0, uv + offR).r;
	float g0 = texture2D(texture0, uv + offG).g;
	float b0 = texture2D(texture0, uv + offB).b;

	float r1 = texture2D(texture0, uv - offR).r;
	float g1 = texture2D(texture0, uv - offG).g;
	float b1 = texture2D(texture0, uv - offB).b;

	if (val.r >= r0 && val.r > r1) {
		gl_FragColor.r = val.r;
	}
	if (val.g >= g0 && val.g > g1) {
		gl_FragColor.g = val.g;
	}
	if (val.b >= b0 && val.b > b1) {
		gl_FragColor.b = val.b;
	}
	gl_FragColor.a = 1.0;
}