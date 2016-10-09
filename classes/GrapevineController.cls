public class GrapevineController
{
    private Id projectId;

    public GrapevineController()
    {
        projectId = ApexPages.currentPage().getParameters().get( 'id' );
    }

    private Project__c projectRecord
    {
        get
        {
            if ( projectRecord == null && projectId != null )
            {
                projectRecord =
                [   SELECT  Id, Name,
                            Account__r.Id, Account__r.Name
                    FROM    Project__c
                    WHERE   Id = :projectId
                ];
            }
            return projectRecord;
        }
        private set;
    }

    public String projectAsJson
    {
        get
        {
            return JSON.Serialize( projectRecord );
        }
    }

    private List<Iteration__c> iterations
    {
        get
        {
            if ( iterations == null && projectId != null )
            {
                iterations =
                [   SELECT  Id, Iteration_Number__c, Start_Date__c, End_Date__c
                    FROM    Iteration__c
                    WHERE   Project__c = :projectId
                ];
            }
            return iterations;
        }
        private set;
    }
    
    public String iterationsAsJson
    {
        get
        {
            return JSON.Serialize( iterations );
        }
    }
    
    private List<Node__c> nodes
    {
        get
        {
            if ( nodes== null && projectId != null )
            {
                nodes=
                [   SELECT  Id, Name, Description__c, Start_Date__c, End_Date__c, Phase_Angle__c, Owner__r.Name,
                    (   SELECT  Id, Information__c, Iteration__r.Iteration_Number__c, Node_Status__c
                        FROM    Iteration_Nodes__r
                    )
                    FROM    Node__c
                    WHERE   Project__c = :projectId
                ];
            }
            return nodes;
        }
        private set;
    }
    
    public String nodesAsJson
    {
        get
        {
            return JSON.Serialize( nodes );
        }
    }
}