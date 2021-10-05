Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B128D422A56
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhJEON5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhJEONv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:51 -0400
Date:   Tue, 05 Oct 2021 14:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvqCmnSP+s6gd8HZngeCRNoxHYcNhIJxJ4S4RNPeyZQ=;
        b=vYTzMGmr7Ww61wSDULObkuAxE/Z3jPzb2Sec7a9w3NAmiRb4y9yMgiP9LZ4MLRO+Y5z03a
        Gw3zxunR1J4VUBPQ93w3sVx7lsz1JAlGrvZsMvji5zmM+R/VZ7mELVf5ffZitkWpUHPV65
        CFaAuGfjBDwEzky4/eanu0P/4b2rXU18LAwu8IdznAqeYltC86HxgTTEPyM4KmG7VWU+K8
        uRXsv2mzr8vYQUsTWjS/ZoTX0FAIRPo3FGE39qdjjw7HZDRZl3nWexaEI1JcCOqzrqAnsU
        k5DKzHsa2jraFEsyrXRbnAmjEfME0E8na9KB4kvWBjAtU25BIevegxHI7ALjWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvqCmnSP+s6gd8HZngeCRNoxHYcNhIJxJ4S4RNPeyZQ=;
        b=Gfwx5fiFPfwKrWfag+1FSB7ApUFtfCvYf/yxCv7PNL2H23oMUI4CD4lM9iC8cXKaPEM+P/
        zEjbPq9HxTJoeoBA==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make cookie functions static
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
References: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163344311944.25758.11773100900688304106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d07b2eee4501c393cbf5bfcad36143310cfd72f9
Gitweb:        https://git.kernel.org/tip/d07b2eee4501c393cbf5bfcad36143310cfd72f9
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Wed, 22 Sep 2021 16:57:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:07 +02:00

sched: Make cookie functions static

Make cookie functions static as these are no longer invoked directly
by other code.

No functional change intended.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210922085735.52812-1-zhangshaokun@hisilicon.com
---
 kernel/sched/core_sched.c |  9 +++++----
 kernel/sched/sched.h      |  5 -----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9a80e9a..48ac726 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -11,7 +11,7 @@ struct sched_core_cookie {
 	refcount_t refcnt;
 };
 
-unsigned long sched_core_alloc_cookie(void)
+static unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
@@ -23,7 +23,7 @@ unsigned long sched_core_alloc_cookie(void)
 	return (unsigned long)ck;
 }
 
-void sched_core_put_cookie(unsigned long cookie)
+static void sched_core_put_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -33,7 +33,7 @@ void sched_core_put_cookie(unsigned long cookie)
 	}
 }
 
-unsigned long sched_core_get_cookie(unsigned long cookie)
+static unsigned long sched_core_get_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -53,7 +53,8 @@ unsigned long sched_core_get_cookie(unsigned long cookie)
  *
  * Returns: the old cookie
  */
-unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+static unsigned long sched_core_update_cookie(struct task_struct *p,
+					      unsigned long cookie)
 {
 	unsigned long old_cookie;
 	struct rq_flags rf;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e5c4d4d..a00fc70 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1258,11 +1258,6 @@ extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
-extern unsigned long sched_core_alloc_cookie(void);
-extern void sched_core_put_cookie(unsigned long cookie);
-extern unsigned long sched_core_get_cookie(unsigned long cookie);
-extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
-
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
