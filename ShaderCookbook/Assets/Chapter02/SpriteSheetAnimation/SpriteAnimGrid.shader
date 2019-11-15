Shader "Custom/SpriteAnimGrid"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Rows ("Row Count", int) = 1
        _Cols ("Column Count", int) = 1
        _FPS ("FPS", int) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert alpha

        sampler2D _MainTex;
        int _Rows;
        int _Cols;
        int _FPS;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            int rowXcol = _Rows * _Cols;
            float runit = 1.0 / _Rows;
            float cunit = 1.0 / _Cols;

            int idx = ceil((_Time.y / (1.0 / _FPS)) % rowXcol);
            int cidx = idx % _Cols;
            int ridx = (_Rows + 1) - ceil(1.0 * idx / _Cols);

            float2 uv = IN.uv_MainTex;
            uv.x = (uv.x + cidx - 1) * cunit;
            uv.y = (uv.y + ridx - 1) * runit;
            fixed4 c = tex2D (_MainTex, uv);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
