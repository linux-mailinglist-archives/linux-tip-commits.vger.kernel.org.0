Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D673B83B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhF3Nuf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhF3NuJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:09 -0400
Date:   Wed, 30 Jun 2021 13:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PDmxAqsZO6JsGndDwe3N93wlBkyUQ3Gr0Aa2UGJGxUw=;
        b=o1LEgMGutg57rb71EJ+FCXagz21FTb0ROyPERVGewPjT7/Tb6P3Or0EdzAJVPeTLxgMcuC
        6CQ9CIwjsIDtO2gJaaGRpmrVoHjxDE+YHcjyEJGtB7CCW9oKFKSb6//Aat1LTfH/VjGG41
        4y6NJclbtG8KfI71NsqPK0Bszhx3nqSzejWIh+0cvgeVfTN71NLSvF5g3l0LSP3Zd/1Sy0
        0qZcx0u8lE4+8K3/iYmzT9LmAlhrz3dHllquyVfjKJ5CWhVZBezf+naCAyQbMEeIGwp9RV
        NSsWKT6cT5Gd2tW4f0C0stoRMKbu6hxYC8l21gizsBtVAYK+6YjRW4qatXOXGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PDmxAqsZO6JsGndDwe3N93wlBkyUQ3Gr0Aa2UGJGxUw=;
        b=Ky4iQFHZS7o404SLaiIQTYljuK2dNhtqn/EhtTgA0j88l6sMI52fHavlNB34QUCi2iTcNa
        nm7jnD2wOnaImTAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Move mem_dump_obj() tests into separate function
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085853.395.5471683826443564751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7ab2bd31df871408792eac871c4187e29d039315
Gitweb:        https://git.kernel.org/tip/7ab2bd31df871408792eac871c4187e29d039315
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 02 May 2021 19:56:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:07 -07:00

rcutorture: Move mem_dump_obj() tests into separate function

To make the purpose of the code more apparent, this commit moves the
tests of mem_dump_obj() to a new rcu_torture_mem_dump_obj() function
and calls it from rcu_torture_cleanup().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 81 ++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8b347b9..ec69273 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1868,48 +1868,49 @@ rcu_torture_stats(void *arg)
 		torture_shutdown_absorb("rcu_torture_stats");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_stats");
-
-	{
-		struct rcu_head *rhp;
-		struct kmem_cache *kcp;
-		static int z;
-
-		kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
-		rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
-		pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
-		pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
-		mem_dump_obj(ZERO_SIZE_PTR);
-		pr_alert("mem_dump_obj(NULL):");
-		mem_dump_obj(NULL);
-		pr_alert("mem_dump_obj(%px):", &rhp);
-		mem_dump_obj(&rhp);
-		pr_alert("mem_dump_obj(%px):", rhp);
-		mem_dump_obj(rhp);
-		pr_alert("mem_dump_obj(%px):", &rhp->func);
-		mem_dump_obj(&rhp->func);
-		pr_alert("mem_dump_obj(%px):", &z);
-		mem_dump_obj(&z);
-		kmem_cache_free(kcp, rhp);
-		kmem_cache_destroy(kcp);
-		rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
-		pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
-		pr_alert("mem_dump_obj(kmalloc %px):", rhp);
-		mem_dump_obj(rhp);
-		pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
-		mem_dump_obj(&rhp->func);
-		kfree(rhp);
-		rhp = vmalloc(4096);
-		pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
-		pr_alert("mem_dump_obj(vmalloc %px):", rhp);
-		mem_dump_obj(rhp);
-		pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
-		mem_dump_obj(&rhp->func);
-		vfree(rhp);
-	}
-
 	return 0;
 }
 
+/* Test mem_dump_obj() and friends.  */
+static void rcu_torture_mem_dump_obj(void)
+{
+	struct rcu_head *rhp;
+	struct kmem_cache *kcp;
+	static int z;
+
+	kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
+	rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
+	pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
+	pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
+	mem_dump_obj(ZERO_SIZE_PTR);
+	pr_alert("mem_dump_obj(NULL):");
+	mem_dump_obj(NULL);
+	pr_alert("mem_dump_obj(%px):", &rhp);
+	mem_dump_obj(&rhp);
+	pr_alert("mem_dump_obj(%px):", rhp);
+	mem_dump_obj(rhp);
+	pr_alert("mem_dump_obj(%px):", &rhp->func);
+	mem_dump_obj(&rhp->func);
+	pr_alert("mem_dump_obj(%px):", &z);
+	mem_dump_obj(&z);
+	kmem_cache_free(kcp, rhp);
+	kmem_cache_destroy(kcp);
+	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+	pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+	pr_alert("mem_dump_obj(kmalloc %px):", rhp);
+	mem_dump_obj(rhp);
+	pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
+	mem_dump_obj(&rhp->func);
+	kfree(rhp);
+	rhp = vmalloc(4096);
+	pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+	pr_alert("mem_dump_obj(vmalloc %px):", rhp);
+	mem_dump_obj(rhp);
+	pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
+	mem_dump_obj(&rhp->func);
+	vfree(rhp);
+}
+
 static void
 rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 {
@@ -2825,6 +2826,8 @@ rcu_torture_cleanup(void)
 	if (cur_ops->cleanup != NULL)
 		cur_ops->cleanup();
 
+	rcu_torture_mem_dump_obj();
+
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
 
 	if (err_segs_recorded) {
