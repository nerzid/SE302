package com.nerzid.Database;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;


// TO USE:
// Change the package (at top) to match your project.
// Search for "TODO", and make the appropriate changes.
public class DBAdapter {

    /////////////////////////////////////////////////////////////////////
    //	Constants & Data
    /////////////////////////////////////////////////////////////////////
    // For logging:
    private static final String TAG = "DBAdapter";

    // DB Fields
    public static final String KEY_ROWID = "_id";
    public static final int COL_ROWID = 0;
    /*
     * CHANGE 1:
     */
    // TODO: Setup your fields here:
    public static final String KEY_FORM_NO = "form_no";
    public static final String KEY_FORM_NAME = "form_name";
    public static final String KEY_QUESTION_NAME = "question_name";
    public static final String KEY_ANSWER_1 = "answer_1";
    public static final String KEY_ANSWER_2 = "answer_2";
    public static final String KEY_ANSWER_3 = "answer_3";

    // TODO: Setup your field numbers here (0 = KEY_ROWID, 1=...)
    public static final int COL_FORM_NO = 1;
    public static final int COL_FORM_NAME = 2;
    public static final int COL_QUESTION_NAME = 3;
    public static final int COL_ANSWER_1 = 4;
    public static final int COL_ANSWER_2 = 5;
    public static final int COL_ANSWER_3 = 6;


    public static final String[] ALL_KEYS = new String[] {KEY_ROWID, KEY_FORM_NO, KEY_FORM_NAME, KEY_QUESTION_NAME, KEY_ANSWER_1, KEY_ANSWER_2, KEY_ANSWER_3};

    // DB info: it's name, and the table we are using (just one).
    public static final String DATABASE_NAME = "MyDb";
    public static final String DATABASE_TABLE = "mainTable";
    // Track DB version if a new version of your app changes the format.
    public static final int DATABASE_VERSION = 1;

    private static final String DATABASE_CREATE_SQL =
            "create table " + DATABASE_TABLE
                    + " (" + KEY_ROWID + " integer primary key autoincrement, "

			/*
			 * CHANGE 2:
			 */
                    // TODO: Place your fields here!
                    // + KEY_{...} + " {type} not null"
                    //	- Key is the column name you created above.
                    //	- {type} is one of: text, integer, real, blob
                    //		(http://www.sqlite.org/datatype3.html)
                    //  - "not null" means it is a required field (must be given a value).
                    // NOTE: All must be comma separated (end of line!) Last one must have NO comma!!
                    + KEY_FORM_NO + " int not null, "
                    + KEY_FORM_NAME + " string not null, "
                    + KEY_QUESTION_NAME + " string not null, "
                    + KEY_ANSWER_1 + " string not null, "
                    + KEY_ANSWER_2 + " string not null, "
                    + KEY_ANSWER_3 + " string not null"

                    // Rest  of creation:
                    + ");";

    // Context of application who uses us.
    private final Context context;

    private DatabaseHelper myDBHelper;
    private SQLiteDatabase db;

    /////////////////////////////////////////////////////////////////////
    //	Public methods:
    /////////////////////////////////////////////////////////////////////

    public DBAdapter(Context ctx) {
        this.context = ctx;
        myDBHelper = new DatabaseHelper(context);
    }

    // Open the database connection.
    public DBAdapter open() {
        db = myDBHelper.getWritableDatabase();
        return this;
    }

    // Close the database connection.
    public void close() {
        myDBHelper.close();
    }

    // Add a new set of values to the database.
    public long insertRow(String form_name, int form_no, String question_name, String answer_1, String answer_2, String answer_3) {
		/*
		 * CHANGE 3:
		 */
        // TODO: Update data in the row with new fields.
        // TODO: Also change the function's arguments to be what you need!
        // Create row's data:
        ContentValues initialValues = new ContentValues();

        initialValues.put(KEY_FORM_NO, form_no);
        initialValues.put(KEY_FORM_NAME, form_name);
        initialValues.put(KEY_QUESTION_NAME, question_name);
        initialValues.put(KEY_ANSWER_1, answer_1);
        initialValues.put(KEY_ANSWER_2, answer_2);
        initialValues.put(KEY_ANSWER_3, answer_3);

        // Insert it into the database.
        return db.insert(DATABASE_TABLE, null, initialValues);
    }

    // Delete a row from the database, by rowId (primary key)
    public boolean deleteRow(long rowId) {
        String where = KEY_ROWID + "=" + rowId;
        return db.delete(DATABASE_TABLE, where, null) != 0;
    }

    public void deleteAll() {
        Cursor c = getAllRows();
        long rowId = c.getColumnIndexOrThrow(KEY_ROWID);
        if (c.moveToFirst()) {
            do {
                deleteRow(c.getLong((int) rowId));
            } while (c.moveToNext());
        }
        c.close();
    }

    // Return all data in the database.
    public Cursor getAllRows() {
        String where = null;
        Cursor c = 	db.query(true, DATABASE_TABLE, ALL_KEYS,
                where, null, null, null, null, null);
        if (c != null) {
            c.moveToFirst();
        }

        return c;
    }

    // Get a specific row (by rowId)
    public Cursor getRow(long rowId) {
        String where = KEY_ROWID + "=" + rowId;
        Cursor c = 	db.query(true, DATABASE_TABLE, ALL_KEYS,
                where, null, null, null, null, null);
        if (c != null) {
            c.moveToFirst();
        }
        return c;
    }

    // Change an existing row to be equal to new data.
    public boolean updateRow(long rowId, int form_no, String form_name, String question_name, String answer_1, String answer_2, String answer_3) {
        String where = KEY_ROWID + "=" + rowId;

		/*
		 * CHANGE 4:
		 */
        // TODO: Update data in the row with new fields.
        // TODO: Also change the function's arguments to be what you need!
        // Create row's data:
        ContentValues newValues = new ContentValues();
        newValues.put(KEY_FORM_NO, form_no);
        newValues.put(KEY_FORM_NAME, form_name);
        newValues.put(KEY_QUESTION_NAME, question_name);
        newValues.put(KEY_ANSWER_1, answer_1);
        newValues.put(KEY_ANSWER_2, answer_2);
        newValues.put(KEY_ANSWER_3, answer_3);

        // Insert it into the database.
        return db.update(DATABASE_TABLE, newValues, where, null) != 0;
    }



    /////////////////////////////////////////////////////////////////////
    //	Private Helper Classes:
    /////////////////////////////////////////////////////////////////////

    /**
     * Private class which handles database creation and upgrading.
     * Used to handle low-level database access.
     */
    private static class DatabaseHelper extends SQLiteOpenHelper
    {
        DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase _db) {
            _db.execSQL(DATABASE_CREATE_SQL);
        }

        @Override
        public void onUpgrade(SQLiteDatabase _db, int oldVersion, int newVersion) {
            Log.w(TAG, "Upgrading application's database from version " + oldVersion
                    + " to " + newVersion + ", which will destroy all old data!");

            // Destroy old database:
            _db.execSQL("DROP TABLE IF EXISTS " + DATABASE_TABLE);

            // Recreate new database:
            onCreate(_db);
        }
    }
}
