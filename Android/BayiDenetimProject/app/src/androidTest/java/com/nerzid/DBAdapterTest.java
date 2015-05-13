package com.nerzid;

import com.nerzid.Database.DBAdapter;
import com.nerzid.MyApplication;

import junit.framework.TestCase;

/**
 * Created by nerzid on 13.5.2015.
 */
public class DBAdapterTest extends TestCase {

    public void testOpen() throws Exception {
        DBAdapter db = new DBAdapter(MyApplication.getAppContext());
        assertNotNull(db.open());
        db.close();
    }

    public void testClose() throws Exception {
        DBAdapter db = new DBAdapter(MyApplication.getAppContext());
        db.open();
        assertTrue(db.close());
        db.close();
    }

    public void testGetAllRows() throws Exception {
        DBAdapter db = new DBAdapter(MyApplication.getAppContext());
        db.open();
        db.getAllRows();
        assertTrue(db.testGetAllRows);
        db.close();
    }

    public void testGetRowByRowID() throws Exception {
        DBAdapter db = new DBAdapter(MyApplication.getAppContext());
        db.open();
        db.getRowByRowID(1);
        assertTrue(db.testGetRowByRowID);
        db.close();
    }

    public void testIsQuestionExist() throws Exception {
        DBAdapter db = new DBAdapter(MyApplication.getAppContext());
        db.open();
        db.isQuestionExist(1, "test");
        assertTrue(db.testisQuestionExist);
    }
}