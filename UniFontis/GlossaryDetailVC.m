//
//  GlossaryDetailVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "GlossaryDetailVC.h"
#import "DPLocalizationManager.h"
@interface GlossaryDetailVC ()

@end

@implementation GlossaryDetailVC
@synthesize dict;
@synthesize arrAllGlossary;
- (void)viewDidLoad {
    [super viewDidLoad];
    [Utility setNavigationBar:self.navigationController];
    self.title= DPLocalizedString(@"glossary_tab", nil);
    [bgView.layer setBorderWidth:2.0];
    [bgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    titleLabel.text=[self.dict valueForKey:@"Name"];
    //txtDetail.text=TRIM([self.dict valueForKey:@"Desc"]);
    
    
    
    NSString *initial = TRIM([self.dict valueForKey:@"Desc"]);
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:initial];
    for(int i=0;i < self.arrAllGlossary.count ; i ++)
    {
        NSMutableDictionary *dict1=[self.arrAllGlossary objectAtIndex:i];
        NSString *match=[dict1 valueForKey:@"Name"];
    NSString *text = [initial stringByReplacingOccurrencesOfString:match withString:match];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:match options:kNilOptions error:nil];
    NSRange range = NSMakeRange(0,text.length);
    
    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subStringRange];
    }];
    }
    txtDetail.attributedText=mutableAttributedString;
    [self.view setBackgroundColor:BG_COLOR];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)]];
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tapResponce:(id)sender {
}

- (void) tapResponse:(UITapGestureRecognizer *)recognizer{
    UITextView *textView =  (UITextView *)recognizer.view;
    CGPoint location = [recognizer locationInView:textView];
    CGPoint position = CGPointMake(location.x, location.y);
    //get location in text from textposition at point
    UITextPosition *tapPosition = [textView closestPositionToPoint:position];
    //fetch the word at this position (or nil, if not available)
    UITextRange *textRange = [textView.tokenizer rangeEnclosingPosition:tapPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    NSString *tappedSentence = [textView textInRange:textRange];//[self lineAtPosition:CGPointMake(location.x, location.y)];
    NSLog(@"selected :%@ -- %@",tappedSentence,tapPosition);
    if([tappedSentence isEqualToString:titleLabel.text])
    {
        return;
    }
    for(NSMutableDictionary *dict1 in self.arrAllGlossary)
    {
        if([[dict1 valueForKey:@"Name"] containsString:tappedSentence])
        {
            NSLog(@"%@  %@",[dict1 valueForKey:@"Name"],tappedSentence);
            GlossaryDetailVC *objDetail=[[GlossaryDetailVC alloc]initWithNibName:@"GlossaryDetailVC" bundle:nil];
            objDetail.dict=dict1;
            objDetail.arrAllGlossary=self.arrAllGlossary;
            [self.navigationController pushViewController:objDetail animated:YES];
            
            return;
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
