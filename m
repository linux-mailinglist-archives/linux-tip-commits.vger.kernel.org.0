Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CF2CC687
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgLBTXy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 14:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgLBTXx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 14:23:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF2C0613CF;
        Wed,  2 Dec 2020 11:23:13 -0800 (PST)
Date:   Wed, 02 Dec 2020 19:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxT47pVqs6r9HdJqHgJ+gdb048ASC+VWA1xXaJl/mXk=;
        b=vFfhFeu1AgLagcUMBxJNCBZi4M1N3RnMiSeXSzSXRbk9pCGOGcPwBM0OpSmkdAf/vTux6k
        GRkkQXGQJBYxrlNxPEX7LLfoJD3qTn/j9pd2MRpD7KULYn2milCh1NzRtrAeYX49nislEI
        0bEFhnVSakKP3Dmx7JJuNKehE3JDtpEbjJ5LH59eLNjI61w832AcHWPLe1YT9ToOIDnZDK
        lv9PngjkF5VwkvRbaksmSjQtnq0IjL/N1fjDdnio7roGHlav1mFzgvukkQc/Wm7y2DM85/
        oxcg0zXalNoIP+JqcPacnrWXayidKKEdLJiV0CIiWVTS8MXX8gCncf7elajQKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxT47pVqs6r9HdJqHgJ+gdb048ASC+VWA1xXaJl/mXk=;
        b=o7Zs03Q0BeAvOQdCoHVvH69FRV6LtKgfAxufw6SrLUK1+ZCONg/Oznf/Ehg9XgTyKXcUgE
        tWEb2jLKqzE+tsBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irq: Call tick_irq_enter() inside HARDIRQ_OFFSET
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201202115732.27827-6-frederic@kernel.org>
References: <20201202115732.27827-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160693699084.3364.1887616358916715412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d14ce74f1fb376ccbbc0b05ded477ada51253729
Gitweb:        https://git.kernel.org/tip/d14ce74f1fb376ccbbc0b05ded477ada51253729
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 12:57:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 20:20:05 +01:00

irq: Call tick_irq_enter() inside HARDIRQ_OFFSET

Now that account_hardirq_enter() is called after HARDIRQ_OFFSET has
been incremented, there is nothing left that prevents us from also
moving tick_irq_enter() after HARDIRQ_OFFSET is incremented.

The desired outcome is to remove the nasty hack that prevents softirqs
from being raised through ksoftirqd instead of the hardirq bottom half.
Also tick_irq_enter() then becomes appropriately covered by lockdep.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201202115732.27827-6-frederic@kernel.org

---
 kernel/softirq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b8f42b3..d5bfd5e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -377,16 +377,12 @@ restart:
  */
 void irq_enter_rcu(void)
 {
-	if (is_idle_task(current) && !in_interrupt()) {
-		/*
-		 * Prevent raise_softirq from needlessly waking up ksoftirqd
-		 * here, as softirq will be serviced on return from interrupt.
-		 */
-		local_bh_disable();
+	__irq_enter_raw();
+
+	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
 		tick_irq_enter();
-		_local_bh_enable();
-	}
-	__irq_enter();
+
+	account_hardirq_enter(current);
 }
 
 /**
