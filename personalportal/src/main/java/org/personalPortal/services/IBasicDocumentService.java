package org.personalPortal.services;

import com.mongodb.DBObject;

/**
 * <p>Represents basic CRUD operations related to MongoDB documents. A document service is responsible for obtaining a DB reference</p>
 * 
 * @author AffanHasan
 */
public interface IBasicDocumentService {

	public boolean persist(DBObject document, String collectionName);
	
	public boolean update(DBObject OriginalDocument, DBObject updatedDocument, String collectionName);
	
	/**
	 * <p>The object that documents to be removed must match.</p>
	 * @param document
	 * @param collectionName
	 * @return
	 */
	public boolean remove(DBObject document, String collectionName);
	
	/**
	 * <p>Returns a single document based on the criteria query object passed to it.</p>
	 * @param collectionName
	 * @param documentClass
	 * @param queryObject
	 * @return
	 */
	public DBObject findOneByQuery(String collectionName, Class<? extends DBObject> documentClass, DBObject queryObject);
	
	/**
	 * <p>Returns a single document based on the id passed as parameter.</p>
	 * @param collectionName
	 * @param documentClass
	 * @param queryObject
	 * @return
	 */
	public DBObject findOneById(String collectionName, Class<? extends DBObject> documentClass, Object id);
}