//
//  Variables.h
//  reuters-wider
//
//  Created by BARDON Clement on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#ifndef reuters_wider_Variables_h
#define reuters_wider_Variables_h

//UIFont *CalibreRegular = [UIFont fontWithName:@"Calibre-Reg" size:18];
//UIFont *CalibreLight = [UIFont fontWithName:@"Calibre-Light" size:18];
//UIFont *LeituraRoman3 = [UIFont fontWithName:@"Leitura-Roman3" size:18];
//UIFont *LeituraRoman1 = [UIFont fontWithName:@"Leitura-Roman1" size:18];
//UIFont *LeituraItalic2 = [UIFont fontWithName:@"Leitura-Italic2" size:18];
//UIFont *ArcherXLight = [UIFont fontWithName:@"Archer-XLight" size:18];
//UIFont *ArcherThin = [UIFont fontWithName:@"Archer-Thin" size:18];
//UIFont *LeituraNewsRoman1 = [UIFont fontWithName:@"Leitura-NewsRoman1" size:18];

// Fonts
#define CALIBRE_REG [UIFont fontWithName:@"Calibre-Regular" size:18]
#define LEITURA_ROMAN_2 [UIFont fontWithName:@"Leitura-Roman2" size:17]
#define LEITURA_ROMAN_3_34 [UIFont fontWithName:@"Leitura-Roman3" size:34]
#define LEITURA_ITALIC_1_15 [UIFont fontWithName:@"Leitura-Italic1" size:15]

// ----
// Article related
// ----

// ---- Fonts ----
// Part title
#define LEITURA_ROMAN_3_36 [UIFont fontWithName:@"Leitura-Roman3" size:36]
// Duration part reading
#define CALIBRE_LIGHT_16 [UIFont fontWithName:@"Calibre-Light" size:16]

// Bloc meta
#define CALIBRE_REG_11 [UIFont fontWithName:@"Calibre-Regular" size: 11]

// Bloc teasing
#define LEITURA_ROMAN_3_23 [UIFont fontWithName:@"Leitura-Roman3" size:23]

// Bloc paragraph
#define LEITURA_ROMAN_1_17 [UIFont fontWithName:@"Leitura-Roman1" size:17]

// Bloc statement
#define LEITURA_ITALIC_2_20 [UIFont fontWithName:@"Leitura-Italic2" size:20]

// Bloc pov
// Top part
#define CALIBRE_LIGHT_14 [UIFont fontWithName:@"Calibre-Light" size:14]
#define LEITURA_ROMAN_2_23 [UIFont fontWithName:@"Leitura-Roman2" size:23]
// Bottom part
#define ARCHER_THIN_38 [UIFont fontWithName:@"ArcherPro-Thin" size:38]

// Bloc subtitle
#define LEITURA_ROMAN_3_19 [UIFont fontWithName:@"Leitura-Roman3" size:19]

// Bloc figure
// Name
#define LEITURA_ROMAN_2_32 [UIFont fontWithName:@"Leitura-Roman2" size:32]
// Date
#define LEITURA_ROMAN_3_16 [UIFont fontWithName:@"Leitura-Roman3" size:16]
#define LEITURA_ROMAN_1_16 [UIFont fontWithName:@"Leitura-Roman1" size:16]

// Bloc aside
#define CALIBRE_LIGHT_17 [UIFont fontWithName:@"Calibre-Light" size:17]

// Bloc keywords
#define CALIBRE_REG_15 [UIFont fontWithName:@"Calibre-Regular" size:15]

// Bloc transition
#define LEITURA_ITALIC_2_38 [UIFont fontWithName:@"Leitura-Italic2" size:38]

// Glossary
#define CALIBRE_LIGHT_15 [UIFont fontWithName:@"Calibre-Light" size:15]
#define LEITURA_ROMAN_4_32 [UIFont fontWithName:@"Leitura-Roman4" size:32]
// ---- End fonts ----

// ---- Colors ----
// Part title
#define DARKEST_GREY_COLOR [UIColor colorWithRed:(18.0f/255.0f) green:(18.0f/255.0f) blue:(18.0f/255.0f) alpha:1.0f]
#define BLUE_COLOR [UIColor colorWithRed:(74.0f/255.0f) green:(76.0f/255.0f) blue:(159.0f/255.0f) alpha:1.0f]

// Bloc meta
#define LIGHT_BLUE_COLOR [UIColor colorWithRed:(146.0f/255.0f) green:(148.0f/255.0f) blue:(197.0f/255.0f) alpha:1.0f]

// Bloc paragraph
#define GREY_COLOR [UIColor colorWithRed:(67.0f/255.0f) green:(67.0f/255.0f) blue:(67.0f/255.0f) alpha:1.0f]

// Bloc pov
#define MIDDLE_BLUE_COLOR [UIColor colorWithRed:(83.0f/255.0f) green:(91.0f/255.0f) blue:(168.0f/255.0f) alpha:1.0f]
#define TEXT_GRADIENT_BLUE_COLOR [UIColor colorWithRed:(2.0f/255.0f) green:(22.0f/255.0f) blue:(168.0f/255.0f) alpha:1.0f]
#define TEXT_GRADIENT_ORANGE_COLOR [UIColor colorWithRed:(255.0f/255.0f) green:(92.0f/255.0f) blue:(54/255.0f) alpha:1.0f]

// Bloc figure
// BG
#define BLUE_GREY_COLOR [UIColor colorWithRed:(235.0f/255.0f) green:(236.0f/255.0f) blue:(243.0f/255.0f) alpha:1.0f]
// Txt
#define DARK_GREY_COLOR [UIColor colorWithRed:(42.0f/255.0f) green:(42.0f/255.0f) blue:(42.0f/255.0f) alpha:1.0f]
#define COOL_GREY_COLOR [UIColor colorWithRed:(80.0f/255.0f) green:(80.0f/255.0f) blue:(80.0f/255.0f) alpha:1.0f]

// Bloc transition
// BG
#define LIGHT_BLUE_BG [UIColor colorWithRed:(202.0f/255.0f) green:(210.0f/255.0f) blue:(239.0f/255.0f) alpha:1.0f]
// Txt
#define DARK_BLUE_COLOR [UIColor colorWithRed:(27.0f/255.0f) green:(24.0f/255.0f) blue:(98.0f/255.0f) alpha:1.0f]

// Glossary
#define LIGHT_GREY_COLOR [UIColor colorWithRed:(152.0f/255.0f) green:(152.0f/255.0f) blue:(152.0f/255.0f) alpha:1.0f]
#define LETTER_BLUE_COLOR [UIColor colorWithRed:(0.0f/255.0f) green:(18.0f/255.0f) blue:(137.0f/255.0f) alpha:1.0f]
// ---- End colors ----

// ----
// End article related
// ----

// Colors
#define WIDER_DARK_BLUE_COLOR [UIColor colorWithRed:(0.0f/255.0f) green:(4.0f/255.0f) blue:(130.0f/255.0f) alpha:1.0f]
#define ISSUE_NR_COLOR [UIColor colorWithRed:(77.0f/255.0f) green:(77.0f/255.0f) blue:(77.0f/255.0f) alpha:1.0f]
#define BLACK_COLOR [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:1.0f]
#define WHITE_COLOR [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f]

#endif
