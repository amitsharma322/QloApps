<?php
/**
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License version 3.0
* that is bundled with this package in the file LICENSE.md
* It is also available through the world-wide-web at this URL:
* https://opensource.org/license/osl-3-0-php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to support@qloapps.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade this module to a newer
* versions in the future. If you wish to customize this module for your needs
* please refer to https://store.webkul.com/customisation-guidelines for more information.
*
* @author Webkul IN
* @copyright Since 2010 Webkul
* @license https://opensource.org/license/osl-3-0-php Open Software License version 3.0
*/

class HotelRoomTypeBookingType extends ObjectModel
{
    public $id_product;
    public $id_booking_type;

    public static $definition =array(
        'table' => 'htl_room_type_booking_type',
        'primary' => 'id_room_type_booking_type',
        'fields' => array(
            'id_booking_type' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
            'id_product' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
        ),
    );

    public function getRoomTypeBookingTypes()
    {
        $moduleInstance = Module::getInstanceByName('hotelreservationsystem');
        return array(
                array('id' => HotelBookingDetail::PS_ROOM_UNIT_SELECTION_TYPE_DEFAULT, 'name' => $moduleInstance->l('Default', 'HotelRoomTypeBookingType')),
                array('id' => HotelBookingDetail::PS_ROOM_UNIT_SELECTION_TYPE_OCCUPANCY, 'name' => $moduleInstance->l('Room Occupancy', 'HotelRoomTypeBookingType')),
                array('id' => HotelBookingDetail::PS_ROOM_UNIT_SELECTION_TYPE_QUANTITY, 'name' => $moduleInstance->l('Rooms Quantity (No. of rooms)', 'HotelRoomTypeBookingType'))
            );
    }

    public function getRoomTypeBookingTypeByProduct($idProduct)
    {
        $sql = 'SELECT * FROM `'._DB_PREFIX_.$this->table.'`
            WHERE `id_product` ='.(int) $idProduct;

        return Db::getInstance()->executeS($sql);
    }

    public function getHotelRoomTypeBookingSelectedType($idProduct, $fallbackType = null)
    {
        $sql = 'SELECT `id_booking_type` FROM `'._DB_PREFIX_.$this->table.'`
            WHERE `id_product` ='.(int) $idProduct.'
            ORDER BY `id_room_type_booking_type` DESC';
        $row = Db::getInstance()->getRow($sql);
        $bookingType = null;
        if ($row && isset($row['id_booking_type'])) {
            $bookingType = (int) $row['id_booking_type'];
        }

        if ($bookingType !== null && $bookingType != HotelBookingDetail::PS_ROOM_UNIT_SELECTION_TYPE_DEFAULT) {
            return $bookingType;
        }

        if ($fallbackType === null) {
            $fallbackType = (int) Configuration::get('PS_FRONT_ROOM_UNIT_SELECTION_TYPE');
        }

        return (int) $fallbackType;
    }

    public function updateRoomTypeBookingType($idBookingTypes, $idProduct)
    {
        $res = true;
        if ($roomTypeBookingTypes = $this->getRoomTypeBookingTypeByProduct($idProduct)) {
            $roomTypeBookingTypes = array_column($roomTypeBookingTypes, 'id_room_type_booking_type', 'id_booking_type');
        }

        if ($idBookingTypes && !is_array($idBookingTypes)) {
            $idBookingTypes = array($idBookingTypes);
        }

        if ($idBookingTypes) {
            foreach ($idBookingTypes as $idBookingType) {
                // If room type booking type mapping already exits no need to update it.
                if (isset($roomTypeBookingTypes[$idBookingType])) {
                    unset($roomTypeBookingTypes[$idBookingType]);
                } else {
                    $objHotelRoomTypeBookingType = new self();
                    $objHotelRoomTypeBookingType->id_product = $idProduct;
                    $objHotelRoomTypeBookingType->id_booking_type = $idBookingType;
                    $res &=$objHotelRoomTypeBookingType->save();
                }
            }
        }

        // Removing the non selected booking types.
        if ($roomTypeBookingTypes) {
            $res &= $this->deleteRoomTypeBookingTypesById($roomTypeBookingTypes);
        }

        return $res;
    }

    public function deleteRoomTypeBookingTypesById($idRoomTypeBookingTypes)
    {
        $res = true;
        if ($idRoomTypeBookingTypes) {
            foreach ($idRoomTypeBookingTypes as $idRoomTypeBookingType) {
                $objHotelRoomTypeBookingType = new self($idRoomTypeBookingType);
                $res &= $objHotelRoomTypeBookingType->delete();
            }
        }

        return $res;
    }

    
}
