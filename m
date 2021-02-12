Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8158319EB9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBLMk1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhBLMi6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:58 -0500
Date:   Fri, 12 Feb 2021 12:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TCPgb8IGM8FBRqw39Hojhl2G9PnH3vTfYO2mIjt0jUE=;
        b=ejtsKj9Rkh3IF09JUXcutXzMd4rJvFkS8dQlQdU/GMIQnaGmN2k+nJRpJ/nZMKO88EBd02
        FekXvEd9ZU2HKnW9KG2nImEUIypfOoxVJAnyV+wUW/nRRzzrgLgMhhUBMX2h5bfEeBqrps
        ik8rDk0E4QKCCZizr1XGmBNLXLPEJ6tzauZ+xpZwZwBo+cp5qi0xmu8ylDn0j296caieLX
        d2h/2rIuQW4+jxVvgmsfw7c9VO5HEER/JX3uAaHJ9AZGbY6Ivu1eKmgtH+wuZcAsOVne9c
        buqPzb3inn6Pk2x9lrWH+x5kNtDGO2Aea3Ct61BfdfhvvrRSfzAX0wpxm4GyPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TCPgb8IGM8FBRqw39Hojhl2G9PnH3vTfYO2mIjt0jUE=;
        b=7da9fJ+D6wW4lKt9CCq9oDk0ClJDbcv7vojM7A4TLY2yeHCcPKlNNhuOGqRAjkUKjFjJW6
        fjedn2RbI3NFnNCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Add nocb CB kthread list to
 show_rcu_nocb_state() output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343611.23325.12146233850710821191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3d0cef50f32e2bc69f60909584c18623bba9a6c6
Gitweb:        https://git.kernel.org/tip/3d0cef50f32e2bc69f60909584c18623bba9a6c6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 18 Dec 2020 13:17:37 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:25:00 -08:00

rcu/nocb: Add nocb CB kthread list to show_rcu_nocb_state() output

This commit improves debuggability by indicating laying out the order
in which rcuoc kthreads appear in the ->nocb_next_cb_rdp list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5ee1113..bc63a6b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2730,6 +2730,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
 	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
+		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
 		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
