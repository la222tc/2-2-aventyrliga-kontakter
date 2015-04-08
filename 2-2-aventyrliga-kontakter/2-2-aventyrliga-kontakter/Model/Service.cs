using _2_2_aventyrliga_kontakter.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace _2_2_aventyrliga_kontakter.Model
{
    public class Service
    {
        private ContactDAL _contactDAL;

        private ContactDAL ContactDAL
        {
            get { return _contactDAL ?? (_contactDAL = new ContactDAL()); }
        }

        public IEnumerable<Contact> GetContacts()
        {
            return ContactDAL.GetContacts();
        }
        
        public IEnumerable<Contact> GetContactsPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return ContactDAL.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }

        public Contact GetContact(int contactID)
        {
            return ContactDAL.GetContactByID(contactID);
        }  

        public void DeleteContact(int contactID)
        {
            ContactDAL.DeleteContact(contactID);
        }
        public void SaveContact(Contact contact)
        {
            var validationContext = new  ValidationContext(contact);
            var validationResults = new List<ValidationResult>();
            if (!Validator.TryValidateObject(contact,validationContext, validationResults))
            {
                var ex = new ValidationException("Objektet klarade inte valideringen");
                ex.Data.Add("ValidationResults", validationResults);
                throw ex;
            }
            if (contact.ContactID == 0)
            {
                ContactDAL.InsertContact(contact);
            }
            else
            {
                ContactDAL.UpdateContact(contact);
            }
        }
    }
}