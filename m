Return-Path: <linux-tip-commits+bounces-2416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DBE99F16D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425BC1F246FE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C01F6698;
	Tue, 15 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQkOOvh+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzgMjcdm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1A1F130D;
	Tue, 15 Oct 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006583; cv=none; b=oSc6kwl3oND5MNa2nx4D3dEES3SIlr7cBVFg4BMvWNLga966Fe10FpdWtKkSMUKWVN08yWgzpZ5vMbTraKvaCFUa3Cz4qjaRpK6n4zfWOJXtCYc6imRDpcfoUmoYO+fHOqSyXQywFKhgRPh1r1e8nM6h0VAsxNXzkrluAd2AFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006583; c=relaxed/simple;
	bh=jGeDU79BD9hNzb3P9kk7+TkVIyjgRGeD6NkZuFhPvpg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=boDIV8AO0SYSn3PbYS2kjeewlC1Z7HBcVPUOH9lJyfGrtKwCZ27N8ZAGqIC8bhZ+Zb9l1MzmV0p+MTjfM2ccz/JoUS5AUxAw6qEhmlp3NgRJn50GhDZD1so8vtjACf7Qzp90VCKBKuIrG2aZoDFlcyO12CPlPINAfGzs5NJ+PY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQkOOvh+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzgMjcdm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuELzk/YjeLb0za7G13KLY/xCDjQQJYDwGvVyLmKFiw=;
	b=oQkOOvh+JOMVu013w4gCI5sMmCnITc21haIwmPMD7w2rQTgSVA6nCED/slSPhCT+1d5BAn
	QLYjoEAYIY4Sb4A31TiXd7yswuxpDLPiFtRJF0Tb57HB6HzKsfe/DnQON25/LfDY3ynsF4
	Rl0S6wYrekmuQaUQ/eh+O2lnuSif+3v1K5OSvgbNvwpogiyqgiusIlAcMffL/2Cg3URhIv
	MA5v9VbOTtEZ30+wkMke8qcMg/yoHGTQpjBoolSVFKEy+af+FLNOqEPY7rKgzJxX9aUDZU
	xkS9r2uLK6n4DuuFg1hgtq/Omic8uhQtBpmIcLbjuwjwClqhWVUGL5QqvHAUaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuELzk/YjeLb0za7G13KLY/xCDjQQJYDwGvVyLmKFiw=;
	b=hzgMjcdmHgFgeiwSjDrIFqTYLb4/0fsU9k0B5Z1FPFv1Lh8kj+8bWckpasZPpM4wBQTckR
	29rJzIaBVpIQlLCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Use static key for boot pool selection
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.077247071@linutronix.de>
References: <20241007164914.077247071@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657890.1442.12329507555490681170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     14077b9e583bbafc9a02734beab99c37bff68644
Gitweb:        https://git.kernel.org/tip/14077b9e583bbafc9a02734beab99c37bff68644
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Use static key for boot pool selection

Get rid of the conditional in the hot path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.077247071@linutronix.de

---
 lib/debugobjects.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index d5a8538..65cce4c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -7,16 +7,16 @@
 
 #define pr_fmt(fmt) "ODEBUG: " fmt
 
+#include <linux/cpu.h>
 #include <linux/debugobjects.h>
-#include <linux/interrupt.h>
+#include <linux/debugfs.h>
+#include <linux/hash.h>
+#include <linux/kmemleak.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seq_file.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
-#include <linux/hash.h>
-#include <linux/kmemleak.h>
-#include <linux/cpu.h>
+#include <linux/static_key.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -103,6 +103,8 @@ static int __data_racy		debug_objects_freed;
 static void free_obj_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
 
+static DEFINE_STATIC_KEY_FALSE(obj_cache_enabled);
+
 static int __init enable_object_debug(char *str)
 {
 	debug_objects_enabled = true;
@@ -343,7 +345,7 @@ static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
 {
 	struct debug_obj *obj;
 
-	if (likely(obj_cache))
+	if (static_branch_likely(&obj_cache_enabled))
 		obj = pcpu_alloc();
 	else
 		obj = __alloc_object(&pool_boot);
@@ -393,7 +395,7 @@ static void free_obj_work(struct work_struct *work)
 static void __free_object(struct debug_obj *obj)
 {
 	guard(irqsave)();
-	if (likely(obj_cache))
+	if (static_branch_likely(&obj_cache_enabled))
 		pcpu_free(obj);
 	else
 		hlist_add_head(&obj->node, &pool_boot);
@@ -572,7 +574,7 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket 
 
 static void debug_objects_fill_pool(void)
 {
-	if (unlikely(!obj_cache))
+	if (!static_branch_likely(&obj_cache_enabled))
 		return;
 
 	if (likely(!pool_should_refill(&pool_global)))
@@ -1378,6 +1380,7 @@ void __init debug_objects_mem_init(void)
 
 	/* Everything worked. Expose the cache */
 	obj_cache = cache;
+	static_branch_enable(&obj_cache_enabled);
 
 #ifdef CONFIG_HOTPLUG_CPU
 	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,

