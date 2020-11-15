Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF54C2B3A6D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgKOWvH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgKOWvH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB3C0613D1;
        Sun, 15 Nov 2020 14:51:06 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Wv45C3/cXlESsy/Z3e31GhH4uVJgOaT1qzd7JBAoEM=;
        b=WXu1hwIXEhwwNdzDJoT0R3kzIpcq+E1wquvibXhqkhoSMHnC6JBbwG5eNsfPU7Iuxg2+Rc
        KsEhIEYmo3Gviv4aH8gesRHhb4+Z5Bs5QahqTsDBGcMpcM20KFEOASe10aTV2zWK98obI0
        PKUjRogzxH3rvXD/CheLHUNGfylwd3mimTPOCf0IVK0dQGziMyHSyVNIaRDT+IZZ68Uiax
        +c2LfbQSiX8ZM4f18/lZD8j0lITbmvsBcSWo6u5J3PjOD+N+v7yhlNr/H60Oel06h7JDqQ
        ErQEAim1gHXK8ospY4mumk2PD193wtQFcv1fJcowhMA3k7TutL81WTScyf2GHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Wv45C3/cXlESsy/Z3e31GhH4uVJgOaT1qzd7JBAoEM=;
        b=tNOdNJtaFJqfZ/TxGqFbMRkQYzVU+dyYMPmh6NeZTws4E5Vc36EX/xbi0bK2dJ0pSWnoLI
        8QqUbc+a8WWpnACg==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Address parameter documentation
 issues for various functions
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605252275-63652-5-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-5-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160548066313.11244.12638892148652861602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6e5a91901c2dff3a0f2eb9f10e427dce2b0488fc
Gitweb:        https://git.kernel.org/tip/6e5a91901c2dff3a0f2eb9f10e427dce2b0488fc
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 15:24:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:24 +01:00

timekeeping: Address parameter documentation issues for various functions

The kernel-doc parser complains:

 kernel/time/timekeeping.c:1543: warning: Function parameter or member
 'ts' not described in 'read_persistent_clock64'

 kernel/time/timekeeping.c:764: warning: Function parameter or member
 'tk' not described in 'timekeeping_forward_now'

 kernel/time/timekeeping.c:1331: warning: Function parameter or member
 'ts' not described in 'timekeeping_inject_offset'

 kernel/time/timekeeping.c:1331: warning: Excess function parameter 'tv'
 description in 'timekeeping_inject_offset'

Add the missing parameter documentations and rename the 'tv' parameter of
timekeeping_inject_offset() to 'ts' so it matches the implemention.

[ tglx: Reworded a few docs and massaged changelog ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1605252275-63652-5-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/time/timekeeping.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 75cba95..74503c0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -774,6 +774,7 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 
 /**
  * timekeeping_forward_now - update clock to the current time
+ * @tk:		Pointer to the timekeeper to update
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
@@ -1350,7 +1351,7 @@ EXPORT_SYMBOL(do_settimeofday64);
 
 /**
  * timekeeping_inject_offset - Adds or subtracts from the current time.
- * @tv:		pointer to the timespec variable containing the offset
+ * @ts:		Pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
@@ -1558,6 +1559,7 @@ u64 timekeeping_max_deferment(void)
 
 /**
  * read_persistent_clock64 -  Return time from the persistent clock.
+ * @ts: Pointer to the storage for the readout value
  *
  * Weak dummy function for arches that do not yet support it.
  * Reads the time from the battery backed persistent clock.
@@ -1663,7 +1665,8 @@ static struct timespec64 timekeeping_suspend_time;
 
 /**
  * __timekeeping_inject_sleeptime - Internal function to add sleep interval
- * @delta: pointer to a timespec delta value
+ * @tk:		Pointer to the timekeeper to be updated
+ * @delta:	Pointer to the delta value in timespec64 format
  *
  * Takes a timespec offset measuring a suspend interval and properly
  * adds the sleep offset to the timekeeping variables.
