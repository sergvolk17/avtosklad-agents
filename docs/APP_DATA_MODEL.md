# AutoSklad App — модель данных V1

## Master-data
Docpart / магазин остается источником истины для:
- товаров;
- предложений поставщиков;
- цен;
- остатков;
- заказов;
- статусов заказов;
- клиентских цен.

Приложение не должно копировать эти данные как независимую бизнес-базу.

## App-owned data

### UserAppProfile
- user_id
- push_preferences
- marketing_consent
- preferred_store
- preferred_delivery_method

### Vehicle
- id
- user_id
- vin
- make
- model
- generation
- year
- engine
- engine_code
- transmission
- primary
- created_at

### VehicleSavedProduct
- vehicle_id
- product_id
- label
- last_order_id
- created_at

### ServiceHistory
- id
- vehicle_id
- date
- mileage
- service_type
- note
- related_order_id
- service_partner_id

### PushDevice
- id
- user_id
- platform
- token
- last_seen
- enabled

### ServicePartner
- id
- name
- address
- coordinates
- phone
- services
- rating
- monetization_plan
- active

### ServiceBooking
- id
- user_id
- vehicle_id
- service_partner_id
- service_code
- scheduled_at
- status
- lead_fee
- created_at

### ChatThread
- id
- user_id
- order_id nullable
- vehicle_id nullable
- topic
- assigned_to
- status

### AppEvent
Для аналитики:
- user_id
- session_id
- event_name
- entity_type
- entity_id
- properties
- created_at

## Интеграционные ключи
Любая сущность из магазина должна иметь стабильный внешний ID:
- docpart_user_id
- docpart_product_id
- docpart_order_id
- docpart_storage_id

Не связывать системы по отображаемому имени или артикулу, если есть внутренний ID.
