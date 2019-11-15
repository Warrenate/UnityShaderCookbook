Shader "Custom/SpriteAnimLine"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Count ("Sprite Count", int) = 1
        _FPS ("FPS", int) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert alpha

        sampler2D _MainTex;
        int _Count;
        int _FPS;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float2 uv = IN.uv_MainTex;
            float unit = 1.0 / _Count;
            int idx = floor(_Time.y / (1.0 / _FPS));
            uv.x = (uv.x + idx) * unit;
            fixed4 c = tex2D (_MainTex, uv);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
