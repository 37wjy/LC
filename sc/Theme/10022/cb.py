
ret =\
    {
        'cb_play':
        {'round_result': [
            {
                'first': 'r',
                'act_pos': [31, 12, 28, 5, 41, 39],
                'act':    [-10, -10, 10, 10, 2, 4],  # 需分类
                'b_atk_pos': [],
                'r_atk_pos': [38],
                'b_super': [],
                'r_super': {}
            },
            {
                'first': 'b',
                'act_pos': [14, 23, 17, 45, 33],
                'act': [-10, 11, 2, 4, 4],
                'b_atk_pos': [],
                'r_atk_pos': [14],
                'b_super': [],
                'r_super': {}
            },
            {
                'first': 'b',
                'act_pos': [47, 45, 25, 6, 42],
                'act': [10, 3, -4, -4, -4],
                'b_atk_pos': [],
                'r_atk_pos': [],
                'b_super': [],
                'r_super': {}
            },
            {
                'first': 'r',
                'act_pos': [19, 40, 39, 27, 18],
                'act': [-10, 11, 10, 14, -4],
                'b_atk_pos': [],
                'r_atk_pos': [],
                'b_super': [],
                'r_super': {}
            },
            {
                'first': 'r',
                'act_pos': [2, 44, 7, 18, 38, 17, 29, 25, 45, 42, 34, 22],
                'act': [-10, -10, -10, -13, 10, 11, 3, -2, 2, -4, 4, 4],
                'b_atk_pos': [45, 8, 27],
                'r_atk_pos': [44, 43],
                'b_super': [],  # [24, 14, 0, 43, 3] if has
                'r_super': [
                    {
                        'r_atk_pos': [8], 'act_pos': [15, 4, 9, 35], 'act': [2, 4, 10, 12]
                    },
                    {
                        'r_atk_pos': [], 'act_pos': [33, 41], 'act': [4, 11]
                    }
                ]
            }
        ],
            'total_round': 5,
            'blue_total_win': 275,
            'red_total_win': 1050,
            'final_win': [1050, 275, 1050, 1050, 1050]},
     'cb_users': [
            {'cb_data': {'guid': 1001, 'credits': 100}, 'coins': 105000},
            {'cb_data': {'guid': 1002, 'credits': 100}, 'coins': 27500},
            {'cb_data': {'guid': 1003, 'credits': 100}, 'coins': 105000},
            {'cb_data': {'guid': 1004, 'credits': 100}, 'coins': 105000},
            {'cb_data': {'guid': 1005, 'credits': 200}, 'coins': 210000}
        ],
     'pick_list': [
         {
             'pick_result':
             {
                 '1001': {1: 1},
                 '1002': {1: 0},  # self
                 '1003': {1: 1},
                 '1004': {1: 1},
                 '1005': {1: 1}
             },
             'pick_id': 0}],
     'end': 0,
     'seed': 3}


ret={
    'cb_play': None, 
    'cb_users': [
        {'cb_data': {'guid': 1001, 'credits': 100}}, 
        {'cb_data': {'guid': 1002, 'credits': 100}}, 
        {'cb_data': {'guid': 1003, 'credits': 100}}, 
        {'cb_data': {'guid': 1004, 'credits': 100}}, 
        {'cb_data': {'guid': 1005, 'credits': 200}}], 
        'pick_list': [], 'end': 0, 'seed': 3
    }


'''
 0  1  2  3  4  5
 6  7  8  9  10 11
 12 13 14 15 16 17
 18 19 20 21 22 23
 24 25 26 27 28 29
 30 31 32 33 34 35
 36 37 38 39 40 41
 42 43 44 45 46 47
 '''

'''
normal:

b-  r+
1

                            symbol:

    atk:
    2

    up:
    3

    multi:[5, 10, 25, 50, 100, 150, 200]
    5        9,10
    10       11,12
    25       13,14
    50       15,16
    100      17,18
    150      19,20
    200      21,22


'''
