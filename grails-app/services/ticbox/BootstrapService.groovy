package ticbox

class BootstrapService {

    def servletContext
    def serviceMethod() {

    }

    def init(){

        initLookupMaster()
        initProfileItems()

    }

    def destroy(){

    }

    def initLookupMaster(){

        if (LookupMaster.all.empty) {
            new LookupMaster(
                    code: 'LM_COUNTRIES001',
                    label: 'Countries',
                    values: [
                            ID : 'Indonesia',
                            MY : 'Malaysia',
                            SG : 'Singapore'
                    ]
            ).save()

            new LookupMaster(
                    code: 'LM_EDU001',
                    label: 'Education',
                    values: [
                            DEGREE : 'Bachelor',
                            MAGISTER : 'Magister',
                            DOCTOR : 'Doctor'
                    ]
            ).save()

            new LookupMaster(
                    code: 'LM_DUMMY001',
                    label: 'Dummy',
                    values: [
                            DMY1 : 'Dummy Item 1',
                            DMY2 : 'Dummy Item 2',
                            DMY3 : 'Dummy Item 3',
                            DMY4 : 'Dummy Item 4',
                            DMY5 : 'Dummy Item 5',
                    ]
            ).save()
        }

    }

    def initProfileItems(){

        ProfileItem address = ProfileItem.findByCode('PI_ADDR001')?:new ProfileItem(
                code: 'PI_ADDR001',
                label: 'Address',
                type: ProfileItem.TYPES.STRING,
                seq: 1
        )
        address['row'] = 3
        address['max'] = 150
        address['placeHolder'] = 'Address'
        address.save()

        ProfileItem occupation = ProfileItem.findByCode('PI_OCCUPATION001')?:new ProfileItem(
                code: 'PI_OCCUPATION001',
                label: 'Occupation',
                type: ProfileItem.TYPES.STRING,
                seq: 1
        )
        occupation['max'] = 30
        occupation['placeHolder'] = 'Occupation'
        occupation.save()

        ProfileItem country = ProfileItem.findByCode('PI_COUNTRY001')?:new ProfileItem(
                code: 'PI_COUNTRY001',
                label: 'Country',
                type: ProfileItem.TYPES.LOOKUP,
                seq: 3
        )
        country['lookupFrom'] = 'LM_COUNTRIES001'
        country.save()

        ProfileItem dob = ProfileItem.findByCode('PI_DOB001')?:new ProfileItem(
                code: 'PI_DOB001',
                label: 'Date of Birth',
                type: ProfileItem.TYPES.DATE,
                seq: 4
        )

        dob.save()

        ProfileItem height = ProfileItem.findByCode('PI_HEIGHT001')?:new ProfileItem(
                code: 'PI_HEIGHT001',
                label: 'Height',
                type: ProfileItem.TYPES.NUMBER,
                seq: 5
        )
        height['unit'] = 'cm'
        height['min'] = 5
        height['max'] = 1000
        height.save()

        ProfileItem weight = ProfileItem.findByCode('PI_WEIGHT001')?:new ProfileItem(
                code: 'PI_WEIGHT001',
                label: 'Weight',
                type: ProfileItem.TYPES.NUMBER,
                seq: 5
        )
        weight['unit'] = 'Kg'
        weight['min'] = 10
        weight['max'] = 500
        weight.save()

        ProfileItem education = ProfileItem.findByCode('PI_EDU001')?:new ProfileItem(
                code: 'PI_EDU001',
                label: 'Education',
                type: ProfileItem.TYPES.CHOICE,
                seq: 6
        )
        education['lookupFrom'] = 'LM_EDU001'
        education['componentType'] = ProfileItem.COMPONENT_TYPES.SELECT
        education.save()

        ProfileItem hobby = ProfileItem.findByCode('PI_HOBBY001')?:new ProfileItem(
                code: 'PI_HOBBY001',
                label: 'Hobby',
                type: ProfileItem.TYPES.CHOICE,
                seq: 7
        )
        hobby['items'] = [
                'Sport',
                'Photography',
                'Game',
                'Programming',
                'Etc.'
        ]
        hobby['componentType'] = ProfileItem.COMPONENT_TYPES.CHK_BOX
        hobby.save()

        ProfileItem dummy1 = ProfileItem.findByCode('PI_DMY001')?:new ProfileItem(
                code: 'PI_DMY001',
                label: 'Dummy Profile Item 1',
                type: ProfileItem.TYPES.CHOICE,
                seq: 8
        )
        dummy1['lookupFrom'] = 'LM_DUMMY001'
        dummy1['componentType'] = ProfileItem.COMPONENT_TYPES.CHK_BOX
        dummy1.save()

        ProfileItem dummy2 = ProfileItem.findByCode('PI_DMY002')?:new ProfileItem(
                code: 'PI_DMY002',
                label: 'Dummy Profile Item 2',
                type: ProfileItem.TYPES.CHOICE,
                seq: 9
        )
        dummy2['items'] = [
                'Dummy Item 1',
                'Dummy Item 2',
                'Dummy Item 3',
                'Dummy Item 4',
                'Dummy Item 5',
                'Etc.'
        ]
        dummy2['componentType'] = ProfileItem.COMPONENT_TYPES.RADIO
        dummy2.save()

        ProfileItem dummy3 = ProfileItem.findByCode('PI_DMY003')?:new ProfileItem(
                code: 'PI_DMY003',
                label: 'Dummy Profile Item 3',
                type: ProfileItem.TYPES.CHOICE,
                seq: 10
        )
        dummy3['lookupFrom'] = 'LM_DUMMY001'
        dummy3['componentType'] = ProfileItem.COMPONENT_TYPES.RADIO
        dummy3.save()

        ProfileItem dummy4 = ProfileItem.findByCode('PI_DMY004')?:new ProfileItem(
                code: 'PI_DMY004',
                label: 'Dummy Profile Item 4',
                type: ProfileItem.TYPES.CHOICE,
                seq: 11
        )
        dummy4['items'] = [
                'Dummy Item 1',
                'Dummy Item 2',
                'Dummy Item 3',
                'Dummy Item 4',
                'Dummy Item 5',
                'Etc.'
        ]
        dummy4['componentType'] = ProfileItem.COMPONENT_TYPES.SELECT
        dummy4['multiple'] = true
        dummy4.save()

    }
}
