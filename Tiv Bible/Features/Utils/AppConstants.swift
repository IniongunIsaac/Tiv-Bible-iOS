//
//  AppConstants.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

struct AppConstants {
    
    static let VALIDATION_TYPE_NOT_APPLICABLE = "Validation type does not applicable in this context."
    static let IMPLEMENTATION_COMING_SOON = "Implementation coming soon!"
    static let DATE_FORMAT = "dd MMM yyyy"
    static let INVALID_INPUT_FIELD = "Invalid input field."
    static let DATA_NOT_FOUND = "No data found!"
    static let BACKGROUND_THREAD_LABEL = "com.iniongungroup.tivbible.background.thread"
    
    //MARK: - Storyboard IDs
    static let READ_STORYBOARD_NAME = "Read"
    static let SEARCH_STORYBOARD_NAME = "Search"
    static let MORE_STORYBOARD_NAME = "More"
    static let HOME_STORYBOARD_NAME = "HomeTabs"
    
    //MARK: - Storyboard View Controller IDs
    static let READ_VC_ID = "readViewController"
    static let SEARCH_VC_ID = "searchViewController"
    static let MORE_VC_ID = "moreViewController"
    
    //MARK: Cell IDs
    static let VERSE_CELL_ID = "verseTableViewCell"
    static let TAP_ACTION_COLLECTION_CELL_ID = "tapActionCollectionViewCell"
    static let HIGHLIGHT_COLOR_COLLECTION_CELL_ID = "highlightColorCollectionViewCell"
    static let FONT_STYLE_COLLECTION_CELL_ID = "fontStyleCollectionViewCell"
    static let THEME_COLLECTION_CELL_ID = "themeCollectionViewCell"
    
    //MARK: - System Icon Names
    static let SYSTEM_GRID_ICON_NAME = "rectangle.grid.2x2"
    
    // MARK: - Color Hex Codes
    static let colorHexCodes = ["#FF8A65", "#FFB74D", "#FFD54F", "#DCE775", "#2962FF", "#4DB6AC", "#00B8D4", "#00BFA5", "#00C853", "#64DD17", "#AEEA00", "#FFD600", "#FFAB00", "#FF6D00", "#DD2C00", "#E57373", "#F06292", "#BA68C8", "#7986CB", "#4FC3F7"]
    
    static let LORDS_PRAYER = (title: "Msen u Ter wase", subTitle: "Msen u Yesu tese mbahenev nav la (Mateu 6:9-13)", content: "Ter wase u A lu sha, i tsegha iti You, tartor wou va, i er ishima you shin tar kpaa vough er i eren i sha nahan. Na se kwaghyan wase nyian u a lu sha ciu ayange ayange la; man de se anzo ase di er se kpaa se deen mba ve gbe anzo hen vese nahan; man shi de ze a vese ape imeen ilu ga, kpa yima se sha ifer. Gadia tartor ka u wou kua agee man icivir kpaa, gbem sha won, Amen.")
    
    static let CREED = (title: "Akaa a Puekarahar", subTitle: "Akaa a Puekarahar a Mbakristu sha won cii ve ne a jighjigh la", content: "1.\t\tM na Aondo TER Jighjigh, un u a hembe agee cii A gbe sha man tar la;\n2.\t\tShi m na Yesu Kristu jighjigh, ka wan Na u i mar un tswen, ka Ter wase je la,\n3.\t\tU i jile un sha Icighan Jijingi, iniunkwase i i yer i er Maria la mar un;\n4.\t\tIcan er Un sha ikyev i Pontiu Pilatu , i mande Un sha tereakon, A kpe , i ii Un,  A sen A nyor shin Hade,\n5.\t\tSha iyange i sha utar la A nder shin mbakpenev;\n6.\t\tA kondo A yem sha, A za tema ken uwegh ku iyanegh ku Aondo, Ter u A hembe agee cii;\n7.\t\tShi Una mough sha la, Una va sha u va oron mba umav man mbakpenev ijir.\n8.\t\tMna Icighan Jijingi jighjigh,\n9.\t\tMna Icighan nongo u Kristu sha won cii jighjigh, ka mzough u ui cighan mbaiorov je ve.\n10.\t\tMna mde u asorabo jighjigh\n11.\t\tMna mder u iyol shin ku jighjigh\n12.\t\tMna uma u tsoron jighjigh.\nAmen.")
    
    static let COMMANDMENTS = (title: "Atindi a Pue", subTitle: "Atindi a Aondo a Pue (Ekesodu 20:1-17)", content: "Tso Aondo or akaa a ngan cii, A kaa er; Ka Mo TER M lu Aondo wou u M dugh awe ken tar u Igipiti ken ya u ikpan ye\n\n1.\t\tDe lu a mbaaondo mbagenev ga saa Mo.\n2.\t\tDe gbe eev ga, shin kwagh u a bee ma kwagh u a lu sha kwavaondo shin u a lu shin inya, shin u a lu shin mngerem ma shin mkur u inyaagh kpaa ga. De gur ve nya ga, shi de chivir ve kpaa ga; gadia Mo TER Aondo wou, m gu Aondo u gban iwuhe: mtshan mbayev sha ci u ifer kwagh i uter zan zan ikyoov itiar man inyiin kpa i mba ve kerem ihom; kpa mba m doo ve ishima man ve we atindi am iko yo, M eren a udubu vev imongo dedoo.\n3.\t\tDe teren iti i TER Aondo wou dang ga, gadia or u nan teren iti i TER dang dang yo, Una na nan isho mayange ga.\n4.\t\tUmbur iyange I memen sha er u tsegha I yo, ayanga ateratar er tom man akaa a ou cii, kpa iyange I ataankaraharla, ka iyange I memen I TER Aondo wou je la, sha iyange ngi la de ker ma tom ave ga, we, man shi wan wou u nomso, man shi wan wou u kwase man or u shiren tom, man kwase u eren we tom, shi uzendenya ou, man shi shiror u nan nyer u a nyor, gadia TER gba sha man Tar man zegemnger kua akaa a a lu ken ve cii ayange ateratar , sha iyange  i ataankarahar la A men, ka nahan man TER a ver iyange i memen doo doo a tsegh I kpaa ye.\n5.\t\tChivir teru man ngou er a seer we ayange ken tar u TER Aondo wou Alu nan we yo.\n6.\t\tDe woo or ga.\n7.\t\tDe eren idya ga.\n8.\t\tDe iin ga.\n9.\t\tDe we or u wan ndor a we aie iyol ga.\n10.\t\tDe tem ya u or wan ndor a we ga, shi de tem kwase u or wan ndor a we ga, shin or u shiren nan tom, shin kwase u eren nan tom, shin bua u nan, shin ijaki I nan kpaa, kwagh mom mom u a lu or u or wan ndor a we yo, de tem ga.\n\nMan ken Mateu 22:35-40 se nenge, Yesu kohol atindi a pue la cii er: TER, Aondo wou A doo u ishima a ishima you cii, man a uma wou cii, man a mfe woyu cii. Ngun ka tindi u tamen man ka u hii hii kpaa, man u sha uhar u a lu er un yo, or u nan we ndor a we yo, nana doo u ishima er we iyol you nahan. Ka sha atindi ahar ne je man atindiakaa kua mbaprofeti cii ve har sha mi ye.")
    static let others = [AppConstants.LORDS_PRAYER, AppConstants.CREED, AppConstants.COMMANDMENTS]
}
