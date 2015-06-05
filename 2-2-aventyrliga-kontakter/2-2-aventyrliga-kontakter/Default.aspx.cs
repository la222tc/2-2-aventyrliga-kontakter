using _2_2_aventyrliga_kontakter.Model;
using _2_2_aventyrliga_kontakter.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _2_2_aventyrliga_kontakter
{
    public partial class Default : System.Web.UI.Page
    {
        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        private string SuccessMessage
        {
            get { return Session["SuccessMessage"] as string; }
            set { Session["SuccessMessage"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SuccessMessage != null)
            {
                SuccessPlaceHolder.Visible = true;
                SuccessLabel.Text = SuccessMessage;
                SuccessMessage = null;
            }
        }

        public IEnumerable<Contact> ContactListView_GetData()
        {
            return Service.GetContacts();
        }

        public Contact ContactListView_GetData2(int contactID)
        {
            return Service.GetContact(contactID);
        }

         public IEnumerable<Contact> GetContactsPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return Service.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }

         public void DeleteContact(int contactId)
         {
             try
             {
                 Service.DeleteContact(contactId);
             }
             catch (Exception)
             {
                 ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då kontaktuppgiften skulle tas bort.");
             }
         }

         public void ContactListView_InsertItem(Contact contact)
         {
             if (ModelState.IsValid)
             {
                     try
                     {
                         Service.SaveContact(contact);
                         SuccessMessage = String.Format("Kontakten har lagts till.");
                        // Response.Redirect(String.Format("?page={0}", (DataPager.TotalRowCount / DataPager.PageSize) + 1));
                         Response.Redirect(Request.RawUrl);
                     }
                     catch (Exception)
                     {
                         ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då kunduppgiften skulle läggas till.");
                     }
             }
         }
         public void ContactListView_UpdateItem(int contactId)
         {
             try
             {
                 var contact = Service.GetContact(contactId);

                 if (TryUpdateModel(contact))
                 {
                     Service.SaveContact(contact);
                 }
             }

             catch (ValidationException ex)
             {
                 foreach(var vr in ex.Data["ValidationResults"] as ICollection<ValidationResult>)
                 {
                     ModelState.AddModelError(String.Empty, vr.ErrorMessage);
                 }
             }
             catch (Exception)
             {
                 ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då kontaktppgiften skulle uppdateras.");
             }
         }
    }
}