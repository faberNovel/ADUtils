//
//  ADViewLayoutTestsObjc.m
//  ADUtilsTests
//
//  Created by Pierre Felgines on 09/10/2018.
//

#import <XCTest/XCTest.h>
@import ADUtils;
@import Quick;
@import Nimble;

@interface ADViewLayoutTestsObjc : QuickSpec

@end

@implementation ADViewLayoutTestsObjc

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

        // Pin to superview

        it(@"Pin to superview", ^{
            [subview ad_pinToSuperview];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges", ^{
            [subview ad_pinToSuperviewWithEdges:UIRectEdgeAll];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview insets", ^{
            [subview ad_pinToSuperviewWithInsets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges insets", ^{
            [subview ad_pinToSuperviewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges priority", ^{
            [subview ad_pinToSuperviewWithEdges:UIRectEdgeAll priority: UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Pin to superview edges insets priority", ^{
            [subview ad_pinToSuperviewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        // Center in superview

        it(@"Center in superview", ^{
            [subview ad_centerInSuperview];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(2));
        });

        it(@"Center in superview priority", ^{
            [subview ad_centerInSuperviewWithPriority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(2));
        });

        it(@"Center in superview axis", ^{
            [subview ad_centerInSuperviewAlongAxis:UILayoutConstraintAxisVertical];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(1));
        });

        it(@"Center in superview axis priority", ^{
            [subview ad_centerInSuperviewAlongAxis:UILayoutConstraintAxisVertical priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(1));
        });

        // Contrain to size

        it(@"Constrain to size", ^{
            [subview ad_constrainToSize:CGSizeZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(subview.constraints.count).to(equal(2));
        });

        it(@"Constrain to size priority", ^{
            [subview ad_constrainToSize:CGSizeZero priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(subview.constraints.count).to(equal(2));
        });

        // Constrain in superview

        it(@"Constrain in superview", ^{
            [subview ad_constrainInSuperview];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview edges", ^{
            [subview ad_constrainInSuperviewWithEdges:UIRectEdgeAll];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview insets", ^{
            [subview ad_constrainInSuperviewWithInsets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview edges insets", ^{
            [subview ad_constrainInSuperviewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });

        it(@"Constrain in superview edges insets priority", ^{
            [subview ad_constrainInSuperviewWithEdges:UIRectEdgeAll insets:UIEdgeInsetsZero priority:UILayoutPriorityRequired];
            expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
            expect(view.constraints.count).to(equal(4));
        });
     });

    if (@available(iOS 13.0, *)) {
        describe(@"Should not translate autoresizing mask into constaints using directional edges and insets", ^{

            __block UIView * view;
            __block UIView * subview;

            beforeEach(^{
                view = [UIView new];
                subview = [UIView new];
                [view addSubview:subview];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beTrue());
            });

            // Pin to superview

            it(@"Pin to superview", ^{
                [subview ad_pinToSuperviewUsingDirectionalEdges:YES];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges", ^{
                [subview ad_pinToSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview insets", ^{
                [subview ad_pinToSuperviewWithDirectionalInsets:NSDirectionalEdgeInsetsZero];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges insets", ^{
                [subview ad_pinToSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll insets:NSDirectionalEdgeInsetsZero];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges priority", ^{
                [subview ad_pinToSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll priority: UILayoutPriorityRequired];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Pin to superview edges insets priority", ^{
                [subview ad_pinToSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                        insets:NSDirectionalEdgeInsetsZero
                                                      priority:UILayoutPriorityRequired];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            // Constrain in superview

            it(@"Constrain in superview", ^{
                [subview ad_constrainInSuperviewUsingDirectionalEdges:YES];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview edges", ^{
                [subview ad_constrainInSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview insets", ^{
                [subview ad_constrainInSuperviewWithDirectionalInsets:NSDirectionalEdgeInsetsZero];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview edges insets", ^{
                [subview ad_constrainInSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                              insets:NSDirectionalEdgeInsetsZero];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });

            it(@"Constrain in superview edges insets priority", ^{
                [subview ad_constrainInSuperviewWithDirectionalEdges:NSDirectionalRectEdgeAll
                                                              insets:NSDirectionalEdgeInsetsZero
                                                            priority:UILayoutPriorityRequired];
                expect(subview.translatesAutoresizingMaskIntoConstraints).to(beFalse());
                expect(view.constraints.count).to(equal(4));
            });
        });
    }
}

@end
