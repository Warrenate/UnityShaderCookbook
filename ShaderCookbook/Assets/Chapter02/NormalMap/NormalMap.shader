Shader "Custom/NormalMap"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Intensity ("Intensity", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _NormalMap;
        float _Intensity;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
            float3 normalMap = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
            o.Normal = float3(normalMap.x * _Intensity, normalMap.y * _Intensity, normalMap.z);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
