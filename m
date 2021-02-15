Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724DF31BB8B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhBOO4k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBOO43 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:29 -0500
Date:   Mon, 15 Feb 2021 14:55:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C2CZFHWcttv6Woe53fQ0TFqgdEZDZNusHEp+IziRhVg=;
        b=P/PQyfA5Dlf1SPIS4dIlxnmgk5Efc3w9mOzD1aK+Ql97EBnjlMdOw2FP55bfjLoTRuOJya
        AAtg4Om5aJrgSreAgJERdtjyaDOuwBx7kGEEhDnEYtCKxYt9HyMQW74dj1ULuVw5pU4U7H
        9ejYD7h8QlppvIhNMPFXgg6fV5pqtJ/XLuzH1gKPh4a5fKxws1PTgMiGIAAVlPXURzz7xp
        sskuJTJ2r5LBvs7oo5i66M8zXVtAFzkXapgh5kOK2vuIXXwrNzJS1iijbidGO07DAh07nq
        GRV2gAt32AYDSnj5PPv7dQ+CPR+YxihUontE6BegT3jT+GjAsGuQrNvCvXRApw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C2CZFHWcttv6Woe53fQ0TFqgdEZDZNusHEp+IziRhVg=;
        b=PYQK25F0uHGIi3iG9TyXnvW40rhzZkvevbK1QJ5HD2nZaj0Orfonw1g//KYBctgy3TKCxM
        sRjEVYge4mjdQfAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Provide internal interface to start a Tiny SRCU
 grace period
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094519.20312.12240484501393985197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1a893c711a600ab57526619b56e6f6b7be00956e
Gitweb:        https://git.kernel.org/tip/1a893c711a600ab57526619b56e6f6b7be00956e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 09:37:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:37 -08:00

srcu: Provide internal interface to start a Tiny SRCU grace period

There is a need for a polling interface for SRCU grace periods.
This polling needs to initiate an SRCU grace period without
having to queue (and manage) a callback.  This commit therefore
splits the Tiny SRCU call_srcu() function into callback-queuing and
start-grace-period portions, with the latter in a new function named
srcu_gp_start_if_needed().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 5598cf6..3bac1db 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -152,6 +152,16 @@ void srcu_drive_gp(struct work_struct *wp)
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
+static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
+{
+	if (!READ_ONCE(ssp->srcu_gp_running)) {
+		if (likely(srcu_init_done))
+			schedule_work(&ssp->srcu_work);
+		else if (list_empty(&ssp->srcu_work.entry))
+			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
+	}
+}
+
 /*
  * Enqueue an SRCU callback on the specified srcu_struct structure,
  * initiating grace-period processing if it is not already running.
@@ -167,12 +177,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
 	local_irq_restore(flags);
-	if (!READ_ONCE(ssp->srcu_gp_running)) {
-		if (likely(srcu_init_done))
-			schedule_work(&ssp->srcu_work);
-		else if (list_empty(&ssp->srcu_work.entry))
-			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
-	}
+	srcu_gp_start_if_needed(ssp);
 }
 EXPORT_SYMBOL_GPL(call_srcu);
 
