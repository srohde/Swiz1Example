/*
   Copyright 2010 Samuel Ahn

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */

package com.foomonger.swizframework.processors
{

	import flash.utils.getDefinitionByName;

	import org.osflash.signals.IDeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.swizframework.core.Bean;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.reflection.MetadataArg;
	import org.swizframework.reflection.MetadataHostMethod;
	import org.swizframework.reflection.MethodParameter;

	/**
	 * MediateSignalProcessor is the Signal version of MediateProcessor. After defining
	 * Signal or DeluxeSignal Beans, decorate Signal listener methods with the [MediateSignal]
	 * metadata tag and set a bean name ("bean" property) or type ("type" property) which
	 * is useful when subclassing Signals. "bean" is the default property. You may also use
	 * the "priority" property for DeluxeSignals.
	 */
	public class MediateSignalProcessor extends BaseMetadataProcessor
	{

		protected static const MEDIATE_SIGNAL:String = "MediateSignal";

		public function MediateSignalProcessor()
		{
			super([MEDIATE_SIGNAL]);
		}

		override public function setUpMetadataTag(metadataTag:IMetadataTag, bean:Bean):void
		{
			var signalBean:Bean;

			if( metadataTag.args.length )
			{
				signalBean = getSignalBean(metadataTag);
			}
			else
			{
				var method:MetadataHostMethod = metadataTag.host as MetadataHostMethod;
				var param:MethodParameter = method.parameters[0] as MethodParameter;
				signalBean = beanFactory.getBeanByType(param.type);
			}

			if( signalBean )
			{
				var listener:Function = bean.source[ metadataTag.host.name ];

				if( signalBean.source is ISignal )
				{
					var signal:ISignal = signalBean.source as ISignal;
					signal.add(listener);
				}
				else if( signalBean.source is IDeluxeSignal )
				{
					var deluxeSignal:IDeluxeSignal = signalBean.source as IDeluxeSignal;
					var priorityArg:MetadataArg = metadataTag.getArg("priority");
					var priority:int = priorityArg ? int(priorityArg.value) : 0;
					deluxeSignal.add(listener, priority);
				}
			}
		}

		override public function tearDownMetadataTag(metadataTag:IMetadataTag, bean:Bean):void
		{
			var signalBean:Bean = getSignalBean(metadataTag);

			if( signalBean )
			{
				var listener:Function = bean.source[ metadataTag.host.name ];

				if( signalBean.source is ISignal )
				{
					var signal:ISignal = signalBean.source as ISignal;
					signal.remove(listener);
				}
				else if( signalBean.source is IDeluxeSignal )
				{
					var deluxeSignal:IDeluxeSignal = signalBean.source as IDeluxeSignal;
					deluxeSignal.remove(listener);
				}
			}
		}

		private function getSignalBean(metadataTag:IMetadataTag):Bean
		{
			var signalBean:Bean;

			// First find Bean by name
			var beanName:String;
			var defaultArg:MetadataArg = metadataTag.getArg("");
			if( defaultArg )
			{
				beanName = defaultArg.value;
			}
			else
			{
				var beanArg:MetadataArg = metadataTag.getArg("bean");
				if( beanArg )
				{
					beanName = beanArg.value;
				}
			}
			if( beanName )
			{
				signalBean = beanFactory.getBeanByName(beanName)
			}

			// If not found by Name, then find by Type
			if( signalBean == null )
			{
				var typeArg:MetadataArg = metadataTag.getArg("type");
				if( typeArg )
				{
					var type:Class = getDefinitionByName(typeArg.value) as Class;
					if( type )
					{
						signalBean = beanFactory.getBeanByType(type);
					}
				}
			}

			return signalBean;
		}

	}
}