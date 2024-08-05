Return-Path: <linux-tip-commits+bounces-1933-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26F947AB3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C437228197D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C9156980;
	Mon,  5 Aug 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkzTdfvH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bttwZSUN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CC1514C9;
	Mon,  5 Aug 2024 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858967; cv=none; b=p2Wz4jc6AmDXSNETda93pTuZiLQZMqFeKQfSsdpMNM2EMpCSPIKw48PO607DRoZYdPepjTcJArU/hbgXHAKmn9d2I8qX9Td4db00YVAt6SbuU4tQlq2yP/wN64LjVqsdJqhw/xDlwexIWREgCde6UTCPaT8BkKMdcAjDS6RuZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858967; c=relaxed/simple;
	bh=NJdjxo4kllSrJfVrlxDdsMt5OsrnYxG+f93s5C3V18M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iu5KChBTcPSTFdpTCgXHm+5W4Nf/MWBImt8wxlZ7OEonyEQc8NxVWIrlnsA9FYNL29RPl9Y443CKopn/wQxCYKrvbem88g9KZsSw5PG/anjzlgo0ZlN/jK6Odscpp0lJsMQTgTICX9tEskH+cIvi4vVfrXk0XdzF+H1WBhR7lH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkzTdfvH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bttwZSUN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTNNYhX262A+Abcz+Iu/j5r2pDvBdxUJOXkK++PFhmE=;
	b=pkzTdfvH8gZdbvbfc2tNk0flSzNMO09j37vyDu7ji+isxUVB5qtnk3i+n2W7UQfEtRZYdn
	KdljBhDpkBEDuA8FSlvq4V3gEj99sHY1kYAEWe2LsKrpjyyBCRAE0ZiWyeRyljRQgG099w
	CdMt4iWvjQdVjeb4BBBKXINc0KqJt5BKg/0xrCvXP/NSxwS7FB9D9WY2jb7IizP9fvJinx
	aH7mTEAei83d/8/8LSzLI34UZ042l3wE3CIm+KY4PmrIzxwTDEVYKc54XdaiybDB8Vvfl/
	UxHBOHYEjowfbKfGzPouTQHOaZLFRykRJVwo6TUXUjm28OeyAwN/OIAyRozAbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTNNYhX262A+Abcz+Iu/j5r2pDvBdxUJOXkK++PFhmE=;
	b=bttwZSUNzYb2g0IVSSy5l0sdcZYSPi1jSkZTrGcq9gOaNo+bxDXADipaI4rHPgHZnLRa3i
	QRA8fde02/UfYrDQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: make uprobe_register() return struct uprobe *
Cc: Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240801132734.GA8803@redhat.com>
References: <20240801132734.GA8803@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896351.2215.4781163316519966086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3c83a9ad0295eb63bdeb81d821b8c3b9417fbcac
Gitweb:        https://git.kernel.org/tip/3c83a9ad0295eb63bdeb81d821b8c3b9417fbcac
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:31 +02:00

uprobes: make uprobe_register() return struct uprobe *

This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
rather than inode + offset. This simplifies the code and allows to avoid
the unnecessary find_uprobe() + put_uprobe() in these functions.

TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure that
this uprobe can't be freed before up_write(&uprobe->register_rwsem).

Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20240801132734.GA8803@redhat.com
---
 include/linux/uprobes.h                               | 15 +--
 kernel/events/uprobes.c                               | 56 +++-------
 kernel/trace/bpf_trace.c                              | 25 +---
 kernel/trace/trace_uprobe.c                           | 26 ++---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 25 +---
 5 files changed, 67 insertions(+), 80 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 788813c..f50df1f 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
+struct uprobe;
 struct vm_area_struct;
 struct mm_struct;
 struct inode;
@@ -112,9 +113,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
-extern int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
-extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
+extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
+extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -152,18 +153,18 @@ static inline void uprobes_init(void)
 
 #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
 
-static inline int
+static inline struct uprobe *
 uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
-	return -ENOSYS;
+	return ERR_PTR(-ENOSYS);
 }
 static inline int
-uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
+uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
 {
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3a80154..b33f139 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1099,20 +1099,14 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		delete_uprobe(uprobe);
 }
 
-/*
+/**
  * uprobe_unregister - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
+ * @uprobe: uprobe to remove
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
-	struct uprobe *uprobe;
-
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return;
-
+	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
 	__uprobe_unregister(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
@@ -1120,7 +1114,7 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
-/*
+/**
  * uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
@@ -1136,40 +1130,40 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
  * unregisters. Caller of uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
- * Return errno if it cannot successully install probes
- * else return 0 (success)
+ * Return: pointer to the new uprobe on success or an ERR_PTR on failure.
  */
