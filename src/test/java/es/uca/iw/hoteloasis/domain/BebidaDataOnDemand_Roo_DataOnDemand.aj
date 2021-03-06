// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package es.uca.iw.hoteloasis.domain;

import es.uca.iw.hoteloasis.domain.Bebida;
import es.uca.iw.hoteloasis.domain.BebidaDataOnDemand;
import es.uca.iw.hoteloasis.domain.CategoriaDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect BebidaDataOnDemand_Roo_DataOnDemand {
    
    declare @type: BebidaDataOnDemand: @Component;
    
    private Random BebidaDataOnDemand.rnd = new SecureRandom();
    
    private List<Bebida> BebidaDataOnDemand.data;
    
    @Autowired
    CategoriaDataOnDemand BebidaDataOnDemand.categoriaDataOnDemand;
    
    public Bebida BebidaDataOnDemand.getNewTransientBebida(int index) {
        Bebida obj = new Bebida();
        setCantidad_minibar(obj, index);
        setCoste(obj, index);
        setNombre(obj, index);
        return obj;
    }
    
    public void BebidaDataOnDemand.setCantidad_minibar(Bebida obj, int index) {
        int cantidad_minibar = index;
        obj.setCantidad_minibar(cantidad_minibar);
    }
    
    public void BebidaDataOnDemand.setCoste(Bebida obj, int index) {
        double coste = new Integer(index).doubleValue();
        obj.setCoste(coste);
    }
    
    public void BebidaDataOnDemand.setNombre(Bebida obj, int index) {
        String nombre = "nombre_" + index;
        obj.setNombre(nombre);
    }
    
    public Bebida BebidaDataOnDemand.getSpecificBebida(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Bebida obj = data.get(index);
        Long id = obj.getId();
        return Bebida.findBebida(id);
    }
    
    public Bebida BebidaDataOnDemand.getRandomBebida() {
        init();
        Bebida obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Bebida.findBebida(id);
    }
    
    public boolean BebidaDataOnDemand.modifyBebida(Bebida obj) {
        return false;
    }
    
    public void BebidaDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Bebida.findBebidaEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Bebida' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Bebida>();
        for (int i = 0; i < 10; i++) {
            Bebida obj = getNewTransientBebida(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
