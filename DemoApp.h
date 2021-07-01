#ifndef _DEMOAPP_H
#define _DEMOAPP_H
enum{
	AM_L_MESSAGE = 131,
	AM_H_MESSAGE = 132,
	AM_T_MESSAGE = 133
};
typedef nx_struct l_message{
	nx_uint16_t lReading;
}l_message_t;

typedef nx_struct h_message{
	nx_uint16_t hReading;
}h_message_t;

typedef nx_struct t_message{
	nx_uint16_t tReading;
}t_message_t;
#endif
