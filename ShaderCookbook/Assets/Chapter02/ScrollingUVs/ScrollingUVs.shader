Shader "Custom/ScrollingUVs"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _XSpeed ("X Speed", float) = 0
        _YSpeed ("Y Speed", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float _XSpeed;
        float _YSpeed;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float2 uv = IN.uv_MainTex;
            uv += float2(_XSpeed * _Time.x, _YSpeed * _Time.x);
            fixed4 c = tex2D (_MainTex, uv);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
