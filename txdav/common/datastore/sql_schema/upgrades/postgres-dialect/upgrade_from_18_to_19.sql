----
-- Copyright (c) 2012-2017 Apple Inc. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
----

---------------------------------------------------
-- Upgrade database schema from VERSION 18 to 19 --
---------------------------------------------------


-- Calendar home related updates

alter table CALENDAR_HOME_METADATA
 add column DEFAULT_EVENTS           integer     default null references CALENDAR on delete set null,
 add column DEFAULT_TASKS            integer     default null references CALENDAR on delete set null,
 add column ALARM_VEVENT_TIMED       text        default null,
 add column ALARM_VEVENT_ALLDAY      text        default null,
 add column ALARM_VTODO_TIMED        text        default null,
 add column ALARM_VTODO_ALLDAY       text        default null;


-- Calendar bind related updates

alter table CALENDAR_BIND
 add column BIND_REVISION			 integer     default 0 not null,
 add column TRANSP                   integer     default 0 not null,
 add column ALARM_VEVENT_TIMED       text        default null,
 add column ALARM_VEVENT_ALLDAY      text        default null,
 add column ALARM_VTODO_TIMED        text        default null,
 add column ALARM_VTODO_ALLDAY       text        default null;

create table CALENDAR_TRANSP (
  ID          integer     primary key,
  DESCRIPTION varchar(16) not null unique
);

insert into CALENDAR_TRANSP values (0, 'opaque' );
insert into CALENDAR_TRANSP values (1, 'transparent');


-- Addressbook bind related updates

alter table ADDRESSBOOK_BIND
 add column BIND_REVISION			 integer     default 0 not null;


-- Now update the version
-- No data upgrades
update CALENDARSERVER set VALUE = '19' where NAME = 'VERSION';
