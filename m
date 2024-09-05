Return-Path: <linux-tip-commits+bounces-2177-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03296DD2F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C23287B16
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311A19E836;
	Thu,  5 Sep 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MDCJHKuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Q0QKslU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71C75809;
	Thu,  5 Sep 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548609; cv=none; b=cFA3yIAOUaNh/PcXvpK4NkSbHAcFgyVmwEBRHfpQQu9Nf7eO76Eko+jz4bMrRkXwCt46Qo98J/aHouq7KB231i1Cxw5xHoE/1jV/Lp0Le5aIhYKAksZZJCbbnd8mObX9ke3RdDuprt7WXl0HEpZ5qP10z9ZWI4gb/0F1NXK2xHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548609; c=relaxed/simple;
	bh=7U84JBZcFi+NgcY0Qlmuc0MFbS1Hu1rQ29+spD7XqJ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UlJZMCk4nxLEcVX+YnhepbwAdks3IDPKxh+l+tNkccJQqXM5bsQRzvYi39IaX4ykFkeK5WA9nthlu0durj+7lxKNBrpsQ2fwYnQpOpLK85eNAKThngFuyQcTfPPs9AtWJILS9O1tFUaaiPZwcvfbaNwT2qDJUP18ZW9+45TEXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MDCJHKuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Q0QKslU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCeCqTKf/Jgn1f9f8i5q0YVti1bIDumkDxP7ygt6asQ=;
	b=MDCJHKujkrvdYuLJUIvJWSBY5+4zK446PoERMXyoPUW44VJITOHZD5oHkhv4gehvEZA3BS
	0EYaV11h0C+iG9m0/aqF7QoeJ9Eyf4zLmGwYerVW7WUaphwqGZHsExjfM5alm++LuV+rXQ
	lIpdehiSrfOuplFoW369szygeP7aUavSwHJSZt1SX22kHRb+MKsreGcQICBQcHNCRh1DXP
	iQOu0llGmhqspBDvyhbJOj+ZL1Acim2pxq/zIJsueOF7/E9/7hrTN4RwRxjLdGiW+RKKWt
	EPEDoD12xUCVMeUFLuwfml3Z5HzjKyhOwsdzkkgZyyi++f2ThJ0dIqRHYhi1VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCeCqTKf/Jgn1f9f8i5q0YVti1bIDumkDxP7ygt6asQ=;
	b=7Q0QKslUeVUTZvbjVMsFdMbVJ5PDLmLanKjxYGWKsUEzLy43pxtUYOec0ll2rnpvFYuh6k
	h/vgsH7v60jaz6AA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/uprobe: split uprobe_unregister()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-6-andrii@kernel.org>
References: <20240903174603.3554182-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860505.2215.7893065703863996376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     04b01625da130c7521b768996cd5e48052198b97
Gitweb:        https://git.kernel.org/tip/04b01625da130c7521b768996cd5e48052198b97
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Sep 2024 10:46:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:14 +02:00

perf/uprobe: split uprobe_unregister()

With uprobe_unregister() having grown a synchronize_srcu(), it becomes
fairly slow to call. Esp. since both users of this API call it in a
loop.

Peel off the sync_srcu() and do it once, after the loop.

We also need to add uprobe_unregister_sync() into uprobe_register()'s
error handling path, as we need to be careful about returning to the
caller before we have a guarantee that partially attached consumer won't
be called anymore. This is an unlikely slow path and this should be
totally fine to be slow in the case of a failed attach.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903174603.3554182-6-andrii@kernel.org
---
 include/linux/uprobes.h                               |  8 +++-
 kernel/events/uprobes.c                               | 21 +++++++---
 kernel/trace/bpf_trace.c                              |  5 +-
 kernel/trace/trace_uprobe.c                           |  6 ++-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c |  3 +-
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f112b56..2b294bf 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,7 +115,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -164,7 +165,10 @@ uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+}
+static inline void uprobe_unregister_sync(void)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e15c030..694f679 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1105,11 +1105,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 }
 
 /**
- * uprobe_unregister - unregister an already registered probe.
+ * uprobe_unregister_nosync - unregister an already registered probe.
  * @uprobe: uprobe to remove
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
@@ -1121,12 +1121,15 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	/* TODO : cant unregister? schedule a worker thread */
 	if (unlikely(err)) {
 		uprobe_warn(current, "unregister, leaking uprobe");
-		goto out_sync;
+		return;
 	}
 
 	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
-out_sync:
+void uprobe_unregister_sync(void)
+{
 	/*
 	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
 	 * uprobe->consumers list under RCU protection without holding
@@ -1138,7 +1141,7 @@ out_sync:
 	 */
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /**
  * uprobe_register - register a probe
@@ -1196,7 +1199,13 @@ struct uprobe *uprobe_register(struct inode *inode,
 	up_write(&uprobe->register_rwsem);
 
 	if (ret) {
-		uprobe_unregister(uprobe, uc);
+		uprobe_unregister_nosync(uprobe, uc);
+		/*
+		 * Registration might have partially succeeded, so we can have
+		 * this consumer being called right at this time. We need to
+		 * sync here. It's ok, it's unlikely slow path.
+		 */
+		uprobe_unregister_sync();
 		return ERR_PTR(ret);
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c99bf06..ac0a01c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3184,7 +3184,10 @@ static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
 	u32 i;
 
 	for (i = 0; i < cnt; i++)
-		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
+		uprobe_unregister_nosync(uprobes[i].uprobe, &uprobes[i].consumer);
+
+	if (cnt)
+		uprobe_unregister_sync();
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 7eb79e0..f7443e9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1097,6 +1097,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
+	bool sync = false;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
@@ -1105,9 +1106,12 @@ static void __probe_event_disable(struct trace_probe *tp)
 		if (!tu->uprobe)
 			continue;
 
-		uprobe_unregister(tu->uprobe, &tu->consumer);
+		uprobe_unregister_nosync(tu->uprobe, &tu->consumer);
+		sync = true;
 		tu->uprobe = NULL;
 	}
+	if (sync)
+		uprobe_unregister_sync();
 }
 
 static int probe_event_enable(struct trace_event_call *call,
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 3c0515a..1fc1665 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -475,7 +475,8 @@ static void testmod_unregister_uprobe(void)
 	mutex_lock(&testmod_uprobe_mutex);
 
 	if (uprobe.uprobe) {
-		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
+		uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer);
+		uprobe_unregister_sync();
 		path_put(&uprobe.path);
 		uprobe.uprobe = NULL;
 	}

