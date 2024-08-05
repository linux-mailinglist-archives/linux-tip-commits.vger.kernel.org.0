Return-Path: <linux-tip-commits+bounces-1935-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CBB947AB7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F0A1C20FCF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115F156F4D;
	Mon,  5 Aug 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/M3uQZR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l5hN4Xh+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7615666F;
	Mon,  5 Aug 2024 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858968; cv=none; b=HXGSCZbmLR8e/2FyuAF43//kA+bZ81D2FAzH7C7L7czJGFVofKiMy/OPu6Po74PJYyFPO9ohDvhljhVPBzarsW/NzxfhMSUHrnjA906dnZVsKkRtA5haTXh5aTSRPRC480ZI4JxOZScf3IHnylZKZ1bf7GyZJWTsNnwxBYblJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858968; c=relaxed/simple;
	bh=FsfWmnX6pJf05eJrn+fKgfBTovmE1QWcVuRKJ89Vbd8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RmyHqk8SmwpATyLaP1VzIhfLGBNo2lVnQ15yct3ho+83+pOdnsC4GH6xmUJxOrB4mAVWZaoa4kbJtyi3MM8n3/ZtOyybKpsikZqw2ovtPFU8XVOyck68GEMRvv2hnnuWsEEtezjFPRt3bomlWFCVI5lJgF0xYO7qnD0E9HJcT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/M3uQZR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l5hN4Xh+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cgd6kzXUiympU0SO15Nx4v49mI/JJF4DTNdkpNfpOg=;
	b=B/M3uQZRoTA8iXJTYbO6kGhNZFIGEw+UGwWouEO5fODE4bw8OHYoj4nwM7MPD/lkjhZCp1
	RNWVjEDV/Lxgp0+xs3j5PvQc71WAibKX0bfv1+q/aEi05cJ85tHQbvYCDycuTYvJlrWJ45
	TG9qKoQsxENUaPWuyn5T06pAbInSWotShHvQzYeVNHJHpCa73mhRAaLUVDD8Bhy5UhIiK0
	tZ02LrpAX2//iq4GPKcN+CQIopUXZ3aiOIso8+c7uK2I5rkGD1ZfAyi3Nyi2GIVpuE5lyp
	Oo2MMvSZ2ERZmlajppxY/XGCRFJjEGamSaJHvyayjuWs2+WF1R796tHgVLMjwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cgd6kzXUiympU0SO15Nx4v49mI/JJF4DTNdkpNfpOg=;
	b=l5hN4Xh+MsNvkOh48qZnnJlTqUhczCG5q0adkzp0Q+qaKlLCdBGGNv5/bYzUvDwpxzgXXj
	pviHqvOfXDGV9NDw==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: kill uprobe_register_refctr()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801132728.GA8800@redhat.com>
References: <20240801132728.GA8800@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896397.2215.15070932815443961684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e04332ebc8ac128fa551e83f1161ab1c094d13a9
Gitweb:        https://git.kernel.org/tip/e04332ebc8ac128fa551e83f1161ab1c094d13a9
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:31 +02:00

uprobes: kill uprobe_register_refctr()

It doesn't make any sense to have 2 versions of _register(). Note that
trace_uprobe_enable(), the only user of uprobe_register(), doesn't need
to check tu->ref_ctr_offset to decide which one should be used, it could
safely pass ref_ctr_offset == 0 to uprobe_register_refctr().

Add this argument to uprobe_register(), update the callers, and kill
uprobe_register_refctr().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240801132728.GA8800@redhat.com
---
 include/linux/uprobes.h                               |  9 +----
 kernel/events/uprobes.c                               | 24 ++--------
 kernel/trace/bpf_trace.c                              |  8 +--
 kernel/trace/trace_uprobe.c                           |  7 +---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c |  4 +-
 5 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a270a58..788813c 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -112,8 +112,7 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
-extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
-extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
+extern int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
@@ -154,11 +153,7 @@ static inline void uprobes_init(void)
 #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
 
 static inline int
-uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
-{
-	return -ENOSYS;
-}
-static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
 	return -ENOSYS;
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e9b092a..3a80154 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1121,25 +1121,26 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
 /*
- * __uprobe_register - register a probe
+ * uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
+ * @ref_ctr_offset: offset of SDT marker / reference counter
  * @uc: information on howto handle the probe..
  *
- * Apart from the access refcount, __uprobe_register() takes a creation
+ * Apart from the access refcount, uprobe_register() takes a creation
  * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
  * inserted into the rbtree (i.e first consumer for a @inode:@offset
  * tuple).  Creation refcount stops uprobe_unregister from freeing the
  * @uprobe even before the register operation is complete. Creation
  * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of __uprobe_register() is required to keep @inode
+ * unregisters. Caller of uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
  */
-static int __uprobe_register(struct inode *inode, loff_t offset,
-			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
+		    struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -1189,21 +1190,8 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		goto retry;
 	return ret;
 }
-
-int uprobe_register(struct inode *inode, loff_t offset,
-		    struct uprobe_consumer *uc)
-{
-	return __uprobe_register(inode, offset, 0, uc);
-}
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-int uprobe_register_refctr(struct inode *inode, loff_t offset,
-			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
-{
-	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
-}
-EXPORT_SYMBOL_GPL(uprobe_register_refctr);
-
 /*
  * uprobe_apply - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd09884..afa909e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3480,10 +3480,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		      &bpf_uprobe_multi_link_lops, prog);
 
 	for (i = 0; i < cnt; i++) {
-		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
-					     uprobes[i].offset,
-					     uprobes[i].ref_ctr_offset,
-					     &uprobes[i].consumer);
+		err = uprobe_register(d_real_inode(link->path.dentry),
+				      uprobes[i].offset,
+				      uprobes[i].ref_ctr_offset,
+				      &uprobes[i].consumer);
 		if (err) {
 			bpf_uprobe_unregister(&path, uprobes, i);
 			goto error_free;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3..1f590f9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1089,12 +1089,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 	tu->consumer.filter = filter;
 	tu->inode = d_real_inode(tu->path.dentry);
 
-	if (tu->ref_ctr_offset)
-		ret = uprobe_register_refctr(tu->inode, tu->offset,
-				tu->ref_ctr_offset, &tu->consumer);
-	else
-		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
-
+	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
 	if (ret)
 		tu->inode = NULL;
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 72f565a..55f6905 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -458,8 +458,8 @@ static int testmod_register_uprobe(loff_t offset)
 	if (err)
 		goto out;
 
-	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
-				     offset, 0, &uprobe.consumer);
+	err = uprobe_register(d_real_inode(uprobe.path.dentry),
+			      offset, 0, &uprobe.consumer);
 	if (err)
 		path_put(&uprobe.path);
 	else

