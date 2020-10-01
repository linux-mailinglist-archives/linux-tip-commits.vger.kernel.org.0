Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC92927FB22
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Oct 2020 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgJAINP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Oct 2020 04:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgJAINP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Oct 2020 04:13:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16107C0613D0;
        Thu,  1 Oct 2020 01:13:15 -0700 (PDT)
Date:   Thu, 01 Oct 2020 08:13:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601539992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS56uj8IgEx3m9C9hs4o41w2aUZW5RfRArrU0/olnWw=;
        b=wp5n7eKyFfun1SNq7elFFefdSWIafNtPFMlbISxwKjoxmMHHbhapIG/FP+2SYoQI2fX/Ez
        VTdg/mK7mwj0z09i6cdbe9v7BLCnxX7PClgsR25tS+oEOAm8uMELFPXvxJ7KRPRP+Tn0TH
        e3sx9VfWZqUi9vvpFVDm30UoJh6Aft7oMwC67glKj31PAB4WKaKBUja3Aahwk0qrE8Jwh/
        CFrkUqOMfI1oiIuhSO5FLsecEj+5qXx9AzAjZ0Lytd478LR/uJqTA/R+/eVue4/O6pckz2
        l4YsLLPgu10u+hGKVSjw8PXV6zBxFFtft3+l9VmFEbhKN5fCuaoYPuv2bOJcMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601539992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS56uj8IgEx3m9C9hs4o41w2aUZW5RfRArrU0/olnWw=;
        b=VALX8lctPDHx9kqE3AfHYSbp/0NXAE3RVGsYy7iCDm+JOWct65oWw0h0Jaop6e0yPWAbVm
        iNdggxNqvkZ7JcDA==
From:   "tip-bot2 for Julia Lawall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/mps2-timer: Use semicolons
 rather than commas to separate statements
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601233948-11629-12-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-12-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Message-ID: <160153999169.7002.13925781028080360919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0d555b3ac49b40f94c270681b697d45dcae9faa6
Gitweb:        https://git.kernel.org/tip/0d555b3ac49b40f94c270681b697d45dcae9faa6
Author:        Julia Lawall <Julia.Lawall@inria.fr>
AuthorDate:    Sun, 27 Sep 2020 21:12:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Oct 2020 10:07:26 +02:00

clocksource/drivers/mps2-timer: Use semicolons rather than commas to separate statements

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1601233948-11629-12-git-send-email-Julia.Lawall@inria.fr
---
 drivers/clocksource/mps2-timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
index 2e64d98..efe8cad 100644
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -149,9 +149,9 @@ static int __init mps2_clockevent_init(struct device_node *np)
 	ce->clkevt.rating = 200;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.cpumask = cpu_possible_mask;
-	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown,
-	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic,
-	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown,
+	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown;
+	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic;
+	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown;
 	ce->clkevt.set_next_event	= mps2_timer_set_next_event;
 
 	/* Ensure timer is disabled */
