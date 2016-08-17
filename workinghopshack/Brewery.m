//
//  Brewery.m
//  hopshack
//
//  Created by Blake Butterworth on 1/29/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "Brewery.h"
#import "APIClient.h"

@implementation Brewery
//@synthesize description;

-(id)init{
    self=[super init];
    return self;
    
}
-(void)initEverythingWithSuccess:(void (^)(NSArray*))success
                         failure:(void (^)(NSError *error))failure {

        NSURL *url = [[NSURL alloc] initWithString:@"https://hopshack.com/db_iphone_get_all_beer.php"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:[url absoluteString]
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                     self.everything=responseObject;
                 if (success) success(responseObject);
             
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 // Handle failure
                 if(failure) failure(error);
             }];
        //  self.favoriteBeers= @[];
}
-(id)initWithName:(NSString *)aName
          company:(NSString *)aComp
       typeNumber:(NSString *)aTypeNumber
   identification:(NSString *)anID {
    self=[super init];
    if(self){
        self.name=aName;
        self.company=aComp;
        self.typeNumber=aTypeNumber;
        self.identificaiton=anID;
       self.typeName=[self createTypes:aTypeNumber];
       self.typePhot=[self createPhot:aTypeNumber];
    }
    return self;
}
-(id)initWithAbv:(NSString *)anAbv
            city:(NSString *)aCity
   companyDetail:(NSString *)aCompanyDetail
         country:(NSString *)aCountry
identificationDetail:(NSString *)anIdentificationDetal
      nameDetail:(NSString *)aNameDetail
     desc:(NSString *)aDesc
           state:(NSString *)aState
      typeNumber:(NSString *)atypeNumber
    ratingDetail:(NSString *)aRatingDetail
{
    self=[super init];
    if(self){
        self.nameDetail=aNameDetail;
        self.desc=aDesc;
        self.companyDetail=aCompanyDetail;
        self.city=aCity;
        self.state=aState;
        self.country=aCountry;
        self.typeNumber=atypeNumber;
        self.identificationDetail=anIdentificationDetal;
        self.abv=anAbv;
        self.typeName=[self createTypes:atypeNumber];
        self.typeDesc=[self createDesc:atypeNumber];
        self.typePhot=[self createPhot:atypeNumber];
        self.ratingDetail=aRatingDetail;
        
   //     self.favoriteBeers=nil;
        
    //    [Brewery saveBrewery:self];
    }
    return self;
}

+(Brewery *)getBrewery {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[Brewery getPathToArchive]];
}
+(void)saveBrewery:(Brewery *)aBrewery {
    [NSKeyedArchiver archiveRootObject:aBrewery toFile:[Brewery getPathToArchive]];
}
+(NSString *)getPathToArchive {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *filepath=[docsDir stringByAppendingPathComponent:@"AppCache/Employee.archive"];
    return filepath;
}
+ (NSString *)filePathDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *archiveDirectory = [cachesDirectory stringByAppendingPathComponent:@"AppCache"];
    return archiveDirectory;
}

