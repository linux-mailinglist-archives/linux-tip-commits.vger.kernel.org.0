Return-Path: <linux-tip-commits+bounces-6365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A1B33CBF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FA205268
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4214E2E8DE4;
	Mon, 25 Aug 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GF9dsFAl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G20at4ib"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF162E7BDA;
	Mon, 25 Aug 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117505; cv=none; b=JMpHG7sSyAHG7hZAo4ZB9ut7bL9T86ij2B9I1H6EMkYnwWy4Hf2N9ZXQNHCjR9MY+m4lFVsXyXAJsyVgH+EYYLw5MKDyMNQ878rCdES359AvlxgSGLE5sQLderO7Tbr9fEJZURfFbErF3B0+dpz4ia4PVvRRmjEG8RwtV63AIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117505; c=relaxed/simple;
	bh=5Jd8aZ+SbX42e2G56lkhFyMdUeOMfgTL9WJNPaGzhjM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mET89JJyFZIXoHH0oRCCmUqCZClY7pjCXLS0A62kMXg41BifFAQF1b/ZzRIbu6BDH89ECDcXNm0kxzC0cRskMNKWnSDyFM/OQb0bcqA4pubymgoxyNIxrDb/FC0gWqlFHazXxadfwq41JsYnUGlyfxhOVFAA6jhYZegvkQ2G1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GF9dsFAl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G20at4ib; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AV/eyyOCblIXYbw5pfJ1ttx2bjtlLeWouA370c7lTeQ=;
	b=GF9dsFAlg4/MHa6mJiH9odmCwx+uqaS6v1FWn+4uFvkL4Z+mPwlGM08mg2tBX8fnI+A3g2
	kL3UZa/Vlsy+dTpZrimmFU3BEXsvagQHJhdi5mw2VrxqdMR93rVfxo+ibTzOF94eIzc2vT
	L5hE7i1urS7WoabcfMPfgNKmOKZw3VnlW70wrrLa4Xhi59S85gEZ/0KC19g/S2IP8EiUh0
	fsEi7BGgwILmODciePbtlZa39jJTpkx6PVYyacxj1EerVakKzvVTMPFIzfU9KZn2Pa2of/
	rgdmfYVfviweS5zmvA923P0VmEL7DBqWroQsv8BSWKoL7HZnJ/XR9LvKzjpNlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AV/eyyOCblIXYbw5pfJ1ttx2bjtlLeWouA370c7lTeQ=;
	b=G20at4ibx6PBd/c9qn2C1TwGivDfLIj2RrhTjuZLErqr971YIziCNmRSYYQz+jolyaJL3y
	4oOqFGXVOUQxz6Cw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes/x86: Add mapping for optimized uprobe trampolines
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-9-jolsa@kernel.org>
References: <20250720112133.244369-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750061.1420.7805680351516263419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     91440ff4cafad4c86322a612e523f7f021a493e7
Gitweb:        https://git.kernel.org/tip/91440ff4cafad4c86322a612e523f7f021a=
493e7
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:20 +02:00

uprobes/x86: Add mapping for optimized uprobe trampolines

Adding support to add special mapping for user space trampoline with
following functions:

  uprobe_trampoline_get - find or add uprobe_trampoline
  uprobe_trampoline_put - remove or destroy uprobe_trampoline

The user space trampoline is exported as arch specific user space special
mapping through tramp_mapping, which is initialized in following changes
with new uprobe syscall.

The uprobe trampoline needs to be callable/reachable from the probed address,
so while searching for available address we use is_reachable_by_call function
to decide if the uprobe trampoline is callable from the probe address.

All uprobe_trampoline objects are stored in uprobes_state object and are
cleaned up when the process mm_struct goes down. Adding new arch hooks
for that, because this change is x86_64 specific.

Locking is provided by callers in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-9-jolsa@kernel.org
---
 arch/x86/kernel/uprobes.c | 144 +++++++++++++++++++++++++++++++++++++-
 include/linux/uprobes.h   |   6 ++-
 kernel/events/uprobes.c   |  10 +++-
 kernel/fork.c             |   1 +-
 4 files changed, 161 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 77050e5..6c4dcbd 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -608,6 +608,150 @@ static void riprel_post_xol(struct arch_uprobe *auprobe=
, struct pt_regs *regs)
 		*sr =3D utask->autask.saved_scratch_register;
 	}
 }