-int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
-		    struct uprobe_consumer *uc)
+struct uprobe *uprobe_register(struct inode *inode,
+				loff_t offset, loff_t ref_ctr_offset,
+				struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
 
 	/* Uprobe must have at least one set consumer */
 	if (!uc->handler && !uc->ret_handler)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
 	if (!inode->i_mapping->a_ops->read_folio &&
 	    !shmem_mapping(inode->i_mapping))
-		return -EIO;
+		return ERR_PTR(-EIO);
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * This ensures that copy_from_page(), copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
  retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (IS_ERR(uprobe))
-		return PTR_ERR(uprobe);
+		return uprobe;
 
 	/*
 	 * We can race with uprobe_unregister()->delete_uprobe().
@@ -1188,35 +1182,29 @@ int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
 
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
-	return ret;
+
+	return ret ? ERR_PTR(ret) : uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-/*
- * uprobe_apply - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
+/**
+ * uprobe_apply - add or remove the breakpoints according to @uc->filter
+ * @uprobe: uprobe which "owns" the breakpoint
  * @uc: consumer which wants to add more or remove some breakpoints
  * @add: add or remove the breakpoints
+ * Return: 0 on success or negative error code.
  */
-int uprobe_apply(struct inode *inode, loff_t offset,
-			struct uprobe_consumer *uc, bool add)
+int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 {
-	struct uprobe *uprobe;
 	struct uprobe_consumer *con;
 	int ret = -ENOENT;
 
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return ret;
-
 	down_write(&uprobe->register_rwsem);
 	for (con = uprobe->consumers; con && con != uc ; con = con->next)
 		;
 	if (con)
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 
 	return ret;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index afa909e..4e391da 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3160,6 +3160,7 @@ struct bpf_uprobe {
 	loff_t offset;
 	unsigned long ref_ctr_offset;
 	u64 cookie;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -3178,15 +3179,12 @@ struct bpf_uprobe_multi_run_ctx {
 	struct bpf_uprobe *uprobe;
 };
 
-static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
-				  u32 cnt)
+static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
 {
 	u32 i;
 
-	for (i = 0; i < cnt; i++) {
-		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
-				  &uprobes[i].consumer);
-	}
+	for (i = 0; i < cnt; i++)
+		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
@@ -3194,7 +3192,7 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 	struct bpf_uprobe_multi_link *umulti_link;
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
-	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	bpf_uprobe_unregister(umulti_link->uprobes, umulti_link->cnt);
 	if (umulti_link->task)
 		put_task_struct(umulti_link->task);
 	path_put(&umulti_link->path);
@@ -3480,12 +3478,13 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		      &bpf_uprobe_multi_link_lops, prog);
 
 	for (i = 0; i < cnt; i++) {
-		err = uprobe_register(d_real_inode(link->path.dentry),
-				      uprobes[i].offset,
-				      uprobes[i].ref_ctr_offset,
-				      &uprobes[i].consumer);
-		if (err) {
-			bpf_uprobe_unregister(&path, uprobes, i);
+		uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
+						    uprobes[i].offset,
+						    uprobes[i].ref_ctr_offset,
+						    &uprobes[i].consumer);
+		if (IS_ERR(uprobes[i].uprobe)) {
+			err = PTR_ERR(uprobes[i].uprobe);
+			bpf_uprobe_unregister(uprobes, i);
 			goto error_free;
 		}
 	}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1f590f9..52e76a7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -58,8 +58,8 @@ struct trace_uprobe {
 	struct dyn_event		devent;
 	struct uprobe_consumer		consumer;
 	struct path			path;
-	struct inode			*inode;
 	char				*filename;
+	struct uprobe			*uprobe;
 	unsigned long			offset;
 	unsigned long			ref_ctr_offset;
 	unsigned long			nhit;
@@ -1084,16 +1084,16 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 
 static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
-	int ret;
+	struct inode *inode = d_real_inode(tu->path.dentry);
+	struct uprobe *uprobe;
 
 	tu->consumer.filter = filter;
-	tu->inode = d_real_inode(tu->path.dentry);
-
-	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
-	if (ret)
-		tu->inode = NULL;
+	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
 
-	return ret;
+	tu->uprobe = uprobe;
+	return 0;
 }
 
 static void __probe_event_disable(struct trace_probe *tp)
@@ -1104,11 +1104,11 @@ static void __probe_event_disable(struct trace_probe *tp)
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		if (!tu->inode)
+		if (!tu->uprobe)
 			continue;
 
-		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
-		tu->inode = NULL;
+		uprobe_unregister(tu->uprobe, &tu->consumer);
+		tu->uprobe = NULL;
 	}
 }
 
@@ -1305,7 +1305,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
+		ret = uprobe_apply(tu->uprobe, &tu->consumer, false);
 		if (ret)
 			break;
 	}
@@ -1329,7 +1329,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
+		err = uprobe_apply(tu->uprobe, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
 			break;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 55f6905..3c0515a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -432,7 +432,7 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 
 struct testmod_uprobe {
 	struct path path;
-	loff_t offset;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -446,25 +446,25 @@ static int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		return -EBUSY;
 
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		goto out;
 
 	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
 	if (err)
 		goto out;
 
-	err = uprobe_register(d_real_inode(uprobe.path.dentry),
-			      offset, 0, &uprobe.consumer);
-	if (err)
+	uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
+					offset, 0, &uprobe.consumer);
+	if (IS_ERR(uprobe.uprobe)) {
+		err = PTR_ERR(uprobe.uprobe);
 		path_put(&uprobe.path);
-	else
-		uprobe.offset = offset;
-
+		uprobe.uprobe = NULL;
+	}
 out:
 	mutex_unlock(&testmod_uprobe_mutex);
 	return err;
@@ -474,11 +474,10 @@ static void testmod_unregister_uprobe(void)
 {
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset) {
-		uprobe_unregister(d_real_inode(uprobe.path.dentry),
-				  uprobe.offset, &uprobe.consumer);
+	if (uprobe.uprobe) {
+		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
 		path_put(&uprobe.path);
-		uprobe.offset = 0;
+		uprobe.uprobe = NULL;
 	}
 
 	mutex_unlock(&testmod_uprobe_mutex);