+ (BOOL)createEmployeeDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *e;
    BOOL success = [fileManager createDirectoryAtPath:[Brewery filePathDirectory]
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&e];
    return success;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self=[super init];
    if(self){
        _nameDetail= [aDecoder decodeObjectForKey:@"name"];
        self.desc= [aDecoder decodeObjectForKey:@"description"];
        self.companyDetail= [aDecoder decodeObjectForKey:@"company"];
        self.city= [aDecoder decodeObjectForKey:@"city"];
        self.state= [aDecoder decodeObjectForKey:@"state"];
        self.country= [aDecoder decodeObjectForKey:@"country"];
        self.typeNumber= [aDecoder decodeObjectForKey:@"type"];
        self.identificationDetail=[aDecoder decodeObjectForKey:@"id"];
        self.typeName=[aDecoder decodeObjectForKey:@"typename"];
        self.typeDesc=[aDecoder decodeObjectForKey:@"typedesc"];
        self.typePhot=[aDecoder decodeObjectForKey:@"typephot"];
        self.favoriteBeers=[aDecoder decodeObjectForKey:@"favebeers"];
        self.ratedBeers=[aDecoder decodeObjectForKey:@"ratedBeers"];
        self.ratingDetail= [aDecoder decodeObjectForKey:@"rating"];

        self.abv= [aDecoder decodeObjectForKey:@"abv"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)anEncoder{
    [anEncoder encodeObject:self.nameDetail forKey:@"name"];
    [anEncoder encodeObject:self.desc forKey:@"description"];
    [anEncoder encodeObject:self.companyDetail forKey:@"company"];
    [anEncoder encodeObject:self.city forKey:@"city"];
    [anEncoder encodeObject:self.state forKey:@"state"];
    [anEncoder encodeObject:self.country forKey:@"country"];
    [anEncoder encodeObject:self.typeNumber forKey:@"type"];
    [anEncoder encodeObject:self.identificationDetail forKey:@"id"];
    [anEncoder encodeObject:self.typeName forKey:@"typename"];
    [anEncoder encodeObject:self.typeDesc forKey:@"typedesc"];
    [anEncoder encodeObject:self.typePhot forKey:@"typephot"];
    [anEncoder encodeObject:self.favoriteBeers forKey:@"favebeers"];
    [anEncoder encodeObject:self.ratedBeers forKey:@"ratedBeers"];
    [anEncoder encodeObject:self.ratingDetail forKey:@"rating"];

    [anEncoder encodeObject:self.abv forKey:@"abv"];
}
 
-(NSString *)createTypes:(NSString *) typeNumber
{
    switch (typeNumber.integerValue) {
        case 0:
            return @"Altbier";
        case 1:
            return @"Amber Ale/ Red Ale";
        case 2:
            return @"American Lager";
        case 3:
            return @"American Wheat Ales";
        case 4:
            return @"American-Style Brett Ale";
        case 5:
            return @"American-Style Sour Ale";
        case 6:
            return @"Barley Wine: American-Style";
        case 7:
            return @"Barley Wine: English-Style";
        case 8:
            return @"Belgian Dark Ale";
        case 9:
            return @"Berliner Weisse";
        case 10:
            return @"Biere de Champagne";
        case 39:
            return @"Blond / Kolsch / Golder";
        case 45:
            return @"Pale Ale: Belgian / Belgian Blonde";
        case 55:
            return @"Black/Schwarzbier";
        case 12:
            return @"Bock";
        case 13:
            return @"Brown Ale";
        case 14:
            return @"California Common";
        case 15:
            return @"Cream Ale";
        case 16:
            return @"Dopplebock";
        case 17:
            return @"Dortnumder Export";
        case 18:
            return @"Dunkelweizen";
        case 19:
            return @"Eisbock";
        case 20:
            return @"Extra Special Bitter";
        case 21:
            return @"Flanders Oud Bruin";
        case 22:
            return @"Flanders Red Ale";
        case 23:
            return @"Fresh Hop Ale";
        case 71:
            return @"Fruit/Vegetable Beer";
        case 24:
            return @"Fruit Lambic";
        case 25:
            return @"Gose";
        case 73:
            return @"Gratzer / Smoked Polish Beer";
        case 26:
            return @"Gueuze";
        case 74:
            return @"Herbed Ale/ Gruit";
        case 27:
            return @"Hefeweizen";
        case 28:
            return @"IPA:Belgia";
        case 29:
            return @"IPA:Black";
        case 30:
            return @"IPA:Double/Imperial";
        case 31:
            return @"IPA:East Coast";
        case 32:
            return @"IPA English";
        case 33:
            return @"IPA:Pacific Northwest";
        case 34:
            return @"IPA:Red";
        case 35:
            return @"IPA:Rye";
        case 36:
            return @"IPA:Triple";
        case 37:
            return @"IPA:West Coast";
        case 38:
            return @"IPA:White";
        case 77:
            return @"Kellerbier/Zqickelbier";
        case 40:
            return @"Maibock";
        case 41:
            return @"Marzen/Oktoberfest";
        case 42:
            return @"Munich Dunkel";
        case 43:
            return @"Munich Helles";
        case 44:
            return @"Pale Ale: American";
        case 46:
            return @"Pale Ale: English";
        case 47:
            return @"Pilsner:Czech";
        case 48:
            return @"Pilsner: German";
        case 49:
            return @"Porter: American";
        case 50:
            return @"Porter: Baltic";
        case 51:
            return @"Porter British";
        case 52:
            return @"Pumpkin Beer";
        case 53:
            return @"Smoked Beer/ Rauchbier";
        case 76:
            return @"Rye/Roggenbier";
        case 54:
            return @"Saison";
        case 56:
            return @"Scottish Ale/Wee Heavy";
        case 75:
            return @"Spiced / Herbed Beer";
        case 57:
            return @"Standard and Best Bitter";
        case 58:
            return @"Stout: American";
        case 59:
            return @"Stout: Dry Irish";
        case 60:
            return @"Stout:Foreign Extra";
        case 61:
            return @"Stout Imperial";
        case 62:
            return @"Stout Milk";
        case 63:
            return @"Stout Oatmeal";
        case 72:
            return @"Strong Ale / Old Ales";
        case 64:
            return @"Trappist: Dubbel";
        case 65:
            return @"Trappist:Quadrupel";
        case 66:
            return @"Trappist:Tripel";
        case 67:
            return @"Vienna Lager";
        case 68:
            return @"Weizenbock";
        case 69:
            return @"Wheat Wine";
        case 70:
            return @"Witbier";
        default:
            return @"amber";
            break;
    }
    
}
-(NSString *)createDesc:(NSString *) typeNumber
{  switch (typeNumber.integerValue) {
    case 0:
        return @"This ale features toasted malt, fruity flavors, and a crisp finish that is attributed to its unique cool-temperature fermenting strand of yiest. The big caramel flavors (and colors) in the Altbier pair wonderfully with fattier foods: aged Gouda, roasted meats, shelfish, and a wide variety of desserts. ";
    case 1:
        return @"Named for the amber hue that stems from darker malts, this is an enourmous category that covers everything from slightly sweet and nutty to bitter and hop-forward.  You typically do not want to pair with anything that would detract from the caramel malts. Think savory instead of sweet.";
    case 2:
        return @"The vast majority of mainstream beers in the late 20th century were lagers. One can deduce why, therefore, craft breweries departed ferociously from the mainstream. Now, however, craft brewing companies are embracing the past with pre-prohibition lagers or experimenting with their newer techniques on the cold fermenting yeast. Pair with barbecue, Indian, Latin American, Thai, peppery cheeses, or shellfish. ";
    case 3:
        return @"Many craft brewing companies are making wheat beers without the idiosyncratic Hefeweizen flavor profile. Often maintaining the traditional cloudy appearance with a creamy head, but instead of banana and cloves look for floral characteristics. This is American creativity right here. Eat a hamburger.";
    case 4:
        return @"Brewed with the wild Brettanomyces yeast, these ales (or sometimes lagers) can vary. Their distinguishing characteristic is a sour citrus punch of yeast that may not be for everyone. You'll either love it or you won't, drink with peppery cheese. ";
    case 5:
        return @"Acidic character generally introduced from micro-orginisms in either the mash or wild yeast. The style varies, but the acid is typically balanced by fruit flavors and a malty sweetness. Try with peppery cheese. ";
    case 6:
        return @"The American Barley Wine is associated with heavy-handed floral hops, fruity perfume, and a very high ABV. Some Barley Wines like a few years to mature, tempering their often aggressive flavor, and they are usually hopped to death, so watch out. Expect a fully body, apparent alcohol flavor, and a roaring good time. Pair with sharp cheeses or dessert. ";
    case 7:
        return @"The first beer coined a barley wine was Bass No. 1. This beer was eventually discontinued, however, because British beers are taxed by alcohol content and boy was that beer expensive. Nevertheless, the style remains, and British Barley wines now boast lower ABV and are typically more round and balanced than their legendary predecessor. Sip with sharp cheeses.";
    case 8:
        return @"A Belgian-style pale ale that hides a high ABV behind sweet fruit flavors and solid hoppiness. Throw this one in a tulip glass to enjoy its rare golden color and exquisite flavor alongside a Triple Creme cheese.";
    case 9:
        return @"Nicknamed the Champagne of the North, the Berliner Weisse is like a sparkling unsweetened lemonade. This rare sour (but not tart) ale is crafted from warm fermenting yeast and Lactobacillus bacteria.  Place this beer at the start of your meal, and please try with truffled french fries!";
    case 10:
        return @"A new, hybrid beer style with a rather complicated fermentation process that has much in common with Champagne. This beer is bone dry and very evervescent. Not Miller High-Life, sip before meals as an aperitif.";
    case 39:
        return @"A delicate, crisp ale with a fruity, medium to assertive bitter hop profile. American craft companies use the style often for their seasonal summertime offerings, and here at Hop Shack we include the Blonde Ales in this category as well. These beers have a distinct citrus characteristic that pairs well with Caribbean-style meat and fish dishes, but their wheat notes will also stand up to surprisingly hearty meals like ribs.";
    case 45:
        return @"An interesting style that was born to combat the Czech and German pilsners. These brews have toned down malts and hops but still maintain the traditional Belgian spice and fuitiness. The two merging characteristics make this style at once a good companion for both zesty salads and pub fare. ";
    case 55:
        return @"The Schwartzbier (German for black) is a delicious, refreshing lager that maintains the roasty flavors and color of a porter or stout without the accompanying bitterness. Brewers can either dehusk the malts to tone down the burnt characters or use cold-brew techniques. Goes well with German cuisine.";
    case 12:
        return @"A strong and robust bottom fermenting brew that is thought to be a shortened version of the name Einbeck (pronounced Ein-bock). In the 17th century a brewmaster from Einbeck was placed as the head of Hofbrauhuas in Munich. There he recreated his city's famous rich, malty lager in a style symbolizing the season's turn from winter to spring. This brew complements earthy cheeses and gamey meat dishes.";
    case 13:
        return @"Varying from innovative uses of nuts, spices, fruits, and coffee to sweeten malts, Brown Ales encompass an enormous selection of beers. Look for the malty flavors that give this ale its color, but don't be surprised by the variance in hoppiness and alcohol content. There's a lot here to explore alongside some earthy cheese and meat.";
    case 14:
        return @"California Common style arose out of American ingenuity when faced with adverse conditions for cold-fermenting lager yeast. They pumped the boiling wort up to the rooftops to be rapidly cooled by the pacific air. Expect copper color, biscuits and caramel palate, and a dry hoppy finish. Sip alongside barbecue, salads, pork, poultry, fish, or shellfish. ";
    case 15:
        return @"A crossover lager/ale that is brewed at cooler temperatures but still has mainy of the fruity flavors and aromas of an ale. It is similar to a Kolsch, but has less hop bitterness. Enjoy a refreshing Cream Ale sitting on the porch in the summer with lighter foods like a stone fruit salad, Monterey Jack cheese, and BBQ chicken.";
    case 16:
        return @"An extremely hefty lager that was originally brewed by German monks for sustenance during lent. Sometimes boasting an ABV as high as 13%, malty flavors of chocolate, coffee and dark fruit characterize this style. Double down with this double bock. Enjoy with buttery cheeses, chocolate and gamey meat. ";
    case 17:
        return @"Another response to the Czech Pils from the German industrial region of Westphalia, Dortmunder is the mine worker's pennant beer. Similarly golden, light-bodied, and refreshing, this beer is a little less dry than Pils with sweet grain flavors. Sip with buttery cheeses, pork, poultry, or fish. ";
    case 18:
        return @"The original wheat beers of Bavaria were darker than the widely spread hefeweizens of today. The Dunkelweizen retains similar tasting notes that you would expect from a cloudy wheat beer but with warmer fruits and clove notes. This caramel and banana beer pairs well with heavier German dishes and fattier cheeses.";
    case 19:
        return @"Brewers freeze their bocks and remove the ice crystals in a process called freeze distillation. What is left behind is a stronger, thicker, and more malty lager. This is a potent, toffee and botterscotch brew best sipped from a snifter. Try it with German cuisine or alongside dessert. ";
    case 20:
        return @"ESB is becoming a popular style with craft brewing companies. An English stye with more grassy and herbal earthiness than the standard pale ale. Unique and intriguing characteristics that stand up nicely to a good steak.";
    case 21:
        return @"By using darker malts than their western neighbors, brewers make Flanders Oud Bruin a sour ale with date-like sweetness and distinct woody notes. Try with cheese or meat.";
    case 22:
        return @"A combination of a house blend of bacteria and yeast, light and dark barley malts, and aging for up to two years in oak tanks produces an ale nicknamed the Burgundy of Belgium. A ruby-hued, tart ale with tannins that lend it a wine-like complexity; sip your Flanders with cheese and meat.";
    case 23:
        return @"Just after harvesting, most hops are sent to be dried and perserved before they begin to decay. However, within the first 24 hours some are sent directly to the brewers to make a fresh-hop ale. Instead of an intense bitterness, look for piney and grassy characteristics. A fresh hop ale is a treat for drinkers and chefs alike who will want to pair this style with fresh game and vegetables.";
    case 71:
        return @"A varied style in which brewers use fruit, extract or some sort of flavoring in the fermentation process. These are usually ales with a low bitterness to let the fruit shine through. Try with dessert. ";
    case 24:
        return @"Lambics are one of the few styles that roll the dice on infection during fermentation. Cooled with the windows open, fermented with fruit and aged in wooden barrels, your likely to discover, a tart, funky, fruity brew. Sip with dessert. ";
    case 25:
        return @"Similar to the Berliner Weisse but with an addition of coriander and salt. A rare style that is often accompanied by bananas and other refreshing fruit characteristics, a lacy, lasting head, complex array of zesty flavors, and a crisp finish. This style pairs especially well with flavorful seafoods such as fatty sashimi or oysters on the half shell.";
    case 73:
        return @"An uncommon Polish style in which brewers use smoked wheat and top fermenting yeast. We're talking about peat smoke here, folks. Powerful stuff. Try bravely with barbecue or peppery cheese. ";
    case 26:
        return @"An extra aged mixture of young an old lambics, the resulting brew is an even more intensely sour and fruity ale. Try with dessert. ";
    case 74:
        return @"An ancient Scottish ale that is seeing a slight comeback in craft beer. Instead of using hops to bitter and flavor the ale, brewers use a mixture of herbs. Look for an unusual mixture of botanical characteristics. Try it with salad or game dishes. ";
    case 27:
        return @"A true beauty of a beer served in a curvaceous glass. Cloudy, with an intriguing aroma of citrus, clove, and bubblegum, a lasting, creamy head and a flavor to match its nose. Named for wheat and yeast, these peculiar qualities make Hefeweissens particularly well adapted to pair with food. The German pretzel is a classic, as well as cured pork, rich seafood (especially lobster), and apple tarts.";
    case 28:
        return @"A style born from both American ingenuity and Belgian tradition.  The Belgian IPA is an amazing combination of abundant hops and unique yeast strains. Look for a balance of fruity esthers, citrus, and bitterness in this style. Pair accordingly with sharp cheeses, fried foods, or spicy ethnic dishes.";
    case 29:
        return @"Also known as American dark ale. This style is related to the IPA in bitterness, but is balanced with darker malts such as chocolate and coffee. This complexity makes the Black IPA an extremely intriguing pair with savory, spicy meals. ";
    case 30:
        return @"An IPA on steroids! Extra helpings of aroma, alcohol, and bitterness. Often one of the last choices for pairings because it takes huge flavor to stand up to Double IPA's. Enjoy!";
    case 31:
        return @"IPA's are currently the signature style for craft beer in America. Not officially divided by the Beer Judge Certification Program, an East Coast style IPA, nevertheless, tends to feature more of a balance in flavor with a fair amount of malt supporting the hop bitterness.  This style does an amazing job cutting through fried foods, standing up to spicy foods, and bringing out the magic in a sweet dessert.";
        
    case 32:
        return @"The British Army and East India Trading Company had a long history of shipping beer to troops stationed in India. The officers supposedly all prefered porters while the civilians stationed there tended towards pale ales that featured heavy amounts of hops for preservation.  This style became the India Pale Ale.  English-style IPA's are balanced creatures with biscuits and caramel meeting hoppy zest and spice. We recommend spicy foods (Indian, Thai or Mexican), and for a real treat try pairing with desserts like carrot or chocolate cake. ";
    case 33:
        return @"With hops grown in their backyards, these brewers showcase the piney and grassy aromatic qualities of their ambrosial flowers. Not as in-your-face bitter as Southern California beers can be. Craft a special meal with these, or simply enjoy by themselves. ";
    case 34:
        return @"This style of IPA has a dark red hue stemming from the use of caramel malts. These malts are wrapped up in a hoppy citrus blanket that is sure to please your tastebuds.  Warm aromas of sweet bread, pine, and citrus are the perfect match for Thai food.";
    case 35:
        return @"When used in whiskey, rye is known to make a spirit spicier and leaner. Look for similar additions here in the Rye IPA style. These beers feature a coppery hue and sharp, distinct flavors. Enjoy!";
    case 36:
        return @"Grab a friend because we recommend sharing one of these bad boys. Intriguing, but devastating, with an insane amount of hop bitterness and ABV!";
    case 37:
        return @"IPA's are currently the signature style for craft beer in America. Not officially divided by the Beer Judge Certification Program, a West Coast style IPA, especially in San Diego, tends to have dry profiles that showcase in-your-face hops. These are zesty and bitter brews that can cut through fried foods and stand up to spicy dishes.";
    case 38:
        return @"A beautiful, happy marriage between a hop-filled IPA and a cloudy white ale. With ample amounts of both citrus and baking spices, this is a perfect option for late spring and summer!";
    case 77:
        return @"An unfiltered lager with flavorful up-front hops. Most Kellerbiers are served locally, straight from the casks in which they were made and aged. You must be somewhere cool if you're drinking it. Please take a picture.";
    case 40:
        return @"Legend tells us the Maibock of Hofbrauhaus was so cherished that it saved Munich from annihilation during the Thirty Years War. Golden with a nose of honey, yet enough bitterness and body to keep you warm on an early spring night, Maibock pairs well with Italian food and nutty cheeses. ";
    case 41:
        return @"Marzens were traditionally brewed in the cold month of March and stored in cellars throughout the summer. Fall was greeted with this slightly sweet, full-bodied bridge between summer and winter. Typically well-aged and well-hopped, Marzens are a fine counterpoint to Oktoberfestbier. Enjoy with German cuisine. ";
    case 42:
        return @"Southeastern Germany was one of the first areas to use cold fermentation. Long, cold storage worked magic on the beer's maturation. Over time the area became known for its dark lager, the Munich Dunkel, typically brewed with noble German hops like Tetnang and Hallertau. The style has a bready nose with rich flavors of caramel, coffee, and nuts, so consider pairing with smoky, gamey, German meat dishes. ";
    case 43:
        return @"It took a while for Munich to break tradition with their dark lagers. In 1894 Spaten created the Munich Helles, a golden lager with sweet malt and a little spice from hops. Boasting a light color, this beer is a German triumph. Enjoy with buttery cheese, salad, pork, fish, or shellfish.";
    case 44:
        return @"After Sierra Nevada's first batch of Cascade hopped pale ale, American breweries began to deviate from the English style with more crisp, hoppy bitterness. This style often blurs the line between pale ale and IPA, and is, therefore, adapted to contrasting pairings.  The hops complement sweet, spicy foods such as salsa and curry.";
    case 46:
        return @"Burton upon Trent, England, held the title of brewing capital of the world in the mid 19th century in large part due to its gypsum carrying water. Now, the secret is out, and the process of adding gypsum to produce the English Pale Ale is widespread. It creates a malty, earthy, fruity, and slightly hoppy profiled brew that cannot be beat when paired with fish and chips, shepheards pie, or similar pub fare.";
    case 47:
        return @"The Czech Pilsner was a truly historic beer for Europeans accostumed to dark, burly brews. Pilsner Urquell was the first creation bottom fermenting yeast in Bohemia. Sparkling gold, light-bodied and refreshing.";
    case 48:
        return @"The German response to the blazing popularity of the Czech Pilsner in the mid 19th century. Pils are Golden, grassy, and delicately bittered. Pair this adored style with Japanese cuisine, peppery cheeses, poultry, or fish.";
    case 49:
        return @"American craft brewing companies often take an imaginative approach to the porter. They may add smoke, fruit, coconut, hops, or all of the above.It's a safe bet you're in for innovation when saddling up with one of these.";
    case 50:
        return @"As the name suggests, these rich ales were originally crafted in 18th century Britain for drinking in the cold Baltic provinces. Brewers experimented with cold fermenting lager yeast and eventually produced the sweet Baltic Porter at a timewhen shipping beer was just catching on. A porter with a more restrained roasted character, try it with earthy cheese and smoked meat. ";
    case 51:
        return @"Porter British";
    case 52:
        return @"This pumpkin beer actually dates back to the days of the 13 original American colonies when barley malts imported from England were absurdly expensive. Desperate brewers turned to anything fermentable, including pumpkins, and now craft breweries around the world use the technique to create cinnamon and nutmeg spiced brews for the autumn season.";
    case 53:
        return @"Drying barley over open fires imbues intense smokey characters. Any style can be labeled as a Rauchbier (German for smoke), but it is traditionally dark lagers that take this title. Consider pairing with barbecue, peppery cheeses, or smoked meat, game, and salmon.";
    case 76:
        return @"Medieval German style Rye ale. Wow, can't believe you're trying one of these. You'll have to tell us how it is! Jk. Roggens are mildly hopped and full of earthy character. A throwback to the times when brewers were limited to the grains that grew around them. In Northern Germany, that was rye. Tart and refreshing, try this one instead of a hefeweizen and with a good slice of roast pork. ";
    case 54:
        return @"The Belgian Saison was orginially handed out to field laborers to quench their thirst during harvest because water was often contaminated. The style varies, but look for farm-inspired earthy tones in this thirst quenching brew. Great with Indian and Thai cuisines as well as salad and cheese. ";
    case 56:
        return @"Scottish Ale/Wee Heavy";
    case 75:
        return @"Another catch-all category that contains any beer that is specially spiced, ranging from chilies to cinnamon. Consult the brewing company for the particular flavors and aromas in their beer and enjoy the adventure in flavor on which your surely about to embark.";
    case 57:
        return @"English pale ales divided into three loose categories. Standard is anything up to 4.1 ABV and makes an easy drinking ale. Best bitter is brewed roughly up to 4.7 %. Anything higher in ABV lands you in Strong or Extra Special Bitter (ESB) territory. These mild yet bitter beers (Standard through Best) desire subdued flavors in their counterparts such as light cheeses and sandwiches.";
    case 58:
        return @"Using the Irish Stout as a launching pad, American brewing companies are quite creative with their stouts, sometimes loading them extra hops, chocolate, or aging them in whiskey barrels. While your sure to find a trace of that distinctive blackened malt character, just about everything else is up for grabs! Be adventurous. This might be good with anything. ";
    case 59:
        return @"By using roasted, blackened barley, Irish stouts attain a black hue with little sweetness. Typically low on carbonation and alcohol content, Dry Irish Stouts tend to offer a very smooth drink. Creamy, with notes of coffee and a surprisingly light body, try one with chocolate or smoked meat.h";
    case 60:
        return @"This style of stout was created for export to warmer climates. To survive the overseas journey, brewers had to add extra hops to preserve freshness, much like the IPA. Thick and black with a tan head and boasting a high alchohol content, this is kind of like an Irish Stout on steroids. Try with dessert or smoked meat. ";
    case 61:
        return @"Originally brewed to win over the Russian royalty, this stout is intense. Boasting high levels of alcohol, today the Russian Imperial Stout has transformed into an American creation with heaps of hop bitterness and ABV to accompany the chocolately, roasty stout. Try with dessert.";
    case 62:
        return @"Brewers produce Milk Stouts by adding lactose, an unfermentable sugar, to their stout mix. This practice gives the style its name as well as a creamy, sweet and more balanced character. A life changing beer style, sip on its own or with dessert. ";
    case 63:
        return @"A stout with an addition of oats, obviously. This gives the beer a creamy character that lacks the sweetness associated with a milk stout. Plenty of roasted coffee and cream in this one with an outstandingly smooth sip. Try with earthy cheese and smoked meat.";
    case 72:
        return @"An unofficial, catch-all style with high ABV. Their characteristics do not lie in any particular category. Keep an eye out as these are exciting to try and may throw you for a loop. ";
    case 64:
        return @"This style traces its heritage back to Westmalle, a revered abbey brewery that decided to depart from the witbier in 1856. They concocted a strong brown ale with a fruity character. Over the years they made it stronger and this became the dubbel.  Look for medium to full malty sweetness but never any roast, and pair this style with a dish using basil, creamy cheeses, glazed ham, or sweet desserts.";
    case 65:
        return @"Ah the Belgian Dark Ale! Quads = Abbey ales stronger than dubbels (ABV's north of 10%) and darker than tripels.  Aromas and flavors of sweet brown bread and baking spices.  According to the high ABV and complex malt bill, pair this style with rich, strong cheeses and buckle up. ";
    case 66:
        return @"In 1919, the minister of justice for Belgium got the Vandervelde Act passed, which excluded hard alcohol sales. To quench the thirst for harder liquor, the monks at Wetmalle decided to tripple the malt in their blonde ale. Eventually, they perfected a spicy, herbal, and fruity golden beauty, the tripel. This is a versatile style when it comes to pairing.  Try a charcuterie board or just go ahead and experiment!";
    case 67:
        return @"The Vienna Lager was invented in an early attempt to improve the cold fermentation process. After some trial, brewers produced this softer malty lager with a firm bitterness obtained from pale malts. The Vienna Lager lost prominence after the Austro-Hungarian Empire broke up, but sprang up again in Mexico of all places in the late 19th century—think Dos Equis and Negra Modelo. Pair with Latin-American food.";
    case 68:
        return @"German for bock of strength. This style has a pronounced estery alcohol character, bold and complex malt characters of dark fruits, and perhaps some spice from the high ABV. German law requires that any weizenbier be made from 50% wheat malt, and Weizenbocks are typically brewed at a higher (60%-70%) rate. They are also brewed with a special yeast which lends the beer a spicy, almost clovelike flavor. If nothing German is on the menu, pair with chocolate desserts and grilled meat. ";
    case 69:
        return @"A winter warmer like barley wine, but with a generous addition of wheat. This rounds out the brew and adds a layer of tart complexity on top of the caramel sweetness. Enjoy this fluffy strong ale with pungent cheeses or grilled meat. ";
    case 70:
        return @"The Belgian-style witbier, or white ale, is a cloudy blonde wheat beer with intricate blends of coriander, nutmeg and citrus zest. A truly delicious style that compliments a wide variety of dishes including salmon, seared tuna, mussels, and pastas.";
    default:
        return @"France's indigenous style meaning beer for keeping. A rich body with blonde to light brown hues and caramel-bread flavors. Try with Indian cuisine or nutty cheeses. ";
        break;
}
    
    
}
-(NSString *)createPhot:(NSString *) typeNumber{
    switch (typeNumber.integerValue){
        case 0:
            return @"altbier";
            break;
        case 1: case 22:
            return @"amber";
        case 61:case 58:case 59:case 60:case 62:
            return @"americanstout";
        case 6:case 7:
            return @"barleywine";
        case 11:
            return @"bieredegarde";
        case 45:
            return @"belgiangolden";
        case 55:
            return @"black";
        case 39:
            return @"blond";
        case 12: case 40: case 69:
            return @"bock";
        case 13:
            return @"brown";
        case 14:
            return @"californiacommon";
        case 30:
            return @"doubleipa";
        case 16:
            return @"dubbel";
        case 19:
            return @"eisbock";
        case 46:
            return @"englishpaleale";
        case 20: case 57:
            return @"esb";
        case 71:
            return @"fruit";
        case 25:
            return @"gose";
        case 63:
            return @"oatmeal";
        case 24:
            return @"lambic";
        case 41:
            return @"marzen";
        case 72:
            return @"oldale";
        case 33:
            return @"pacificnorthwest";
        case 44:
            return @"paleale";
        case 47: case 48:
            return @"pils";
        case 49: case 50: case 51:
            return @"porter";
        case 52:
            return @"pumpkin";
        case 65:
            return @"quad";
        case 32:
            return @"redipa";
        case 54:
            return @"saison";
        case 56:
            return @"scotchale";
        case 66:
            return @"tripel";
        case 36:
            return @"tripelipa";
        case 67:
            return @"viennalager";
        case 68:
            return @"weizenback";
        case 37:
            return @"westcoastipa";
        case 70:
            return @"witbier";
        default:
            return @"amber";
            break;
    }}
@end

