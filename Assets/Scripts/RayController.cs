using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.XR.Interaction.Toolkit;
using UnityEngine.InputSystem;

public class RayController : MonoBehaviour
{
    public InputActionProperty triggerButton;
    
    public XRRayInteractor rayInteractor;

    // Update is called once per frame
    void Update()
    {
        // Fica lendo o triggerButton e desativa o script XRRayController para esconder o raio enquanto não tiver pressionado
        if(triggerButton.action.ReadValue<float>() == 1.0f){
            rayInteractor.enabled = true;
        }else{
            rayInteractor.enabled = false;
        }
    }
}
