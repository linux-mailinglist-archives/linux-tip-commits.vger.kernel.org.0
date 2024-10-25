Return-Path: <linux-tip-commits+bounces-2544-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E19AFBD6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 10:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AF3284972
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2021C7B75;
	Fri, 25 Oct 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gkOD84iP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iuZm9OPI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1B18C029;
	Fri, 25 Oct 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843333; cv=none; b=p10uQkEfMZ8xuOsuOwk9FWFwpfyp0bf/gJDOrlmYRLFgFo6h4N2hbk8EmhVfQSXL5pmYaTBk/dTsXywSOsm1sM9APed30ni9AiKRc2ozxTGXZCyCKRqOAPLAuBgISqAX8xYdkC29zAtFV5we//mzAXoJPIa9F1/vkryEhzJwjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843333; c=relaxed/simple;
	bh=OTdykfAnmqAsT/OD1D3upFj447Q7+zoUpvcApYaI/is=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eLxZcsYDYIwzbgslJlB4PvgMt13DLxf6uYCHcu59+4VNSW3pzGrRXILFX/lwOXVBMJ6TcZ+TyfDAVWdlEA4RUE5AVr64sv8JpI4KfweLGRQotUvANCuMAUbimdK0hed4rEMZ0h6SiaaNX58l+5XtxXGt5hi58Hmtgkp38BcxUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gkOD84iP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iuZm9OPI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 08:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729843329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3xC1j2n88uKXTWmaIhK4xQI3K8Zm4T++b47yVdUnXk=;
	b=gkOD84iPJ2Cu/LCndv+uwhbia7aKNP1/re8fJPEj3eUFLPmftZ7wr/5i7HVMmmsDELoK9a
	s9K0vmPQo92lEvVRNdC6lPRdZO6pwZacLB4yPmS/YOWryB+5B+CTESn0EqBAeJa4K8dmvW
	E/+hBCqiZ0AtBtfLbzNXC/QhFhSa41wp8WdfbdnsOFiEbHvp0+StNDQ6+JK41+eXjTIhXF
	Mvr/Vp9Vt5b6js2SSq0Yuqv9DyRlH84AGyA1Vz04AVlzpbJGBGnqjV331LaYYALM2Q1n2M
	NDjhpN3W/GH1KzXkS5YK6KKICod1yaElu7hZdRTs9xJtn1oXTb2i7A7rQm7jBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729843329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3xC1j2n88uKXTWmaIhK4xQI3K8Zm4T++b47yVdUnXk=;
	b=iuZm9OPImtDNs7tbjg8xf46YRYsOTx3REjqubMKcclwyQCXkw84ssiiR6QoWwTHaekc17S
	de8BGpZEQrU2GHBg==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobe: Add data pointer to consumer handlers
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241018202252.693462-2-jolsa@kernel.org>
References: <20241018202252.693462-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172984332874.1442.14818317926082324163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da09a9e0c3eab164af950be44ee6bdea8527c3e5
Gitweb:        https://git.kernel.org/tip/da09a9e0c3eab164af950be44ee6bdea8527c3e5
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 18 Oct 2024 22:22:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Oct 2024 20:52:27 +02:00

uprobe: Add data pointer to consumer handlers

Adding data pointer to both entry and exit consumer handlers and all
its users. The functionality itself is coming in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20241018202252.693462-2-jolsa@kernel.org
---
 include/linux/uprobes.h                               |  4 +--
 kernel/events/uprobes.c                               |  4 +--
 kernel/trace/bpf_trace.c                              |  6 +++--
 kernel/trace/trace_uprobe.c                           | 12 ++++++----
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2b294bf..bb265a6 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -37,10 +37,10 @@ struct uprobe_consumer {
 	 * for the current process. If filter() is omitted or returns true,
 	 * UPROBE_HANDLER_REMOVE is effectively ignored.
 	 */
-	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
+	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
-				struct pt_regs *regs);
+				struct pt_regs *regs, __u64 *data);
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct list_head cons_node;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2a00594..6b44c38 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2090,7 +2090,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
+			rc = uc->handler(uc, regs, NULL);
 			WARN(rc & ~UPROBE_HANDLER_MASK,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
@@ -2128,7 +2128,7 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+			uc->ret_handler(uc, ri->func, regs, NULL);
 	}
 	rcu_read_unlock_trace();
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd2..fdab7ec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3244,7 +3244,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 }
 
 static int
-uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
+			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
@@ -3253,7 +3254,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int
-uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
+uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
+			      __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c40531d..5895eab 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -89,9 +89,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs);
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data);
 
 #ifdef CONFIG_STACK_GROWSUP
 static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
@@ -1517,7 +1519,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 	}
 }
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     __u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
@@ -1548,7 +1551,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs)
+				unsigned long func, struct pt_regs *regs,
+				__u64 *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8835761..12005e3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -461,7 +461,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 
 static int
 uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
-		   struct pt_regs *regs)
+		   struct pt_regs *regs, __u64 *data)
 
 {
 	regs->ax  = 0x12345678deadbeef;

