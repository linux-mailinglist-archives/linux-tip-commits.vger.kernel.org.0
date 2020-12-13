Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECED2D8F90
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLMTBm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgLMTBm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08CC0613CF;
        Sun, 13 Dec 2020 11:01:02 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:00:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7uCXFZk38Cf0w3xZoB0lL2iSrYgDjhM5dzQdHf426t4=;
        b=Tt65TSQ3YmnTMNv/m51Dgl8gUP8dC/K+HwLNkU0Gw6oRelxOxqbrQsZcOWb33N5R6UCy3o
        r9Ln3wNqli4ytknEHsXACfdfhiuiHsXkafEfBXzd1dxK4hIfysjruDYXRpGS2C3euMx0Bm
        /LAzeOdteIrfY1F1e4GVMceVRNLPuxM0s0hPV6j0lzCJ8jqSvZzyNJOvZlCETlepfpb3Dd
        NLfCk83Uy3bh8EzZpJ+Nb0HDBLgIMSB2vcZ8LjBMi2ysb/F9086LfUUr1iW6DKjoGopMkm
        zUdN2FAbfqF+MTFD/k+D1e+wwF74lOIBDKDR89euZ1A7VlLfTWWgNIPecNRDRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7uCXFZk38Cf0w3xZoB0lL2iSrYgDjhM5dzQdHf426t4=;
        b=lP5OET2Bo/k5qS9MU0hMzH34kGwXrVBprE38zNK16UpIUwXAgTs/6pVdRk2qpydDz1rF9L
        xnadhWroPHN40gCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Take early exit on memory-allocation failure
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788605872.3364.276499462904083916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     50edb988534c621a56ca103c0c16ac59e7399f01
Gitweb:        https://git.kernel.org/tip/50edb988534c621a56ca103c0c16ac59e7399f01
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 10 Sep 2020 11:54:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

srcu: Take early exit on memory-allocation failure

It turns out that init_srcu_struct() can be invoked from usermode tasks,
and that fatal signals received by these tasks can cause memory-allocation
failures.  These failures are not handled well by init_srcu_struct(),
so much so that NULL pointer dereferences can result.  This commit
therefore causes init_srcu_struct() to take an early exit upon detection
of memory-allocation failure.

Link: https://lore.kernel.org/lkml/20200908144306.33355-1-aik@ozlabs.ru/
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c13348e..6f7880a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
+	if (!ssp->sda)
+		return -ENOMEM;
 	init_srcu_struct_nodes(ssp, is_static);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
-	return ssp->sda ? 0 : -ENOMEM;
+	return 0;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
