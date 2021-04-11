Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF30335B502
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhDKNoo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbhDKNoN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:13 -0400
Date:   Sun, 11 Apr 2021 13:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=f7E1468DirXlMfMgo19qhJQxEB+iDGqhDyGzR6CKc04=;
        b=J4+kIkaUl9KaZPmanSjA+X6Hmavtmc5xwLB/S0/C/QNrCinjBPKeYYCDmKRVwgDtV7h50z
        rHp64J8iJEiKGl4tea7mAtthK2lB47actZdB6MMXeN/YEi6URcKX05uH87Gu/U39SaE1pq
        922OtUaT+ex6rC5nHC1ZgUmbBU2nhlbetpKR+df/xoh3ADAvxUUFJpXOrnVb5/o7Ft2UPh
        kB/43Tw3Hp05xuZvFFMayxzyPsIDahq6NRGeTrPR4RB78E+2i+X3UDvI5M11wYvE8G518A
        f05xDaJ63c1MDIFVkO66G6SuC1ehURFel8oYlwGjiL5UhV6s1PXAZzE9H3TJOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=f7E1468DirXlMfMgo19qhJQxEB+iDGqhDyGzR6CKc04=;
        b=6JR7SjfZ9IoyGQIkKD+xlDzPKV8M1WFLV6OwD/vNQ7ZQzRIzpQkB42a7xBYzADIhDQ6L2c
        OMXu5+CQpizYfzAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add crude tests for mem_dump_obj()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861848.29796.9140894761328925955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0d3dd2c8eadb7d4404b8788f552fb2b824fe2c7e
Gitweb:        https://git.kernel.org/tip/0d3dd2c8eadb7d4404b8788f552fb2b824fe2c7e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 07 Dec 2020 21:23:36 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:46 -08:00

rcutorture: Add crude tests for mem_dump_obj()

This commit adds a few crude tests for mem_dump_obj() to rcutorture
runs.  Just to prevent bitrot, you understand!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 39 +++++++++++++++++++++++++++++++++++++++
 mm/slab_common.c        |  2 ++
 mm/util.c               |  1 +
 3 files changed, 42 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..8e93f2e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1861,6 +1861,45 @@ rcu_torture_stats(void *arg)
 		torture_shutdown_absorb("rcu_torture_stats");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_stats");
+
+	{
+		struct rcu_head *rhp;
+		struct kmem_cache *kcp;
+		static int z;
+
+		kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
+		rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
+		pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
+		pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
+		mem_dump_obj(ZERO_SIZE_PTR);
+		pr_alert("mem_dump_obj(NULL):");
+		mem_dump_obj(NULL);
+		pr_alert("mem_dump_obj(%px):", &rhp);
+		mem_dump_obj(&rhp);
+		pr_alert("mem_dump_obj(%px):", rhp);
+		mem_dump_obj(rhp);
+		pr_alert("mem_dump_obj(%px):", &rhp->func);
+		mem_dump_obj(&rhp->func);
+		pr_alert("mem_dump_obj(%px):", &z);
+		mem_dump_obj(&z);
+		kmem_cache_free(kcp, rhp);
+		kmem_cache_destroy(kcp);
+		rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+		pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+		pr_alert("mem_dump_obj(kmalloc %px):", rhp);
+		mem_dump_obj(rhp);
+		pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
+		mem_dump_obj(&rhp->func);
+		kfree(rhp);
+		rhp = vmalloc(4096);
+		pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
+		pr_alert("mem_dump_obj(vmalloc %px):", rhp);
+		mem_dump_obj(rhp);
+		pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
+		mem_dump_obj(&rhp->func);
+		vfree(rhp);
+	}
+
 	return 0;
 }
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cec9536..4c6107e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -545,6 +545,7 @@ bool kmem_valid_obj(void *object)
 	page = virt_to_head_page(object);
 	return PageSlab(page);
 }
+EXPORT_SYMBOL_GPL(kmem_valid_obj);
 
 /**
  * kmem_dump_obj - Print available slab provenance information
@@ -601,6 +602,7 @@ void kmem_dump_obj(void *object)
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
 
 #ifndef CONFIG_SLOB
diff --git a/mm/util.c b/mm/util.c
index 2d497fe..c37e24d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1014,4 +1014,5 @@ void mem_dump_obj(void *object)
 	}
 	pr_cont(" non-slab/vmalloc memory.\n");
 }
+EXPORT_SYMBOL_GPL(mem_dump_obj);
 #endif
