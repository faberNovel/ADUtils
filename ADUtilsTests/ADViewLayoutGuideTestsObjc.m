//
//  ADViewLayoutGuideTestsObjc.m
//  ADUtilsTests
//
//  Created by Pierre Felgines on 09/10/2018.
//

#import <XCTest/XCTest.h>
@import ADUtils;
@import Quick;
@import Nimble;

@interface ADViewLayoutGuideTestsObjc : QuickSpec

@end

@implementation ADViewLayoutGuideTestsObjc

- (void)spec {

    describe(@"Should not translate autoresizing mask into constaints", ^{

        __block UIView * view;
        __block UIView * subview;

        beforeEach(^{
            view = [UIView new];
            subview = [UIView new];
            [view addSubview:subview];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beTrue());
        });

        // Pin to layout guide

        it(@"Pin to layout guide", ^{
            [subview ad_pinToLayoutGuide:view.layoutMarginsGuide];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Pin to layout guide edges", ^{
            [subview ad_pinToLayoutGuide:view.layoutMarginsGuide edges:UIRectEdgeAll];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Pin to layout guide insets", ^{
            [subview ad_pinToLayoutGuide:view.layoutMarginsGuide insets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Pin to layout guide edges insets", ^{
            [subview ad_pinToLayoutGuide:view.layoutMarginsGuide edges:UIRectEdgeAll insets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Pin to layout guide edges insets", ^{
            [subview ad_pinToLayoutGuide:view.layoutMarginsGuide insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Pin to layout guide edges insets priority", ^{
            [subview ad_pinToLayoutGuide:view.layoutMarginsGuide edges:UIRectEdgeAll insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        // Center in layout guide

        it(@"Center in layout guide", ^{
            [subview ad_centerInLayoutGuide:view.layoutMarginsGuide];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Center in layout guide priority", ^{
            [subview ad_centerInLayoutGuide:view.layoutMarginsGuide priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Center in layout guide axis", ^{
            [subview ad_centerInLayoutGuide:view.layoutMarginsGuide alongAxis:UILayoutConstraintAxisVertical];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Center in layout guide axis priority", ^{
            [subview ad_centerInLayoutGuide:view.layoutMarginsGuide alongAxis:UILayoutConstraintAxisVertical priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        // Constrain in layout guide

        it(@"Constrain in layout guide", ^{
            [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Constrain in layout guide edges", ^{
            [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide edges:UIRectEdgeAll];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Constrain in layout guide insets", ^{
            [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide insets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Constrain in layout guide edges insets", ^{
            [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide edges:UIRectEdgeAll insets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });

        it(@"Constrain in layout guide edges insets priority", ^{
            [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide edges:UIRectEdgeAll insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
        });
     });

    describe(@"Should not translate autoresizing mask into constaints using directional edges and insets", ^{

       __block UIView * view;
       __block UIView * subview;

       beforeEach(^{
           view = [UIView new];
           subview = [UIView new];
           [view addSubview:subview];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beTrue());
       });

       // Pin to layout guide

       it(@"Pin to layout guide", ^{
           [subview ad_pinToLayoutGuide:view.layoutMarginsGuide usingDirectionalEdges:YES];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Pin to layout guide edges", ^{
           [subview ad_pinToLayoutGuide:view.layoutMarginsGuide directionalEdges:NSDirectionalRectEdgeAll];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Pin to layout guide insets", ^{
           [subview ad_pinToLayoutGuide:view.layoutMarginsGuide insets:UIEdgeInsetsZero];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Pin to layout guide edges insets", ^{
           [subview ad_pinToLayoutGuide:view.layoutMarginsGuide
                                  directionalEdges:NSDirectionalRectEdgeAll
                                 insets:NSDirectionalEdgeInsetsZero];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Pin to layout guide edges insets", ^{
           [subview ad_pinToLayoutGuide:view.layoutMarginsGuide
                      directionalInsets:NSDirectionalEdgeInsetsZero
                               priority:UILayoutPriorityRequired];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Pin to layout guide edges insets priority", ^{
           [subview ad_pinToLayoutGuide:view.layoutMarginsGuide
                       directionalEdges:NSDirectionalRectEdgeAll
                                 insets:NSDirectionalEdgeInsetsZero priority:UILayoutPriorityRequired];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       // Constrain in layout guide

       it(@"Constrain in layout guide", ^{
           [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide usingDirectionalEdges:YES];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Constrain in layout guide edges", ^{
           [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide directionalEdges:NSDirectionalRectEdgeAll];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Constrain in layout guide insets", ^{
           [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide directionalInsets:NSDirectionalEdgeInsetsZero];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Constrain in layout guide edges insets", ^{
           [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide
                             directionalEdges:NSDirectionalRectEdgeAll
                                       insets:NSDirectionalEdgeInsetsZero];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });

       it(@"Constrain in layout guide edges insets priority", ^{
           [subview ad_constrainInLayoutGuide:view.layoutMarginsGuide
                             directionalEdges:NSDirectionalRectEdgeAll
                                       insets:NSDirectionalEdgeInsetsZero
                                     priority:UILayoutPriorityRequired];
           expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
       });
    });
}

@end
