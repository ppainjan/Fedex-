create schema fed_ex; 

create table cities( city_id int primary key , city_name varchar(255) not null);

create table orders( tracking_id int primary key auto_increment,
					 Service varchar(255) not null,
                     weight varchar(255) not null,
                     dimensions varchar(255) not null,
                     signature_service varchar(255) not null,
                     total_pieces int not null,
                     packaging varchar(255) not null,
                     special_handeling_section varchar(255) not null,
                     order_shortest_travel varchar(1500) not null,
                     order_status varchar(255) not null,
                     orders_curr_city int default 0);
                     
create table order_route(tracking_id int primary key auto_increment,
						Source_city int not null,
                     Destination_city int not null);
                     
create table order_tracking( order_tracking_id int primary key auto_increment,
							 tracking_id int,
                             city int,
                             city_status varchar(255) not null,
                             tracking_date timestamp);          
                            
create table city_mapping( city_mapping_id int primary key auto_increment,
						   source_city int, 
                           destination_city int,
                           distance int not null,
                           foreign key (source_city) references cities(city_id),
                           foreign key (destination_city) references cities(city_id));

                             
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('1', 'Northborough, MA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('2', 'Edison, NJ');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('3', 'Pittsburgh, PA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('4', 'Allentown, PA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('5', 'Martinsburg, WV');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('6', 'Charlotte, NC');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('7', 'Atlanta, GA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('8', 'Orlando, FL');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('9', 'Memphis, TN');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('10', 'Grove City, OH');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('11', 'Indianapolis, IN');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('12', 'Detroit, MI');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('13', 'New Berlin, WI');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('14', 'Minneapolis, MN');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('15', 'St. Louis, MO');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('16', 'Kansas, KS');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('17', 'Dallas, TX');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('18', 'Houston, TX');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('19', 'Denver, CO');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('20', 'Salt Lake City, UT');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('21', 'Phoenix, AZ');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('22', 'Los Angeles, CA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('23', 'Chino, CA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('24', 'Sacramento, CA');
INSERT INTO `fed_ex`.`cities` (`city_id`, `city_name`) VALUES ('25', 'Seattle, WA');



INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('1', '1', '2', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('2', '1', '9', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('3', '2', '1', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('4', '2', '3', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('5', '3', '2', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('6', '3', '4', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('7', '3', '7', '7');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('8', '3', '8', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('9', '4', '3', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('10', '4', '5', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('11', '4', '7', '6');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('12', '5', '4', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('13', '5', '6', '1');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('14', '6', '5', '1');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('15', '6', '7', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('16', '6', '14', '6');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('17', '7', '6', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('18', '7', '4', '6');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('19', '7', '8', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('20', '7', '13', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('21', '8', '7', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('22', '8', '3', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('23', '8', '9', '1');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('24', '8', '11', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('25', '9', '8', '1');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('26', '9', '1', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('27', '9', '10', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('28', '10', '9', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('29', '10', '11', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('30', '10', '15', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('31', '11', '10', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('32', '11', '8', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('33', '11', '12', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('34', '12', '11', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('35', '12', '13', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('36', '12', '16', '7');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('37', '12', '18', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('38', '13', '12', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('39', '13', '7', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('40', '13', '14', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('41', '13', '17', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('42', '13', '19', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('43', '14', '13', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('44', '14', '6', '6');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('45', '14', '20', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('46', '15', '10', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('47', '15', '16', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('48', '15', '24', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('49', '16', '15', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('50', '16', '12', '7');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('51', '16', '17', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('52', '17', '16', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('53', '17', '13', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('54', '17', '18', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('55', '17', '23', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('56', '18', '17', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('57', '18', '12', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('58', '18', '19', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('59', '19', '18', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('60', '19', '13', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('61', '19', '20', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('62', '19', '22', '7');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('63', '20', '19', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('64', '20', '14', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('65', '20', '21', '6');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('66', '21', '20', '6');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('67', '21', '22', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('68', '21', '25', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('69', '22', '21', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('70', '22', '19', '7');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('71', '22', '23', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('72', '22', '25', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('73', '23', '22', '2');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('74', '23', '17', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('75', '23', '24', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('76', '23', '25', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('77', '24', '23', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('78', '24', '15', '5');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('79', '24', '25', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('80', '25', '24', '4');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('81', '25', '23', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('82', '25', '22', '3');
INSERT INTO `fed_ex`.`city_mapping` (`city_mapping_id`, `source_city`, `destination_city`, `distance`) VALUES ('83', '25', '21', '5');
                             
                             
INSERT INTO fed_ex.orders(tracking_id,Service,weight,dimensions,signature_service,total_pieces,packaging,special_handeling_section,order_shortest_travel,order_status)VALUES();

INSERT INTO fed_ex.order_tracking(order_tracking_id,tracking_id,city,city_status,tracking_date)VALUES();

                             
update orders set order_shortest_travel = "";
update orders set  order_status = "";
update orders set  orders_curr_city = 0;               
                