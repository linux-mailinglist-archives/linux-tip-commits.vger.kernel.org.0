Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B10D3B0806
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhFVPA5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhFVPAz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 11:00:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA41C061574;
        Tue, 22 Jun 2021 07:58:39 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624373917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+23EtS6gbSfirkpw+hBRHARvcfuZuOHSZPx+39qi3c=;
        b=TowSkbskhdaA4WDwrGOBKbjLJpxeeRa+BNR3DznXTtgvHz65ijoJBJqqlWxnX124pLnKqj
        MPGrOf3jhGKrJ8+G9VDcF2FlFUngI35nrbV1IUhultFzyDceBD+Tf9wWp85tMduNqCtnh9
        lzjK+lnztw408AJtifbtKJN0DWop6sHjITt1NLSP5kNsm6by7Z/U0z3K7Ago6ukH6vxTg8
        BZ+UY2hj2SiUtzadM1mLWOsyx38g2FYVATCN14vGEbq+VCIahX14zS8PuObEd+i+2o3yVj
        6fwrmdZoQKae/mvZ4ggYV5yVx7FTztTY8ZuhIZi9TOqu3/Y2YIgqDH8SPKuOjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624373917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+23EtS6gbSfirkpw+hBRHARvcfuZuOHSZPx+39qi3c=;
        b=PMcUeaieQtuEBZl2QiEm1U/MPbtWNlQ3a7FZ5KbIVB42SzmQdyh2MKMHJCAbP+QTqc5YvC
        dTbLx02g4QwzaJBw==
From:   "tip-bot2 for Feng Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Print deviation in nanoseconds when a
 clocksource becomes unstable
Cc:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527190124.440372-6-paulmck@kernel.org>
References: <20210527190124.440372-6-paulmck@kernel.org>
MIME-Version: 1.0
Message-ID: <162437391668.395.10225430512001144331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     22a22383371667962b46bd90d534cc57669537ac
Gitweb:        https://git.kernel.org/tip/22a22383371667962b46bd90d534cc57669537ac
Author:        Feng Tang <feng.tang@intel.com>
AuthorDate:    Thu, 27 May 2021 12:01:24 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 16:53:17 +02:00

clocksource: Print deviation in nanoseconds when a clocksource becomes unstable

Currently when an unstable clocksource is detected, the raw counters of
that clocksource and watchdog will be printed, which can only be understood
after some math calculation.

So print the delta in nanoseconds as well to make it easier for humans to
check the results.

[ paulmck: Fix typo. ]

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210527190124.440372-6-paulmck@kernel.org

---
 kernel/time/clocksource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 74d6a23..b89c76e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -407,10 +407,10 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (abs(cs_nsec - wd_nsec) > md) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
-			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
-				watchdog->name, wdnow, wdlast, watchdog->mask);
-			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
-				cs->name, csnow, cslast, cs->mask);
+			pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
+				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
+			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
+				cs->name, cs_nsec, csnow, cslast, cs->mask);
 			if (curr_clocksource == cs)
 				pr_warn("                      '%s' is current clocksource.\n", cs->name);
 			else if (curr_clocksource)
