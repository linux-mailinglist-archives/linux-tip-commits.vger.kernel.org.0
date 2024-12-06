Return-Path: <linux-tip-commits+bounces-2988-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892A9E6A82
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD71886B43
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F4E1F9AB6;
	Fri,  6 Dec 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ncx6ol9y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbtD60A0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C431DF980;
	Fri,  6 Dec 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477918; cv=none; b=ZbpclUNnWrNnZh0cgb1a33SdkCXkh+ZMuL+/gZ2r3JXdE14aEb2Vz74eCL75w/c56lY5jm3enSltwCkJybzEZWsPtKg8ROPpcV2xKv2N7e/bfeO1YEjiG4np3apEsIx6KLVZcY4eMAilvcDoXshYXKD8r1WGlA9phFx/jP/UvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477918; c=relaxed/simple;
	bh=Xn0Cxv2yj2h+iexFetvih0MGVcFn3Cl0EaLuWNz1t18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UquLCxNgYQnnKpMYFBgZxlSUKmMYZUgmowACXawW3JKRo7XzkWoo/jgt/U1+f88lbo7myfPUwr4Lct66W9MMOT5Uq7JrEjPRFKQwRXuqNcD4yv2EAfLwmYjSNp5oDTiTZf1o2u1QFtTd+z0E4+yaroXtTwFf+C9tXUm8BoR/2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ncx6ol9y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbtD60A0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 09:38:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733477914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdzC+tIBd9Y8fjjoEuOHmFl588EUxvZ96XFPl8Sv77U=;
	b=ncx6ol9yJ8+3etaeFHsU+7G03LyvO36oGtbVeoqeWGlVr/85huyWTG6xCXlkoBnrupT1pv
	rKmy17+9A55RJukRdlc30sLTrK02oqknJXzcPqFi1VS6Ap2+GF2HOVkmmb/DWiwhJtgmYC
	TkJIGgITaHafokf1xK7z9wr3HHaNNu2eW6vzL8ljBlr+kzrwuNV5c50UAdB4s4d3dqTM88
	vq15uOtvHbFqbzZZWYUen6YI5tY8MQYcKqPDMKjmmSqZJ7fHxPslbeOzssyus1frirX4M0
	iUGnABoHgTFjj+jON6cd1T3ALZFIFvGz9ckARu++6g8EGfOM34qFRcsGrk4zAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733477914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdzC+tIBd9Y8fjjoEuOHmFl588EUxvZ96XFPl8Sv77U=;
	b=SbtD60A0eo8dGRFxjMKVSekTd/m4A5jtFygbO5wpVwB1WyxhPgO0YcNnOH807FDzOt0MI4
	k9GXHdMdlUvGZ0Bw==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Decouple return_instance list traversal and freeing
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206002417.3295533-3-andrii@kernel.org>
References: <20241206002417.3295533-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173347791315.412.1668780366015175567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fa288f5cfc18bbbe3232d9bacde92acbdb72334f
Gitweb:        https://git.kernel.org/tip/fa288f5cfc18bbbe3232d9bacde92acbdb72334f
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 16:24:15 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 09:52:01 +01:00

uprobes: Decouple return_instance list traversal and freeing

free_ret_instance() has two unrelated responsibilities: actually
cleaning up return_instance's resources and freeing memory, and also
helping with utask->return_instances list traversal by returning the
next alive pointer.

There is no reason why these two aspects have to be mixed together, so
turn free_ret_instance() into void-returning function and make callers
do list traversal on their own.

We'll use this simplification in the next patch that will guarantee that
to-be-freed return_instance isn't reachable from utask->return_instances
list.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20241206002417.3295533-3-andrii@kernel.org
---
 kernel/events/uprobes.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6beac52..cca1fe4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1888,10 +1888,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-static struct return_instance *free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
+static void free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
 {
-	struct return_instance *next = ri->next;
-
 	if (cleanup_hprobe) {
 		enum hprobe_state hstate;
 
@@ -1901,7 +1899,6 @@ static struct return_instance *free_ret_instance(struct return_instance *ri, boo
 
 	kfree(ri->extra_consumers);
 	kfree_rcu(ri, rcu);
-	return next;
 }
 
 /*
@@ -1911,7 +1908,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri, boo
 void uprobe_free_utask(struct task_struct *t)
 {
 	struct uprobe_task *utask = t->utask;
-	struct return_instance *ri;
+	struct return_instance *ri, *ri_next;
 
 	if (!utask)
 		return;
@@ -1921,8 +1918,11 @@ void uprobe_free_utask(struct task_struct *t)
 	timer_delete_sync(&utask->ri_timer);
 
 	ri = utask->return_instances;
-	while (ri)
-		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
+	while (ri) {
+		ri_next = ri->next;
+		free_ret_instance(ri, true /* cleanup_hprobe */);
+		ri = ri_next;
+	}
 
 	kfree(utask);
 	t->utask = NULL;
@@ -2111,12 +2111,15 @@ unsigned long uprobe_get_trampoline_vaddr(void)
 static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 					struct pt_regs *regs)
 {
-	struct return_instance *ri = utask->return_instances;
+	struct return_instance *ri = utask->return_instances, *ri_next;
 	enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
 
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
-		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
+		ri_next = ri->next;
 		utask->depth--;
+
+		free_ret_instance(ri, true /* cleanup_hprobe */);
+		ri = ri_next;
 	}
 	rcu_assign_pointer(utask->return_instances, ri);
 }
@@ -2508,7 +2511,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
 void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
-	struct return_instance *ri, *next;
+	struct return_instance *ri, *ri_next, *next_chain;
 	struct uprobe *uprobe;
 	enum hprobe_state hstate;
 	bool valid;
@@ -2528,8 +2531,8 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 		 * or NULL; the latter case means that nobody but ri->func
 		 * could hit this trampoline on return. TODO: sigaltstack().
 		 */
-		next = find_next_ret_chain(ri);
-		valid = !next || arch_uretprobe_is_alive(next, RP_CHECK_RET, regs);
+		next_chain = find_next_ret_chain(ri);
+		valid = !next_chain || arch_uretprobe_is_alive(next_chain, RP_CHECK_RET, regs);
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
 		do {
@@ -2541,7 +2544,9 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			 * trampoline addresses on the stack are replaced with correct
 			 * original return addresses
 			 */
-			rcu_assign_pointer(utask->return_instances, ri->next);
+			ri_next = ri->next;
+			rcu_assign_pointer(utask->return_instances, ri_next);
+			utask->depth--;
 
 			uprobe = hprobe_consume(&ri->hprobe, &hstate);
 			if (valid)
@@ -2549,9 +2554,9 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			hprobe_finalize(&ri->hprobe, hstate);
 
 			/* We already took care of hprobe, no need to waste more time on that. */
-			ri = free_ret_instance(ri, false /* !cleanup_hprobe */);
-			utask->depth--;
-		} while (ri != next);
+			free_ret_instance(ri, false /* !cleanup_hprobe */);
+			ri = ri_next;
+		} while (ri != next_chain);
 	} while (!valid);
 
 	return;

