Shader "Cookbook/BRDFRamp"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex ("Ramp Tex", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // #pragma surface surf Lambert
        #pragma surface surf MyLambert

        sampler2D _MainTex;
        float4 _Color;
        sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        inline float4 LightingMyLambert(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            float difLight = dot(s.Normal, lightDir);
            float rimLight = dot(s.Normal, viewDir);
            difLight = 0.5 + difLight * 0.5;
            float3 ramp = tex2D(_RampTex, float2(difLight, rimLight)).rgb;
            float4 col;
            col.rgb = s.Albedo * _LightColor0.rgb * ramp;
            col.a = s.Alpha;

            return col;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb * _Color.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
