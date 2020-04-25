//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace onlineQuiz_bsef17m35
{
    using System;
    using System.Collections.Generic;
    
    public partial class Question
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Question()
        {
            this.QuestionOption = new HashSet<QuestionOption>();
        }
    
        public string title { get; set; }
        public string description { get; set; }
        public string type { get; set; }
        public int quizId { get; set; }
        public int teacherId { get; set; }
        public int id { get; set; }
        public int marks { get; set; }
    
        public virtual QuestionType QuestionType { get; set; }
        public virtual Quiz Quiz { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<QuestionOption> QuestionOption { get; set; }
    }
}