+
+static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_=
struct *new_vma)
+{
+	return -EPERM;
+}
+
+static struct page *tramp_mapping_pages[2] __ro_after_init;
+
+static struct vm_special_mapping tramp_mapping =3D {
+	.name   =3D "[uprobes-trampoline]",
+	.mremap =3D tramp_mremap,
+	.pages  =3D tramp_mapping_pages,
+};
+
+struct uprobe_trampoline {
+	struct hlist_node	node;
+	unsigned long		vaddr;
+};
+
+static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
+{
+	long delta =3D (long)(vaddr + 5 - vtramp);
+
+	return delta >=3D INT_MIN && delta <=3D INT_MAX;
+}
+
+static unsigned long find_nearest_trampoline(unsigned long vaddr)
+{
+	struct vm_unmapped_area_info info =3D {
+		.length     =3D PAGE_SIZE,
+		.align_mask =3D ~PAGE_MASK,
+	};
+	unsigned long low_limit, high_limit;
+	unsigned long low_tramp, high_tramp;
+	unsigned long call_end =3D vaddr + 5;
+
+	if (check_add_overflow(call_end, INT_MIN, &low_limit))
+		low_limit =3D PAGE_SIZE;
+
+	high_limit =3D call_end + INT_MAX;
+
+	/* Search up from the caller address. */
+	info.low_limit =3D call_end;
+	info.high_limit =3D min(high_limit, TASK_SIZE);
+	high_tramp =3D vm_unmapped_area(&info);
+
+	/* Search down from the caller address. */
+	info.low_limit =3D max(low_limit, PAGE_SIZE);
+	info.high_limit =3D call_end;
+	info.flags =3D VM_UNMAPPED_AREA_TOPDOWN;
+	low_tramp =3D vm_unmapped_area(&info);
+
+	if (IS_ERR_VALUE(high_tramp) && IS_ERR_VALUE(low_tramp))
+		return -ENOMEM;
+	if (IS_ERR_VALUE(high_tramp))
+		return low_tramp;
+	if (IS_ERR_VALUE(low_tramp))
+		return high_tramp;
+
+	/* Return address that's closest to the caller address. */
+	if (call_end - low_tramp < high_tramp - call_end)
+		return low_tramp;
+	return high_tramp;
+}
+
+static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vadd=
r)
+{
+	struct pt_regs *regs =3D task_pt_regs(current);
+	struct mm_struct *mm =3D current->mm;
+	struct uprobe_trampoline *tramp;
+	struct vm_area_struct *vma;
+
+	if (!user_64bit_mode(regs))
+		return NULL;
+
+	vaddr =3D find_nearest_trampoline(vaddr);
+	if (IS_ERR_VALUE(vaddr))
+		return NULL;
+
+	tramp =3D kzalloc(sizeof(*tramp), GFP_KERNEL);
+	if (unlikely(!tramp))
+		return NULL;
+
+	tramp->vaddr =3D vaddr;
+	vma =3D _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				&tramp_mapping);
+	if (IS_ERR(vma)) {
+		kfree(tramp);
+		return NULL;
+	}
+	return tramp;
+}
+
+__maybe_unused
+static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, =
bool *new)
+{
+	struct uprobes_state *state =3D &current->mm->uprobes_state;
+	struct uprobe_trampoline *tramp =3D NULL;
+
+	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
+		return NULL;
+
+	hlist_for_each_entry(tramp, &state->head_tramps, node) {
+		if (is_reachable_by_call(tramp->vaddr, vaddr)) {
+			*new =3D false;
+			return tramp;
+		}
+	}
+
+	tramp =3D create_uprobe_trampoline(vaddr);
+	if (!tramp)
+		return NULL;
+
+	*new =3D true;
+	hlist_add_head(&tramp->node, &state->head_tramps);
+	return tramp;
+}
+
+static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
+{
+	/*
+	 * We do not unmap and release uprobe trampoline page itself,
+	 * because there's no easy way to make sure none of the threads
+	 * is still inside the trampoline.
+	 */
+	hlist_del(&tramp->node);
+	kfree(tramp);
+}
+
+void arch_uprobe_init_state(struct mm_struct *mm)
+{
+	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
+}
+
+void arch_uprobe_clear_state(struct mm_struct *mm)
+{
+	struct uprobes_state *state =3D &mm->uprobes_state;
+	struct uprobe_trampoline *tramp;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
+		destroy_uprobe_trampoline(tramp);
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 5080619..b40d33a 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -17,6 +17,7 @@
 #include <linux/wait.h>
 #include <linux/timer.h>
 #include <linux/seqlock.h>
+#include <linux/mutex.h>
=20
 struct uprobe;
 struct vm_area_struct;
@@ -185,6 +186,9 @@ struct xol_area;
=20
 struct uprobes_state {
 	struct xol_area		*xol_area;
+#ifdef CONFIG_X86_64
+	struct hlist_head	head_tramps;
+#endif
 };
=20
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
@@ -233,6 +237,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs=
);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, vo=
id *dst, int len);
+extern void arch_uprobe_clear_state(struct mm_struct *mm);
+extern void arch_uprobe_init_state(struct mm_struct *mm);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index da2b3d0..2cd7a4c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1801,6 +1801,14 @@ static struct xol_area *get_xol_area(void)
 	return area;
 }
=20
+void __weak arch_uprobe_clear_state(struct mm_struct *mm)
+{
+}
+
+void __weak arch_uprobe_init_state(struct mm_struct *mm)
+{
+}
+
 /*
  * uprobe_clear_state - Free the area allocated for slots.
  */
@@ -1812,6 +1820,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
=20
+	arch_uprobe_clear_state(mm);
+
 	if (!area)
 		return;
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index af67385..d827cc6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1015,6 +1015,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area =3D NULL;
+	arch_uprobe_init_state(mm);
 #endif
 }
=20

