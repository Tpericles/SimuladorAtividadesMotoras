Shader "Custom/DoubleSidedFadeTransparentEmissionShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Emission ("Emission", Color) = (1, 1, 1, 1)
        _FadeStart ("Fade Start Distance", Range(0.0, 10.0)) = 2.0
        _FadeEnd ("Fade End Distance", Range(0.0, 20.0)) = 5.0
    }
    
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200
        
        Cull Off
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        
        CGPROGRAM
        #pragma surface surf Lambert alpha

        sampler2D _MainTex;
        fixed4 _Emission;
        half _FadeStart;
        half _FadeEnd;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Sample the texture to get the color and alpha values
            half4 texColor = tex2D(_MainTex, IN.uv_MainTex);
            
            // Albedo comes from the texture RGB values
            o.Albedo = texColor.rgb;
            
            // Calculate the distance from the camera to the object
            float dist = distance(IN.worldPos, _WorldSpaceCameraPos);
            
            // Calculate the fade factor based on distance
            float fadeFactor = saturate((dist - _FadeStart) / (_FadeEnd - _FadeStart));
            
            // Set both sides to be visible with transparency controlled by alpha from the texture and fadeFactor
            o.Alpha = texColor.a * fadeFactor;
            
            // Apply emission
            o.Emission = _Emission.rgb * texColor.a;
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}
