//
//  PartyColours.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import UIKit

// An enum that defines the different colour settings
enum ColourScheme {
    case FlatColours
    case OfficiallyBoringColours
}

// some constant political party colours... (cool colours from http://flatuicolors.com/ )
class PartyColours {
    
    //a b c d e f g h i j k l m n o p q r s t u v w x y z
    //s t u v w x y z
    class func colourForParty(partyName :String!) -> UIColor {
        // See what setting the user wants...
        var theme:ColourScheme = ColourScheme.FlatColours
        
        // check settings...
        let defaults:NSUserDefaults = NSUserDefaults()
        let useOfficialColours:Bool = defaults.boolForKey("useOfficialColourScheme")
        
        if useOfficialColours {
            theme = ColourScheme.OfficiallyBoringColours
        }

        if partyName == "All People's Party" {
            // APP Orange
            return UIColor(red: (230.0000/255.0), green: (126.0000/255.0), blue: (34.0000/255.0), alpha: (1.0000))
        } else if partyName == "Alliance - Alliance Party of Northern Ireland" {
            // APNI Yellow
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (245.0000/255.0), green: (171.0000/255.0), blue: (53.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (246.0000/255.0), green: (203.0000/255.0), blue: (47.0000/255.0), alpha: (1.0000))
            }
        } else if partyName == "Alliance for Green Socialism" {
            // AGS Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (63.0000/255.0), green: (195.0000/255.0), blue: (47.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (168.0000/255.0), blue: (107.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Al-Zebabist Nation of Ooog" {
            // AZNO Black
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (51.0000/255.0), green: (51.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (0.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Bournemouth Independent Alliance" {
            //BIA Orange
            return UIColor(red: (250.0000/255.0), green: (117.0000/255.0), blue: (55.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "British National Party" {
            // BNP Black
            return UIColor(red: (0.0000/255.0), green: (0.0000/255.0), blue: (139.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Cannabis is Safer than Alcohol" {
            // Cannabis Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (77.0000/255.0), green: (175.0000/255.0), blue: (124.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (112.0000/255.0), green: (144.0000/255.0), blue: (95.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Christian Party \"Proclaiming Christ's Lordship\"" {
            // Christian Purple
                return UIColor(red: (153.0000/255.0), green: (102.0000/255.0), blue: (204.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Christian Peoples Alliance" {
            // Christian Violet
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (154.0000/255.0), green: (18.0000/255.0), blue: (179.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (170.0000/255.0), green: (0.0000/255.0), blue: (170.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Class War" {
            // Class War Black
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (51.0000/255.0), green: (51.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (0.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Communist Party of Britain" {
            // Communist Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (192.0000/255.0), green: (57.0000/255.0), blue: (43.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (238.0000/255.0), green: (28.0000/255.0), blue: (37.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Communist League Election Campaign" {
            // Communist Pinkish
            return UIColor(red: (199.0000/255.0), green: (21.0000/255.0), blue: (133.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Communities United Party" {
            // CUP Yellow
            return UIColor(red: (227.0000/255.0), green: (216.0000/255.0), blue: (75.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Conservative Party" || partyName == "Conservative and Unionist Party" {
            // Same party has two names in different parts of the UK... because.
            // Tory Blue
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (29.0000/255.0), green: (106.0000/255.0), blue: (173.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (135.0000/255.0), blue: (220.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Democratic Unionist Party - D.U.P." {
            // Moderate Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (226.0000/255.0), green: (106.0000/255.0), blue: (106.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (212.0000/255.0), green: (106.0000/255.0), blue: (76.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Democratic Reform Party" {
            // DRP Pink
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (219.0000/255.0), green: (10.0000/255.0), blue: (91.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (204.0000/255.0), green: (34.0000/255.0), blue: (123.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "English Democrats" {
            // Mauve? Is there even a flat colour for this mess?
            // Requires a flat colour
            return UIColor(red: (145.0000/255.0), green: (95.0000/255.0), blue: (109.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Free United Kingdom Party" {
            // Free United Kingdom Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (150.0000/255.0), green: (40.0000/255.0), blue: (27.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (163.0000/255.0), green: (2.0000/255.0), blue: (2.0000/255.0), alpha: (1.0000))
            }
        
        } else if partyName == "Green Party" {
            // Green Party Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (30.0000/255.0), green: (164.0000/255.0), blue: (75.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (106.0000/255.0), green: (176.0000/255.0), blue: (35.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Guildford Greenbelt Group" {
            // Guildford Greenbelt Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (38.0000/255.0), green: (166.0000/255.0), blue: (91.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (76.0000/255.0), green: (157.0000/255.0), blue: (42.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Independent" {
            // Indep grey
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (149.0000/255.0), green: (165.0000/255.0), blue: (166.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (221.0000/255.0), green: (221.0000/255.0), blue: (221.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Labour Party" {
            // Labour Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (179.0000/255.0), green: (36.0000/255.0), blue: (28.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (178.0000/255.0), green: (34.0000/255.0), blue: (34.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Left Unity" {
            // Left Unity Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (242.0000/255.0), green: (38.0000/255.0), blue: (19.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (225.0000/255.0), green: (7.0000/255.0), blue: (7.0000/255.0), alpha: (1.0000))
            }
        
        } else if partyName == "Lewisham People Before Profit" {
            //LPBP Violet
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (145.0000/255.0), green: (61.0000/255.0), blue: (136.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (140.0000/255.0), green: (66.0000/255.0), blue: (137.0000/255.0), alpha: (1.0000))
            }
   
        } else if partyName == "Liberal Democrats" {
            // Lib dem yellow.
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (238.0000/255.0), green: (187.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (253.0000/255.0), green: (187.0000/255.0), blue: (48.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Liberty GB" {
            // Liberty GB Blue
            return UIColor(red: (8.0000/255.0), green: (0.0000/255.0), blue: (117.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Lincolnshire Independents Lincolnshire First" {
            // LILF Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (38.0000/255.0), green: (166.0000/255.0), blue: (91.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (128.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Mebyon Kernow - The Party for Cornwall" {
            // MKTPC Yellow
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (249.0000/255.0), green: (191.0000/255.0), blue: (59.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (255.0000/255.0), green: (204.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "National Health Action Party" {
            // Blue
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (65.0000/255.0), green: (131.0000/255.0), blue: (215.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (0.0000/255.0), blue: (255.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "National Liberal Party - True Liberalism" {
            // NLP Orange
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (249.0000/255.0), green: (105.0000/255.0), blue: (14.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (255.0000/255.0), green: (102.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Official Monster Raving Loony Party" {
            // Monster Raving Looney Pink
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (246.0000/255.0), green: (36.0000/255.0), blue: (89.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red:	(255.0000/255.0), green: (105.0000/255.0), blue: (180.0000/255.0), alpha:(1.0000))
            }
            
        } else if partyName == "Patria" {
            // PATRIA Blue
            return UIColor(red:	(0.0000/255.0), green: (62.0000/255.0), blue: (109.0000/255.0), alpha:(1.0000))
            
        } else if partyName == "Patriotic Socialist Party" {
            // Kinda a red party colour
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (192.0000/255.0), green: (57.0000/255.0), blue: (43.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (238.0000/255.0), green: (28.0000/255.0), blue: (37.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Pirate Party UK" {
            // Pirate Magenta
            return UIColor(red: (153.0000/255.0), green: (0.0000/255.0), blue: (153.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Plaid Cymru - The Party of Wales" {
            // A darkish green.
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (50.0000/255.0), green: (116.0000/255.0), blue: (30.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (129.0000/255.0), blue: (66.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Scottish National Party (SNP)" {
            // SNP Yellow
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (244.0000/255.0), green: (208.0000/255.0), blue: (63.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (255.0000/255.0), green: (255.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Scottish Green Party" {
            // Scottish Green Party
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (30.0000/255.0), green: (164.0000/255.0), blue: (75.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (153.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "SDLP (Social Democratic & Labour Party)" {
            // SDLP Neon Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (135.0000/255.0), green: (211.0000/255.0), blue: (124.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (153.0000/255.0), green: (255.0000/255.0), blue: (102.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Sinn Féin" {
            // Sinn Féin Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (38.0000/255.0), green: (166.0000/255.0), blue: (91.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (136.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Socialist Labour Party" {
            // Socialist Labour Party Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (192.0000/255.0), green: (57.0000/255.0), blue: (43.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (238.0000/255.0), green: (28.0000/255.0), blue: (37.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Socialist Equality Party" {
            // Socialist Equality Party Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (150.0000/255.0), green: (40.0000/255.0), blue: (27.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (150.0000/255.0), green: (0.0000/255.0), blue: (24.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The 30-50 Coalition" {
            // 30-50 Green
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (46.0000/255.0), green: (204.0000/255.0), blue: (113.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (46.0000/255.0), green: (195.0000/255.0), blue: (47.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Above and Beyond Party" {
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (51.0000/255.0), green: (51.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (0.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Democratic Party" {
            // The Democratic Party Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (51.0000/255.0), green: (51.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (242.0000/255.0), green: (38.0000/255.0), blue: (19.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Justice and Anti-Corruption Party" {
            // JACP Red
            return UIColor(red: (153.0000/255.0), green: (0.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "The Liberal Party" {
            // Liberal orange.
            return UIColor(red: (255.0000/255.0), green: (115.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "The North East Party" {
            // NEP Red/Brown
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (150.0000/255.0), green: (40.0000/255.0), blue: (27.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (128.0000/255.0), green: (0.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Peace Party - Non-violence, Justice, Environment" {
            // Peace Party Salmon
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (210.0000/255.0), green: (82.0000/255.0), blue: (127.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (218.0000/255.0), green: (112.0000/255.0), blue: (214.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Republican Socialist Party" {
            // Add comment here
            return UIColor(red: (89.0000/255.0), green: (171.0000/255.0), blue: (227.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "The Respect Party" {
            // Respect Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (217.0000/255.0), green: (30.0000/255.0), blue: (24.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (255.0000/255.0), green: (51.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Socialist Party of Great Britain" {
            // Socialist Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (242.0000/255.0), green: (38.0000/255.0), blue: (19.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (220.0000/255.0), green: (36.0000/255.0), blue: (31.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Workers Party" {
            // Workers Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (217.0000/255.0), green: (30.0000/255.0), blue: (24.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (215.0000/255.0), green: (61.0000/255.0), blue: (61.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "The Whig Party" {
            // WHIG Blue
            return UIColor(red: (75.0000/255.0), green: (166.0000/255.0), blue: (181.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Trade Unionist and Socialist Coalition" {
            // TUSC Red
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (192.0000/255.0), green: (57.0000/255.0), blue: (43.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (255.0000/255.0), green: (0.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Traditional Unionist Voice - TUV" {
            // TUV Blue
            return UIColor(red: (0.0000/255.0), green: (149.0000/255.0), blue: (182.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "UK Independence Party (UKIP)" || partyName == "UK Independence Party (UK I P)" {
            // UKIP Purple
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (123.0000/255.0), green: (38.0000/255.0), blue: (159.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (112.0000/255.0), green: (20.0000/255.0), blue: (122.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Ulster Unionist Party" {
            // UUP Blue
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (89.0000/255.0), green: (171.0000/255.0), blue: (227.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (153.0000/255.0), green: (153.0000/255.0), blue: (255.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "Yorkshire First" {
            // Yorkshire First Blue
            return UIColor(red: (5.0000/255.0), green: (169.0000/255.0), blue: (197.0000/255.0), alpha: (1.0000))
            
        } else if partyName == "Young People's Party YPP" {
            // YPP Yellow
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (247.0000/255.0), green: (202.0000/255.0), blue: (24.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (255.0000/255.0), green: (255.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName == "We Are The Reality Party" {
            // Reality Party Black
            if theme == ColourScheme.FlatColours {
                return UIColor(red: (51.0000/255.0), green: (51.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (0.0000/255.0), blue: (51.0000/255.0), alpha: (1.0000))
            }
            
        } else if partyName.contains("Independent") {
            // This is second to last so all other parties are knocked out first
            return UIColor(red: (221.0000/255.0), green: (221.0000/255.0), blue: (221.0000/255.0), alpha: (1.0000))
        } else {
            // a nice neuteral turquoise-ish.
            return UIColor(red: (21.0000/255.0), green: (178.0000/255.0), blue: (138.0000/255.0), alpha: (1.0000))
        }
    }
}