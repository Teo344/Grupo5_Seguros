package com.example.bdd_dto.controller;

import com.example.bdd_dto.dto.*;
import com.example.bdd_dto.service.*;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/poliza")
public class PolizaController {

    private final PropietarioService propietarioService;
    private final AutomovilService automovilService;
    private final SeguroService seguroService;

    public PolizaController(PropietarioService propietarioService, AutomovilService automovilService, SeguroService seguroService) {
        this.propietarioService = propietarioService;
        this.automovilService = automovilService;
        this.seguroService = seguroService;
    }

    @PostMapping
    public ResponseEntity<PolizaResponse> crearPoliza(@RequestBody PolizaRequest req) {
        // Crear propietario
        PropietarioDTO propietarioDTO = propietarioService.crear(
                new PropietarioDTO(null, req.getPropietario(), req.getEdadPropietario(), null)
        );

        // Crear auto
        AutomovilDTO autoDTO = new AutomovilDTO(null, req.getModeloAuto(), req.getValorSeguroAuto(),
                req.getAccidentes(), propietarioDTO.getId(), null, null, null);
        autoDTO = automovilService.crear(autoDTO);

        // Obtener seguro
        SeguroDTO seguroDTO = seguroService.obtenerPorAutomovilId(autoDTO.getId());

        // Armar respuesta
        PolizaResponse response = new PolizaResponse(
                propietarioDTO.getNombreCompleto(),
                autoDTO.getModelo(),
                autoDTO.getValor(),
                propietarioDTO.getEdad(),
                autoDTO.getAccidentes(),
                seguroDTO.getCostoTotal()
        );

        return ResponseEntity.ok(response);
    }

    @GetMapping("/usuario")
    public ResponseEntity<PolizaResponse> obtenerPolizaPorNombre(@RequestParam String nombre) {
        // Buscar propietario por nombre
        PropietarioDTO propietarioDTO = propietarioService.buscarPorNombre(nombre);

        // Obtener auto más reciente del propietario (asumimos el último por ID o el primero)
        Long propietarioId = propietarioDTO.getId();
        AutomovilDTO autoDTO = automovilService.obtenerPorPropietarioId(propietarioId);

        // Obtener seguro
        SeguroDTO seguroDTO = seguroService.obtenerPorAutomovilId(autoDTO.getId());

        // Armar respuesta
        PolizaResponse response = new PolizaResponse(
                propietarioDTO.getNombreCompleto(),
                autoDTO.getModelo(),
                autoDTO.getValor(),
                propietarioDTO.getEdad(),
                autoDTO.getAccidentes(),
                seguroDTO.getCostoTotal()
        );

        return ResponseEntity.ok(response);
    }


    @GetMapping("/{id}")
public ResponseEntity<PolizaResponse> obtenerPolizaPorId(@PathVariable Long id) {

    AutomovilDTO auto = automovilService.obtenerPorId(id);
    SeguroDTO seguro = seguroService.obtenerPorAutomovilId(auto.getId());
    PropietarioDTO propietario = propietarioService.obtenerPorId(auto.getPropietarioId());

    PolizaResponse response = new PolizaResponse(
            propietario.getNombreCompleto(),
            auto.getModelo(),
            auto.getValor(),
            propietario.getEdad(),
            auto.getAccidentes(),
            seguro.getCostoTotal()
    );

    return ResponseEntity.ok(response);
}


@GetMapping("/todas")
public ResponseEntity<List<PolizaResponse>> obtenerTodasLasPolizas() {

    List<AutomovilDTO> autos = automovilService.obtenerTodos();

    List<PolizaResponse> polizas = autos.stream().map(auto -> {

        PropietarioDTO propietario =
                propietarioService.obtenerPorId(auto.getPropietarioId());

        SeguroDTO seguro =
                seguroService.obtenerPorAutomovilId(auto.getId());

        return new PolizaResponse(
                propietario.getNombreCompleto(),
                auto.getModelo(),
                auto.getValor(),
                propietario.getEdad(),
                auto.getAccidentes(),
                seguro.getCostoTotal()
        );
    }).toList();

    return ResponseEntity.ok(polizas);
}




}
