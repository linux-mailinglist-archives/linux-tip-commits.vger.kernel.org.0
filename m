Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0148E35B517
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhDKNpL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbhDKNoZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:25 -0400
Date:   Sun, 11 Apr 2021 13:43:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LnZA96Bb7z5qwG49iLVncDIJxkQCdSnCeLDcMtagcyk=;
        b=JnD7aoC8kiijX0/LSInKNYFyym6ft090cjSWtCLk6K93Yeep3pk0/9l20csLsn5lXDwvgS
        qpUu0kqYn+R3eh8xbFf88MGPKlIvYjkvEczlgmx3pXSqoa4y7lXjLX45OheeBpD2ypoadP
        fvoAxq/fXLzxvnQWQs6Asj6cYufp+M59LbO4RaYKRiWh6Qzgn0wBpyX05kKAJ/Yr1d9vpL
        CbSeNMfeoTXcC7kheqdvcowF0z8N3ueqSgmdwEzGuGO0+txKdGW6VKcl5bkPks9WwG6q57
        TwseTzBk7gMY/3dVertNfCOenXVcncpzJ7FV5xxGLjDX6IhQVp1am7IEkI8qow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LnZA96Bb7z5qwG49iLVncDIJxkQCdSnCeLDcMtagcyk=;
        b=apMjtgZqgLt2m3Y2byycaLqV/HTtrmbMyxlT5qY4QCs707wPIBTJC2X6tAZu0/b1uJFbHn
        OMN4/afzeDwI2gCg==
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix CPU-offline trace in rcutree_dying_cpu
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862260.29796.11396715257005763480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     47fcbc8dd62f15dc75916225ebacdc3bca9c12b2
Gitweb:        https://git.kernel.org/tip/47fcbc8dd62f15dc75916225ebacdc3bca9c12b2
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Mon, 11 Jan 2021 17:15:58 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:17:35 -08:00

rcu: Fix CPU-offline trace in rcutree_dying_cpu

The condition in the trace_rcu_grace_period() in rcutree_dying_cpu() is
backwards, so that it uses the string "cpuofl" when the offline CPU is
blocking the current grace period and "cpuofl-bgp" otherwise.  Given that
the "-bgp" stands for "blocking grace period", this is at best misleading.
This commit therefore switches these strings in order to correctly trace
whether the outgoing cpu blocks the current grace period.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cdf091f..e62c2de 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2413,7 +2413,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
-			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
+			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
 }
 
