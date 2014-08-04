//
// Created by Christian on 7/27/14.
// Copyright (c) 2014 Christian Gilbert. All rights reserved.
//

#import "IntiUtils.h"


@implementation IntiUtils {

}

+ (BOOL)validaCedula:(NSString *)cedula{
    NSString *prov = [cedula substringToIndex:2];
    int lv_prov = [prov intValue];
    if (lv_prov >= 1 && lv_prov <= 24)
    {
        NSString *lv_numced = cedula;
        int ll_TenDig = [[cedula substringFromIndex:9] intValue];
        int ll_sum = 0;
        int ll_Cnt = 0;
        int ll_CntPos = 0;
        while (ll_CntPos <=8){
            ll_CntPos = 2 * ll_Cnt + 1   ;
            NSRange range = NSMakeRange((NSUInteger) (ll_CntPos- 1), 1);
            int lv_StrNum = [[lv_numced substringWithRange:range] intValue];


            int ll_multi = lv_StrNum * 2;
            if (ll_multi >= 10)
            {ll_multi = 1 + (ll_multi % 10);}
            ll_sum += ll_multi;
            ll_Cnt += 1;

        }

        ll_Cnt = 1;
        ll_CntPos = 1;
        while (ll_CntPos <=7){

            ll_CntPos = 2 * ll_Cnt ;

            NSRange range2 = NSMakeRange((NSUInteger) (ll_CntPos- 1), 1);
            int lv_StrNum = [[lv_numced substringWithRange:range2] intValue];
            ll_sum += lv_StrNum;
            ll_Cnt += 1;


        }
        int ll_cociente = floor(ll_sum / 10);
        int ll_decena = (ll_cociente + 1) * 10;
        int ll_verificador = ll_decena - ll_sum;

        if (ll_verificador == 10)
        {
            ll_verificador = 0;

        }
        if (ll_verificador == ll_TenDig){
            return YES;

        }
        else{
            return NO;
        }
    }
    else{
        return NO;
    }

}

+ (BOOL)validaRUC:(NSString *)ruc{
    if (ruc.length != 13)
        return NO;

    int suma = 0;
    int residuo = 0;

    BOOL pri = NO;
    BOOL pub = NO;
    BOOL nat = NO;

    int numeroProvincias = 24;
    int modulo = 11;

    int d1, d2, d3, d4, d5, d6,d7,d8,d9,d10;
    int p1, p2, p3, p4, p5, p6, p7, p8, p9;

    d1 = [ [ruc substringWithRange:NSMakeRange(0, 1)] intValue] ;
    d2 = [ [ruc substringWithRange:NSMakeRange(1, 1)] intValue] ;
    d3 = [ [ruc substringWithRange:NSMakeRange(2, 1)] intValue] ;
    d4 = [ [ruc substringWithRange:NSMakeRange(3, 1)] intValue] ;
    d5 = [ [ruc substringWithRange:NSMakeRange(4, 1)] intValue] ;
    d6 = [ [ruc substringWithRange:NSMakeRange(5, 1)] intValue] ;
    d7 = [ [ruc substringWithRange:NSMakeRange(6, 1)] intValue] ;
    d8 = [ [ruc substringWithRange:NSMakeRange(7, 1)] intValue] ;
    d9 = [ [ruc substringWithRange:NSMakeRange(8, 1)] intValue] ;
    d10 = [ [ruc substringWithRange:NSMakeRange(9, 1)] intValue] ;

    if (d3 == 7 || d3 ==8)
    {
        return  NO;
    }


    if (d3 < 6){
        nat = YES;
        p1 = d1 * 2;
        if (p1 >= 10){p1 -= 9;}
        p2 = d2 * 1;
        if (p2 >= 10){p2 -= 9;}
        p3 = d3 * 2;
        if (p3 >= 10){p3 -= 9;}
        p4 = d4 * 1;
        if (p4 >= 10){p4 -= 9;}
        p5 = d5 * 2;
        if (p5 >= 10){p5 -= 9;}
        p6 = d6 * 1;
        if (p6 >= 10){p6 -= 9;}
        p7 = d7 * 2;
        if (p7 >= 10){p7 -= 9;}
        p8 = d8 * 1;
        if (p8 >= 10){p8 -= 9;}
        p9 = d9 * 2;
        if (p9 >= 10){p9 -= 9;}

        modulo = 10;

    }
    else if (d3 == 6){
        pub =  YES;
        p1 = d1 * 3;
        p2 = d2 * 2;
        p3 = d3 * 7;
        p4 = d4 * 6;
        p5 = d5 * 5;
        p6 = d6 * 4;
        p7 = d7 * 3;
        p8 = d8 * 2;
        p9 = 0 ;
    }
    else if (d3 == 9){
        pri = YES;
        p1 = d1 * 4;
        p2 = d2 * 3;
        p3 = d3 * 2;
        p4 = d4 * 7;
        p5 = d5 * 6;
        p6 = d6 * 5;
        p7 = d7 * 4;
        p8 = d8 * 3;
        p9 = d9 * 2;

    }
    suma = p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9;
    residuo = suma % modulo;
    if (residuo == 0)
    {residuo = 0;}
    else
    {residuo = modulo - residuo;}
    int digitoVerificador = residuo;
    if (pub)
    {
        if (digitoVerificador != d9) {
            return NO;
        }

        if ( ![[ruc substringWithRange:NSMakeRange(10, 4)] isEqualToString:@"0001"] ){
            return NO;
        }
    }
    if (pri)
    {
        if (digitoVerificador != d10) {
            return NO;
        }

        if ( ![[ruc substringWithRange:NSMakeRange(10, 3)] isEqualToString:@"001"] ){
            return NO;
        }
    }

    if (nat)
    {
        if (digitoVerificador != d10) {
            return NO;
        }

        if ( ruc.length > 10 &&  ![[ruc substringWithRange:NSMakeRange(10, 3)] isEqualToString:@"001"] ){
            return NO;
        }
    }


    return YES;


}

@end