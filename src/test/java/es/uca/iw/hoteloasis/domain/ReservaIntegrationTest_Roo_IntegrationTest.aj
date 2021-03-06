// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package es.uca.iw.hoteloasis.domain;

import es.uca.iw.hoteloasis.domain.Reserva;
import es.uca.iw.hoteloasis.domain.ReservaDataOnDemand;
import es.uca.iw.hoteloasis.domain.ReservaIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect ReservaIntegrationTest_Roo_IntegrationTest {
    
    declare @type: ReservaIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: ReservaIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: ReservaIntegrationTest: @Transactional;
    
    @Autowired
    ReservaDataOnDemand ReservaIntegrationTest.dod;
    
    @Test
    public void ReservaIntegrationTest.testCountReservas() {
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", dod.getRandomReserva());
        long count = Reserva.countReservas();
        Assert.assertTrue("Counter for 'Reserva' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void ReservaIntegrationTest.testFindReserva() {
        Reserva obj = dod.getRandomReserva();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to provide an identifier", id);
        obj = Reserva.findReserva(id);
        Assert.assertNotNull("Find method for 'Reserva' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Reserva' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void ReservaIntegrationTest.testFindAllReservas() {
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", dod.getRandomReserva());
        long count = Reserva.countReservas();
        Assert.assertTrue("Too expensive to perform a find all test for 'Reserva', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Reserva> result = Reserva.findAllReservas();
        Assert.assertNotNull("Find all method for 'Reserva' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Reserva' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void ReservaIntegrationTest.testFindReservaEntries() {
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", dod.getRandomReserva());
        long count = Reserva.countReservas();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Reserva> result = Reserva.findReservaEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Reserva' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Reserva' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void ReservaIntegrationTest.testFlush() {
        Reserva obj = dod.getRandomReserva();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to provide an identifier", id);
        obj = Reserva.findReserva(id);
        Assert.assertNotNull("Find method for 'Reserva' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyReserva(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Reserva' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void ReservaIntegrationTest.testMergeUpdate() {
        Reserva obj = dod.getRandomReserva();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to provide an identifier", id);
        obj = Reserva.findReserva(id);
        boolean modified =  dod.modifyReserva(obj);
        Integer currentVersion = obj.getVersion();
        Reserva merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Reserva' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void ReservaIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", dod.getRandomReserva());
        Reserva obj = dod.getNewTransientReserva(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Reserva' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Reserva' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'Reserva' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void ReservaIntegrationTest.testRemove() {
        Reserva obj = dod.getRandomReserva();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Reserva' failed to provide an identifier", id);
        obj = Reserva.findReserva(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Reserva' with identifier '" + id + "'", Reserva.findReserva(id));
    }
    
}
