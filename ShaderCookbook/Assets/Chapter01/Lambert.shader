Shader "Cookbook/Lambert"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
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

        struct Input
        {
            float2 uv_MainTex;
        };

        inline float4 LightingMyLambert(SurfaceOutput s, float3 lightDir, float atten)
        {
            float difLight = max(0, dot(s.Normal, lightDir));
            float4 col;
            col.rgb = s.Albedo * _LightColor0.rgb * (difLight * atten * 2);
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
