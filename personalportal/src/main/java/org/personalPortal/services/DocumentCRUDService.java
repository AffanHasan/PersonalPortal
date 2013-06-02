package org.personalPortal.services;

import java.util.logging.Logger;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;

import javax.ejb.Local;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.inject.Inject;

import org.personalPortal.model.EnvProperty;

/**
 * Session Bean implementation class DocumentCRUDService
 */
@Stateless(mappedName = "chulbula")
@LocalBean
@Local(IBasicDocumentService.class)
@TransactionManagement(TransactionManagementType.BEAN)
public class DocumentCRUDService implements IBasicDocumentService {
	
	@Inject
	private	Logger logger;
	
	private DB db;
	
	private DBCollection dbCollection;
	
    /**
     * Default constructor. 
     */
    public DocumentCRUDService() {
        // TODO Auto-generated constructor stub
    }
    
    @Inject
    public DocumentCRUDService(MongoClient mongoClient, @EnvProperty("dbName") String dbName){
    	this.db = mongoClient.getDB(dbName);
    }

	/**
     * @see IBasicDocumentService#findOneById(String, Class<T>, Object)
     */
    public DBObject findOneById(String collectionName, Class<? extends DBObject> documentClass, Object id) {
    	this.dbCollection = this.db.getCollection(collectionName);
    	this.dbCollection.setObjectClass(documentClass);
    	try{
    		return this.dbCollection.findOne(id);
    	}catch(MongoException e){
    		this.logger.severe(e.toString());
    		return null;
    	}
    }

	/**
     * @see IBasicDocumentService#update(DBObject, DBObject, String)
     */
    @Override
    public boolean update(DBObject OriginalDocument, DBObject updatedDocument, String collectionName) {
        // TODO Auto-generated method stub
			return false;
    }

	/**
     * @see IBasicDocumentService#persist(DBObject, String)
     */
    public boolean persist(DBObject document, String collectionName) {
    	this.dbCollection = this.db.getCollection(collectionName);
    	try{
    		this.dbCollection.insert(document);
    		return true;
    	}catch(MongoException e){
    		this.logger.severe(e.toString());
    		return false;
    	}
    }

	/**
     * @see IBasicDocumentService#remove(DBObject, String)
     */
    public boolean remove(DBObject document, String collectionName) {
    	this.dbCollection = this.db.getCollection(collectionName);
    	try{
    		this.dbCollection.remove(document);
    		return true;
    	}catch(MongoException e){
    		this.logger.severe(e.toString());
    		return false;
    	}
    }

	@Override
	public DBObject findOneByQuery(String collectionName,
			Class<? extends DBObject> documentClass, DBObject queryObject) {
		// TODO Auto-generated method stub
		return null;
	}

}