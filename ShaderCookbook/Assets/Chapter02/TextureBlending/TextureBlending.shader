Shader "Custom/TextureBlending"
{
    Properties
    {
        _MainTint ("Diffuse Tint", Color) = (1,1,1,1)
        _ColorA ("Terrain Color A", Color) = (1,1,1,1)
        _ColorB ("Terrain Color B", Color) = (1,1,1,1)
        _RTex ("Red Channel Texture", 2D) = "" {}
        _GTex ("Green Channel Texture", 2D) = "" {}
        _BTex ("Blue Channel Texture", 2D) = "" {}
        _ATex ("Alpha Channel Texture", 2D) = "" {}
        _BlendTex ("Blend Texture", 2D) = "" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert
        #pragma target 4.0

        float4 _MainTint;
        float4 _ColorA;
        float4 _ColorB;
        sampler2D _RTex;
        sampler2D _GTex;
        sampler2D _BTex;
        sampler2D _ATex;
        sampler2D _BlendTex;

        struct Input
        {
            float2 uv_RTex;
            float2 uv_GTex;
            float2 uv_BTex;
            float2 uv_ATex;
            float2 uv_BlendTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 blenddata = tex2D(_BlendTex, IN.uv_BlendTex);
            float4 rdata = tex2D(_RTex, IN.uv_RTex);
            float4 gdata = tex2D(_GTex, IN.uv_GTex);
            float4 bdata = tex2D(_BTex, IN.uv_BTex);
            float4 adata = tex2D(_ATex, IN.uv_ATex);

            float4 finalColor = lerp(rdata, gdata, blenddata.g);
            finalColor = lerp(finalColor, bdata, blenddata.b);
            finalColor = lerp(finalColor, adata, blenddata.a);
            finalColor.a = 1.0;

            float4 terrainLayer = lerp(_ColorA, _ColorB, blenddata.r);
            finalColor *= terrainLayer;
            finalColor = saturate(finalColor);

            o.Albedo = finalColor.rgb * _MainTint.rgb;
            o.Alpha = finalColor.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
