Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64A4281514
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Oct 2020 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBO3G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Oct 2020 10:29:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBO3F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Oct 2020 10:29:05 -0400
Date:   Fri, 02 Oct 2020 14:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601648943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh6O6AmCAZzwzK8oZVqQ7DskeEEeI53l84FXZ/tMq1k=;
        b=hIgV92eC359sZzi1iHCodRCBaXe+GLajrczPxx5oJAXEtQSPh6OXHjQUeGGvC2heNTE5z6
        t1eB7Jeg2pBrI5Gr+JRyF626SrJuP/3aKMUKFBfASv9xudB3YFpX+9YoQYWQHJFKrivQiD
        clolf2u2LRgGhWTYg67dXKmTG1/+plecBhkW/WJn4WgRIogb6Jn5KwmvmBKxN9i6cVq0++
        lNCfqWnCPVpcTRmHB/ROVqguKpXBQXRvshTgQRyx0rkwe7rkXYqEay1m/VF6NWTfNKWcqJ
        OGu5kgAPyrGS+2wa5eabgXM1kJc6eZ83qcH1UsVWjFK2zkhlIqooPpg6dhVFxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601648943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh6O6AmCAZzwzK8oZVqQ7DskeEEeI53l84FXZ/tMq1k=;
        b=i9PwQhCDtAe/GNe8CBHp3FtC4upWdHmdI3IWCzp/UzSBv8WN8Mvt7AuXXzwPXxmil0SoHS
        d3uXnS6DPI19RSDA==
From:   "tip-bot2 for Julia Lawall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/armada-370-xp: Use semicolons
 rather than commas to separate statements
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601233948-11629-17-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-17-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Message-ID: <160164894233.7002.10700476113258729444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1b80043ed21894eca888157145b955df02887995
Gitweb:        https://git.kernel.org/tip/1b80043ed21894eca888157145b955df02887995
Author:        Julia Lawall <Julia.Lawall@inria.fr>
AuthorDate:    Sun, 27 Sep 2020 21:12:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Oct 2020 16:27:28 +02:00

clocksource/drivers/armada-370-xp: Use semicolons rather than commas to separate statements

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
Link: https://lore.kernel.org/r/1601233948-11629-17-git-send-email-Julia.Lawall@inria.fr
---
 drivers/clocksource/timer-armada-370-xp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
index edf1a46..e3acc3c 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -181,12 +181,12 @@ static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
 		clr = TIMER0_25MHZ;
 	local_timer_ctrl_clrset(clr, set);
 
-	evt->name		= "armada_370_xp_per_cpu_tick",
+	evt->name		= "armada_370_xp_per_cpu_tick";
 	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_PERIODIC;
-	evt->shift		= 32,
-	evt->rating		= 300,
-	evt->set_next_event	= armada_370_xp_clkevt_next_event,
+	evt->shift		= 32;
+	evt->rating		= 300;
+	evt->set_next_event	= armada_370_xp_clkevt_next_event;
 	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
 	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
 	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
