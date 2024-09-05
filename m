Return-Path: <linux-tip-commits+bounces-2180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D096DD35
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788D628AAEC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7B1A0B12;
	Thu,  5 Sep 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iei9vxpU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBtfffER"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4119EEB1;
	Thu,  5 Sep 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548612; cv=none; b=l8/0T4e2Rl1flPXBQT5Ae7rpMwlzcDQQp/djGZnHjIeIg/ORqzORlDKaVwGkhCvMbuzb3CYbSH3J+DHZge9jm7Kfi7f+o6y+VYESP5qILeM13+8zSYaGRsQoSnQOo60IpaFqmmUrL3HK3AEff+cNWV5KyedTSAX3540V3s18mhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548612; c=relaxed/simple;
	bh=1lRCooeWKvs9Oge7+LCz9RXrFIlETCQBl5w2VR1lS/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RodXPZ5gqLQhhV3eTlp411gO7+HiAdBlf11qeVrONq9gOr2sd3yXG1lFuiNOvPZ/4qWtIM8VZhEyr0CjvTODP8EN715mXYifveeBJomFf53l26VeVqPeW8vxk4G1Kpt/Vsnsj09+4sGMvDKCNHK/bc7PkRXF08PF+jkY563KPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iei9vxpU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBtfffER; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qH0R3ZFNdH0U4/iiGMzYPlT2jM3Pp30a/enl1ndMp0=;
	b=iei9vxpUvRhBpVo3SasdJdHV31V9lfNbl2y1AGVMH/xCEIRoQpd+r99Pw7dyIKfWSkZc+i
	dTtZ9I9rirSXqYu1gPoL3cR06gs71UZiLxC6KvbeQQX899vYO5s6Fr7VpBWyuEP7S/iCeQ
	yTwg3PzI/wFTWxluxVr6pKddLAWDcoNFSi5u9ZFNp5dv4VXdjPI9ARBySbvYut+mJMcuQO
	O3oBqatvy/grZpc0pizLBhViNSJSWHpU6fi69Q1Li+0IwGPdWD0K746hAv/9V8k9FY73bi
	AsRNySpUOwyLCUwAQ0ULCjmZXAnW9GVthcqKXTeEwXb4nDTgF8CMdGRz6zjxRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qH0R3ZFNdH0U4/iiGMzYPlT2jM3Pp30a/enl1ndMp0=;
	b=kBtfffERGz7vaApxhn3zRQEZdaJzkc7VnA0W8DvsYtmuYsIo4rO2jLIilH2GZg8DUeQB6L
	TyzxyP+8Fm2DLhDQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: get rid of enum uprobe_filter_ctx in uprobe
 filter callbacks
Cc: Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-4-andrii@kernel.org>
References: <20240903174603.3554182-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860625.2215.1621517283211632123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59da880afed211c989ef65da577b24215ce57774
Gitweb:        https://git.kernel.org/tip/59da880afed211c989ef65da577b24215ce57774
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Tue, 03 Sep 2024 10:45:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:14 +02:00

uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks

It serves no purpose beyond adding unnecessray argument passed to the
filter callback. Just get rid of it, no one is actually using it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903174603.3554182-4-andrii@kernel.org
---
 include/linux/uprobes.h     | 10 +---------
 kernel/events/uprobes.c     | 18 +++++++-----------
 kernel/trace/bpf_trace.c    |  3 +--
 kernel/trace/trace_uprobe.c |  9 +++------
 4 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f50df1f..63ae2ad 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -28,20 +28,12 @@ struct page;
 
 #define MAX_URETPROBE_DEPTH		64
 
-enum uprobe_filter_ctx {
-	UPROBE_FILTER_REGISTER,
-	UPROBE_FILTER_UNREGISTER,
-	UPROBE_FILTER_MMAP,
-};
-
 struct uprobe_consumer {
 	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
 				struct pt_regs *regs);
-	bool (*filter)(struct uprobe_consumer *self,
-				enum uprobe_filter_ctx ctx,
-				struct mm_struct *mm);
+	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct uprobe_consumer *next;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d228d2b..87b499c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -918,21 +918,19 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	return ret;
 }
 
-static inline bool consumer_filter(struct uprobe_consumer *uc,
-				   enum uprobe_filter_ctx ctx, struct mm_struct *mm)
+static inline bool consumer_filter(struct uprobe_consumer *uc, struct mm_struct *mm)
 {
-	return !uc->filter || uc->filter(uc, ctx, mm);
+	return !uc->filter || uc->filter(uc, mm);
 }
 
-static bool filter_chain(struct uprobe *uprobe,
-			 enum uprobe_filter_ctx ctx, struct mm_struct *mm)
+static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	struct uprobe_consumer *uc;
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
-		ret = consumer_filter(uc, ctx, mm);
+		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
 	}
@@ -1099,12 +1097,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
-			if (consumer_filter(new,
-					UPROBE_FILTER_REGISTER, mm))
+			if (consumer_filter(new, mm))
 				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
-			if (!filter_chain(uprobe,
-					UPROBE_FILTER_UNREGISTER, mm))
+			if (!filter_chain(uprobe, mm))
 				err |= remove_breakpoint(uprobe, mm, info->vaddr);
 		}
 
@@ -1387,7 +1383,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	 */
 	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
 		if (!fatal_signal_pending(current) &&
-		    filter_chain(uprobe, UPROBE_FILTER_MMAP, vma->vm_mm)) {
+		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
 			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
 		}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 90cd30e..c99bf06 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3320,8 +3320,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 }
 
 static bool
-uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx,
-			 struct mm_struct *mm)
+uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 52e76a7..7eb79e0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1078,9 +1078,7 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	return trace_handle_return(s);
 }
 
-typedef bool (*filter_func_t)(struct uprobe_consumer *self,
-				enum uprobe_filter_ctx ctx,
-				struct mm_struct *mm);
+typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
@@ -1339,8 +1337,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 	return err;
 }
 
-static bool uprobe_perf_filter(struct uprobe_consumer *uc,
-				enum uprobe_filter_ctx ctx, struct mm_struct *mm)
+static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm)
 {
 	struct trace_uprobe_filter *filter;
 	struct trace_uprobe *tu;
@@ -1426,7 +1423,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 static int uprobe_perf_func(struct trace_uprobe *tu, struct pt_regs *regs,
 			    struct uprobe_cpu_buffer **ucbp)
 {
-	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
+	if (!uprobe_perf_filter(&tu->consumer, current->mm))
 		return UPROBE_HANDLER_REMOVE;
 
 	if (!is_ret_probe(tu))

