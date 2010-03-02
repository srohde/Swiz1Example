package com.soenkerohde.example.processor
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.CursorManager;
	import mx.utils.StringUtil;

	import org.swizframework.core.Bean;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.reflection.MetadataArg;
	import org.swizframework.utils.services.URLRequestUtil;

	/**
	 * Example:
	 *
	 * [Bindable]
	 * [YahooFinance(tickerSymbol="ADBE", days="60")]
	 * public var adobeStocks:IList;
	 *
	 * <mx:LineChart id="chart" width="100%" height="100%" showDataTips="true" dataProvider="{adobeStocks}">
	 * 		<mx:horizontalAxis>
	 * 			<mx:CategoryAxis categoryField="date" title="Time" />
	 * 		</mx:horizontalAxis>
	 * 		<mx:verticalAxis>
	 * 			<mx:LinearAxis title="Price" baseAtZero="false" />
	 * 		</mx:verticalAxis>
	 * 		<mx:series>
	 * 			<mx:LineSeries displayName="Adobe" xField="date" yField="price" />
	 * 		</mx:series>
	 * </mx:LineChart>
	 * <mx:Legend dataProvider="{chart}" />
	 *
	 * @author soenkerohde
	 *
	 */
	public class YahooFinanceProcessor extends BaseMetadataProcessor
	{

		private static const LOG:ILogger = Log.getLogger("YahooFinanceProcessor");

		/**
		 * placeholders
		 * 0 tickerSymbol
		 * 1 startYear
		 * 2 startMonth
		 * 3 startDay
		 * 4 endYear
		 * 5 endMonth
		 * 6 endDay
		 */
		protected static const serviceUrl:String = "http://ichart.finance.yahoo.com/table.csv?s={0}&d={5}&e={6}&f={4}&g=d&a={2}&b={3}&c={1}&ignore=.csv";

		public function YahooFinanceProcessor()
		{
			super(["YahooFinance"]);
		}

		override public function setUpMetadataTag(metadataTag:IMetadataTag, bean:Bean):void
		{
			LOG.info("setUpMetadataTag " + metadataTag.toString());

			if( !bean.source[metadataTag.host.name] is IList )
			{
				throw new Error("YahooFinance source must be of type IList but is " + bean.source[metadataTag.host.name]);
				return;
			}

			var tickerSymbolArg:MetadataArg = metadataTag.getArg("tickerSymbol");
			var daysArg:MetadataArg = metadataTag.getArg("days");

			if( tickerSymbolArg != null && daysArg != null )
			{
				var days:Number = Number(daysArg.value);
				var today:Date = new Date();
				// calculate start date by subtracting time in msc
				var startDate:Date = new Date(today.getTime() - days * 24 * 60 * 60 * 1000);

				var startYear:Number = startDate.getFullYear();
				var startMonth:Number = startDate.getMonth();
				var startDay:Number = startDate.getDate();

				var endYear:Number = today.getFullYear();
				var endMonth:Number = today.getMonth();
				var endDay:Number = today.getDate();

				LOG.info("get stocks between " + startYear + "-" + startMonth + "-" + startDay + " and " + endYear + "-" + endMonth + "-" + endDay);

				var tickerSymbol:String = tickerSymbolArg.value;
				var url:String = StringUtil.substitute(serviceUrl, tickerSymbol, startYear, startMonth, startDay, endYear, endMonth, endDay);
				var request:URLRequest = new URLRequest(url);

				var urlRequestUtil:URLRequestUtil = new URLRequestUtil();
				urlRequestUtil.executeURLRequest(request, resultHandler, faultHandler, null, null, [metadataTag, bean]);
			}
			else
			{
				throw new Error("YahooFinance tag must defined tickerSymbol and days " + metadataTag.toString() + " bean " + bean);
			}
		}

		protected function resultHandler(event:Event, metadataTag:IMetadataTag, bean:Bean):void
		{
			var data:String = URLLoader(event.currentTarget).data as String;
			bean.source[metadataTag.host.name] = getListFromCVS(data);
		}

		protected function faultHandler(event:Event):void
		{
			LOG.error("faultHandler " + event.toString());
		}

		override public function tearDownMetadataTag(metadataTag:IMetadataTag, bean:Bean):void
		{
			LOG.info("tearDownMetadataTag " + metadataTag.name);
		}

		protected function getListFromCVS(str:String):IList
		{
			var a:Array = str.split("\n");
			// remove column line
			a.shift();

			var stocks:Array = [];
			for each( var s:String in a )
			{
				var stockDay:Array = s.split(",");
				var dateString:String = stockDay[0];
				var dateArray:Array = dateString.split("-");
				// month -1 because AS3 Date month starts at 0
				var date:Date = new Date(dateArray[0], dateArray[1] - 1, dateArray[2]);
				stocks.push({date:date, price:stockDay[6]});
			}

			LOG.info("stockDates " + stocks.length);

			// change order to ascending date
			stocks = stocks.reverse();
			// remove last empty line
			stocks.shift();

			return new ArrayCollection(stocks);
		}
	}
}