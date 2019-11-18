using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProceduralTexture : MonoBehaviour
{
	private int widthHeight = 512;
	private Texture2D tex2d;
	private Material curMaterial;


	void Start()
	{
		curMaterial = transform.GetComponent<Renderer>().sharedMaterial;
		if (curMaterial == null)
		{
			Debug.Log("material is null!");
			return;
		}

		// tex2d = GenTex();
		tex2d = GenerateParabola();
		curMaterial.SetTexture("_MainTex", tex2d);
	}

	private Texture2D GenTex()
	{
		Vector2 center = Vector2.one * 0.5f * widthHeight;
		Texture2D t2d = new Texture2D(widthHeight, widthHeight);
		for (int x = 0; x < widthHeight; x++)
		{
			for (int y = 0; y < widthHeight; y++)
			{
				Color clr = new Color();
				float dx = center.x - x;
				float dy = center.y - y;
				float len = Mathf.Sqrt(dx * dx + dy * dy) / center.x;
				clr.r = clr.g = clr.b = 1 - Mathf.Min(len, 1);
				t2d.SetPixel(x, y, clr);
			}
		}
		t2d.Apply();
		return t2d;
	}

    private Texture2D GenerateParabola()
    {
        Vector2 center = Vector2.one * 0.5f * widthHeight;
        Texture2D t2d = new Texture2D(widthHeight, widthHeight);
        for(int x = 0; x < widthHeight; x++)
        {
            for(int y = 0; y < widthHeight; y++)
            {
                float distance = Vector2.Distance(new Vector2(x, y), center) / (widthHeight * 0.5f);
                distance = 1 - Mathf.Clamp(distance, 0, 1.0f);
                Color clr = new Color(distance, distance, distance, 1);
                t2d.SetPixel(x, y, clr);
                t2d.Apply();
            }
        }
        return t2d;
    }
}
