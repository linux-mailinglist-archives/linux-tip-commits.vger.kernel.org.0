Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119F6280173
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Oct 2020 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgJAOkV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Oct 2020 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOkU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Oct 2020 10:40:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CCAC0613D0;
        Thu,  1 Oct 2020 07:40:20 -0700 (PDT)
Date:   Thu, 01 Oct 2020 14:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601563218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIhVe2PlDvHXb45EEPzCb0UF4TEaWgDVSbYXDqQKqF8=;
        b=Qkh4MvpfzgquP9x3LmWFy3VYnxMO+yqupenn5gUrUwmokvK+ZYEy8tuR6WILy/X0Kjtjsu
        UyWQ8cs6j9ulpCtAEUzutesz8JDBA7FN57XEwtWqkh95Dc4QObWFyK53OKPUJv14SGfMpd
        t54eENyeZ9+spLbg8seqHpPjGRNDBLLrbzNPd5gRtTo1l5pRr4mk76E8Km3TvbEsKP0nl1
        W3EmFSwukJIi52C6HiqwA4X8y452nVZb8s7tPy7kWb2v3UjVlQJk+5ZV/iGSsUdlUTkdyn
        8IAJIPcHwFFqIUi7mGu7NSIkaHcno+GqoC/LwKIlY3966om65il2CaUztLaX2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601563218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIhVe2PlDvHXb45EEPzCb0UF4TEaWgDVSbYXDqQKqF8=;
        b=dXi6KmkMf3aejlvQMYz/pDOTqB1PkIYyOQKyKK1PFmWPx+4X0AHaoqz73pA9CNRh9ngEnE
        JNaHoIv2utZxT5Cg==
From:   "tip-bot2 for Zqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Free per CPU pool after CPU unplug
Cc:     Zqiang <qiang.zhang@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908062709.11441-1-qiang.zhang@windriver.com>
References: <20200908062709.11441-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Message-ID: <160156321691.7002.8346589408007234423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     88451f2cd3cec2abc30debdf129422d2699d1eba
Gitweb:        https://git.kernel.org/tip/88451f2cd3cec2abc30debdf129422d2699d1eba
Author:        Zqiang <qiang.zhang@windriver.com>
AuthorDate:    Tue, 08 Sep 2020 14:27:09 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Oct 2020 16:13:54 +02:00

debugobjects: Free per CPU pool after CPU unplug

If a CPU is offlined the debug objects per CPU pool is not cleaned up. If
the CPU is never onlined again then the objects in the pool are wasted.

Add a CPU hotplug callback which is invoked after the CPU is dead to free
the pool.

[ tglx: Massaged changelog and added comment about remote access safety ]

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20200908062709.11441-1-qiang.zhang@windriver.com

---
 include/linux/cpuhotplug.h |  1 +
 lib/debugobjects.c         | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bf9181c..6f524bb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -36,6 +36,7 @@ enum cpuhp_state {
 	CPUHP_X86_MCE_DEAD,
 	CPUHP_VIRT_NET_DEAD,
 	CPUHP_SLUB_DEAD,
+	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index e2a3171..9e14ae0 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
+#include <linux/cpu.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -433,6 +434,25 @@ static void free_object(struct debug_obj *obj)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int object_cpu_offline(unsigned int cpu)
+{
+	struct debug_percpu_free *percpu_pool;
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+
+	/* Remote access is safe as the CPU is dead already */
+	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
+	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
+	percpu_pool->obj_free = 0;
+
+	return 0;
+}
+#endif
+
 /*
  * We run out of memory. That means we probably have tons of objects
  * allocated.
@@ -1367,6 +1387,11 @@ void __init debug_objects_mem_init(void)
 	} else
 		debug_objects_selftest();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+					object_cpu_offline);
+#endif
+
 	/*
 	 * Increase the thresholds for allocating and freeing objects
 	 * according to the number of possible CPUs available in the system.
