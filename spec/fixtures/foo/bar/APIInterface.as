/* generated by rpcoder */

package foo.bar
{
    public interface APIInterface
    {
        function get baseUrl():String;
        function set errorHandler(handler : Function):void;
        function get errorHandler():Function;

        /**
        * get mail
        *
        * @id:int  
        * @foo:String ["A", "B"] 
        * @bar:Array  
        * @baz:Boolean  日本の文字
        * @success:Function
        * @error:Function
        */
        function getMail(id:int, foo:String, bar:Array, baz:Boolean, success:Function, error:Function = null):void;

        /**
        * get mails
        *
        * @success:Function
        * @error:Function
        */
        function getMails(success:Function, error:Function = null):void;

    }
}
