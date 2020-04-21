//
//  ADLayoutGuideTestsObjc.m
//  ADUtilsTests
//
//  Created by Denis Poifol on 22/01/2019.
//

#import <XCTest/XCTest.h>
@import ADUtils;
@import Quick;
@import Nimble;

@interface ADLayoutGuideTestsObjc : QuickSpec

@end

@implementation ADLayoutGuideTestsObjc

- (void)spec {

    describe(@"Should not translate autoresizing mask into constaints", ^{

        __block UIView * view;
        __block UILayoutGuide * layoutGuide;

        beforeEach(^{
            view = [UIView new];
            layoutGuide = [UILayoutGuide new];
            [view addLayoutGuide:layoutGuide];
        });

        // Pin to superview

        it(@"Pin to superview", ^{
            [layoutGuide ad_pinToOwningView];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges", ^{
            [layoutGuide ad_pinToOwningViewWithEdges:UIRectEdgeAll];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview insets", ^{
            [layoutGuide ad_pinToOwningViewWithInsets:UIEdgeInsetsZero];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges insets", ^{
            [layoutGuide ad_pinToOwningViewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges insets priority", ^{
            [layoutGuide ad_pinToOwningViewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(view.constraints.count).to(equal(4));
        });

        // Center in superview

        it(@"Center in superview", ^{
            [layoutGuide ad_centerInOwningView];
            expect(view.constraints.count).to(equal(2));
        });

        it(@"Center in superview priority", ^{
            [layoutGuide ad_centerInOwningViewWithPriority:UILayoutPriorityRequired];
            expect(view.constraints.count).to(equal(2));
        });

        it(@"Center in superview axis", ^{
            [layoutGuide ad_centerInOwningViewAlongAxis:UILayoutConstraintAxisVertical];
            expect(view.constraints.count).to(equal(1));
        });

        it(@"Center in superview axis priority", ^{
            [layoutGuide ad_centerInOwningViewAlongAxis:UILayoutConstraintAxisVertical priority:UILayoutPriorityRequired];
            expect(view.constraints.count).to(equal(1));
        });

        // Contrain to size

        it(@"Constrain to size", ^{
            [layoutGuide ad_constrainToSize:CGSizeZero];
            expect(view.constraints.count).to(equal(2));
        });

        it(@"Constrain to size priority", ^{
            [layoutGuide ad_constrainToSize:CGSizeZero priority:UILayoutPriorityRequired];
            expect(view.constraints.count).to(equal(2));
        });

        // Constrain in superview

        it(@"Constrain in superview", ^{
            [layoutGuide ad_constrainInOwningView];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview edges", ^{
            [layoutGuide ad_constrainInOwningViewWithEdges:UIRectEdgeAll];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview insets", ^{
            [layoutGuide ad_constrainInOwningViewWithInsets:UIEdgeInsetsZero];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview edges insets", ^{
            [layoutGuide ad_constrainInOwningViewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero];
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview edges insets priority", ^{
            [layoutGuide ad_constrainInOwningViewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(view.constraints.count).to(equal(4));
        });
    });

    if (@available(iOS 13.0, *)) {
        describe(@"Should not translate autoresizing mask into constaints", ^{

            __block UIView * view;
            __block UILayoutGuide * layoutGuide;

            beforeEach(^{
                view = [UIView new];
                layoutGuide = [UILayoutGuide new];
                [view addLayoutGuide:layoutGuide];
            });

            // Pin to superview

            it(@"Pin to superview", ^{
                [layoutGuide ad_pinToOwningViewUsingDirectionalEdges:YES];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges", ^{
                [layoutGuide ad_pinToOwningViewWithDirectionalEdges:NSDirectionalRectEdgeAll];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview insets", ^{
                [layoutGuide ad_pinToOwningViewWithDirectionalInsets:NSDirectionalEdgeInsetsZero];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges insets", ^{
                [layoutGuide ad_pinToOwningViewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                             insets:NSDirectionalEdgeInsetsZero];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges insets priority", ^{
                [layoutGuide ad_pinToOwningViewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                             insets:NSDirectionalEdgeInsetsZero
                                                           priority:UILayoutPriorityRequired];
                expect(view.constraints.count).to(equal(4));
            });

            // Constrain in superview

            it(@"Constrain in superview", ^{
                [layoutGuide ad_constrainInOwningViewUsingDirectionalEdges:YES];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview edges", ^{
                [layoutGuide ad_constrainInOwningViewWithDirectionalEdges:NSDirectionalRectEdgeAll];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview insets", ^{
                [layoutGuide ad_constrainInOwningViewWithDirectionalInsets:NSDirectionalEdgeInsetsZero];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview edges insets", ^{
                [layoutGuide ad_constrainInOwningViewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                                   insets:NSDirectionalEdgeInsetsZero];
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview edges insets priority", ^{
                [layoutGuide ad_constrainInOwningViewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                                   insets:NSDirectionalEdgeInsetsZero
                                                                 priority:UILayoutPriorityRequired];
                expect(view.constraints.count).to(equal(4));
            });
        });
    }
}

@end
