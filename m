Return-Path: <linux-tip-commits+bounces-7794-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD0BCF49D1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6920F3078DBF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666033A71D;
	Mon,  5 Jan 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JfrbEd56";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GPBCSWK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B833A9F5;
	Mon,  5 Jan 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628463; cv=none; b=M2t5/56WqUl852SvxsbLLV8TDEQo+aEW53XforMg1qimHAXE98TBU6lMups0QDe15OI/dNc33ww7qZlacnsy8O7IvFWRZJHbNgaWbN6yjZ/78WNJ66DWkI/HAEJWOKMRqyFA7ham8mmAAI+XarLF9/0Ji8GuHuUsudfh//BHH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628463; c=relaxed/simple;
	bh=k8QwWm/5zWYQEMSJ2EAKYfIvtq636faF9aBYb8lluas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HgSlvilSOp1LnxXDUPtiud0PaFyZbN4dOFpxEQYq2Rf3e1jmio0w3VqLW3YhSDAyrKYRGTkq/oAzTIGI9PcoeUXLYVl0Yupz3MfaXnIK6Q3QNZlwF4SCAWGpEzlRBpUR/n1L195/A3bF61mdQBn0KF1SSVm/T1PM33yKBeYMMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JfrbEd56; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GPBCSWK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4vwU+TfweVC/WP1RCILhX7PLIftxJ9Td4OtwrP2sWw=;
	b=JfrbEd56z0HvQak+dMMhmkiEVmiVcNRzjx7OCJ3Upi2+tcP3bEpQDOpKmG5a0xHQu5T5dg
	mpYQt5usuQYxW1+oIJJZv0ySGHOymFnDry77iyo9P70e67eJ7+WmCEiJmCk/V1yx4MXJwb
	7KvxsxPiFIA0KZp/tsWdcLQcIAnP8Q54cIWLoja0eCg90A+Z9lav2eG1mfT0NfZqpkCDF/
	2Ek57bkPduviENkqdxu/TmgEGBP79agftp1nHrQN/Lo/ev6CetdtRmQPV6d+xByhH3uoEi
	XuoQaQLOApCplNg7J/wbjaxuH5v5LXFWAhBnM9ykgh0CFIiCIBNjRo5vYqs2mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4vwU+TfweVC/WP1RCILhX7PLIftxJ9Td4OtwrP2sWw=;
	b=4GPBCSWKAfQ2RJv8H7fYvKQYsGZRItV9qT9iHkfAo+Mpx8BRf9dTDFhmclj16TOjASwOJ+
	9UInaXGSqzX7zMDg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kfence: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-29-elver@google.com>
References: <20251219154418.3592607-29-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845862.510.9590247050620583118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f5d764862aa7f50d77b8ea2b4f75a48a630487a
Gitweb:        https://git.kernel.org/tip/0f5d764862aa7f50d77b8ea2b4f75a48a63=
0487a
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:34 +01:00

kfence: Enable context analysis

Enable context analysis for the KFENCE subsystem.

Notable, kfence_handle_page_fault() required minor restructure, which
also fixed a subtle race; arguably that function is more readable now.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-29-elver@google.com
---
 mm/kfence/Makefile |  2 ++
 mm/kfence/core.c   | 20 +++++++++++++-------
 mm/kfence/kfence.h | 14 ++++++++------
 mm/kfence/report.c |  4 ++--
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/mm/kfence/Makefile b/mm/kfence/Makefile
index 2de2a58..a503e83 100644
--- a/mm/kfence/Makefile
+++ b/mm/kfence/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-y :=3D core.o report.o
=20
 CFLAGS_kfence_test.o :=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 577a169..ebf442f 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -133,8 +133,8 @@ struct kfence_metadata *kfence_metadata __read_mostly;
 static struct kfence_metadata *kfence_metadata_init __read_mostly;
=20
 /* Freelist with available objects. */
-static struct list_head kfence_freelist =3D LIST_HEAD_INIT(kfence_freelist);
-static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freelis=
t. */
+DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freelist. */
+static struct list_head kfence_freelist __guarded_by(&kfence_freelist_lock) =
=3D LIST_HEAD_INIT(kfence_freelist);
=20
 /*
  * The static key to set up a KFENCE allocation; or if static keys are not u=
sed
@@ -254,6 +254,7 @@ static bool kfence_unprotect(unsigned long addr)
 }
=20
 static inline unsigned long metadata_to_pageaddr(const struct kfence_metadat=
a *meta)
+	__must_hold(&meta->lock)
 {
 	unsigned long offset =3D (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
 	unsigned long pageaddr =3D (unsigned long)&__kfence_pool[offset];
@@ -289,6 +290,7 @@ static inline bool kfence_obj_allocated(const struct kfen=
ce_metadata *meta)
 static noinline void
 metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state=
 next,
 		      unsigned long *stack_entries, size_t num_stack_entries)
+	__must_hold(&meta->lock)
 {
 	struct kfence_track *track =3D
 		next =3D=3D KFENCE_OBJECT_ALLOCATED ? &meta->alloc_track : &meta->free_tra=
ck;
@@ -486,7 +488,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cach=
e, size_t size, gfp_t g
 	alloc_covered_add(alloc_stack_hash, 1);
=20
 	/* Set required slab fields. */
-	slab =3D virt_to_slab((void *)meta->addr);
+	slab =3D virt_to_slab(addr);
 	slab->slab_cache =3D cache;
 	slab->objects =3D 1;
=20
@@ -515,6 +517,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cach=
e, size_t size, gfp_t g
 static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bo=
ol zombie)
 {
 	struct kcsan_scoped_access assert_page_exclusive;
+	u32 alloc_stack_hash;
 	unsigned long flags;
 	bool init;
=20
@@ -547,9 +550,10 @@ static void kfence_guarded_free(void *addr, struct kfenc=
e_metadata *meta, bool z
 	/* Mark the object as freed. */
 	metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
 	init =3D slab_want_init_on_free(meta->cache);
+	alloc_stack_hash =3D meta->alloc_stack_hash;
 	raw_spin_unlock_irqrestore(&meta->lock, flags);
=20
-	alloc_covered_add(meta->alloc_stack_hash, -1);
+	alloc_covered_add(alloc_stack_hash, -1);
=20
 	/* Check canary bytes for memory corruption. */
 	check_canary(meta);
@@ -594,6 +598,7 @@ static void rcu_guarded_free(struct rcu_head *h)
  * which partial initialization succeeded.
  */
 static unsigned long kfence_init_pool(void)
+	__context_unsafe(/* constructor */)
 {
 	unsigned long addr, start_pfn;
 	int i;
@@ -1220,6 +1225,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool =
is_write, struct pt_regs=20
 {
 	const int page_index =3D (addr - (unsigned long)__kfence_pool) / PAGE_SIZE;
 	struct kfence_metadata *to_report =3D NULL;
+	unsigned long unprotected_page =3D 0;
 	enum kfence_error_type error_type;
 	unsigned long flags;
=20
@@ -1253,9 +1259,8 @@ bool kfence_handle_page_fault(unsigned long addr, bool =
is_write, struct pt_regs=20
 		if (!to_report)
 			goto out;
=20
-		raw_spin_lock_irqsave(&to_report->lock, flags);
-		to_report->unprotected_page =3D addr;
 		error_type =3D KFENCE_ERROR_OOB;
+		unprotected_page =3D addr;
=20
 		/*
 		 * If the object was freed before we took the look we can still
@@ -1267,7 +1272,6 @@ bool kfence_handle_page_fault(unsigned long addr, bool =
is_write, struct pt_regs=20
 		if (!to_report)
 			goto out;
=20
-		raw_spin_lock_irqsave(&to_report->lock, flags);
 		error_type =3D KFENCE_ERROR_UAF;
 		/*
 		 * We may race with __kfence_alloc(), and it is possible that a
@@ -1279,6 +1283,8 @@ bool kfence_handle_page_fault(unsigned long addr, bool =
is_write, struct pt_regs=20
=20
 out:
 	if (to_report) {
+		raw_spin_lock_irqsave(&to_report->lock, flags);
+		to_report->unprotected_page =3D unprotected_page;
 		kfence_report_error(addr, is_write, regs, to_report, error_type);
 		raw_spin_unlock_irqrestore(&to_report->lock, flags);
 	} else {
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index dfba5ea..f9caea0 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -34,6 +34,8 @@
 /* Maximum stack depth for reports. */
 #define KFENCE_STACK_DEPTH 64
=20
+extern raw_spinlock_t kfence_freelist_lock;
+
 /* KFENCE object states. */
 enum kfence_object_state {
 	KFENCE_OBJECT_UNUSED,		/* Object is unused. */
@@ -53,7 +55,7 @@ struct kfence_track {
=20
 /* KFENCE metadata per guarded allocation. */
 struct kfence_metadata {
-	struct list_head list;		/* Freelist node; access under kfence_freelist_lock=
. */
+	struct list_head list __guarded_by(&kfence_freelist_lock);	/* Freelist node=
. */
 	struct rcu_head rcu_head;	/* For delayed freeing. */
=20
 	/*
@@ -91,13 +93,13 @@ struct kfence_metadata {
 	 * In case of an invalid access, the page that was unprotected; we
 	 * optimistically only store one address.
 	 */
-	unsigned long unprotected_page;
+	unsigned long unprotected_page __guarded_by(&lock);
=20
 	/* Allocation and free stack information. */
-	struct kfence_track alloc_track;
-	struct kfence_track free_track;
+	struct kfence_track alloc_track __guarded_by(&lock);
+	struct kfence_track free_track __guarded_by(&lock);
 	/* For updating alloc_covered on frees. */
-	u32 alloc_stack_hash;
+	u32 alloc_stack_hash __guarded_by(&lock);
 #ifdef CONFIG_MEMCG
 	struct slabobj_ext obj_exts;
 #endif
@@ -141,6 +143,6 @@ enum kfence_error_type {
 void kfence_report_error(unsigned long address, bool is_write, struct pt_reg=
s *regs,
 			 const struct kfence_metadata *meta, enum kfence_error_type type);
=20
-void kfence_print_object(struct seq_file *seq, const struct kfence_metadata =
*meta);
+void kfence_print_object(struct seq_file *seq, const struct kfence_metadata =
*meta) __must_hold(&meta->lock);
=20
 #endif /* MM_KFENCE_KFENCE_H */
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 10e6802..787e87c 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -106,6 +106,7 @@ found:
=20
 static void kfence_print_stack(struct seq_file *seq, const struct kfence_met=
adata *meta,
 			       bool show_alloc)
+	__must_hold(&meta->lock)
 {
 	const struct kfence_track *track =3D show_alloc ? &meta->alloc_track : &met=
a->free_track;
 	u64 ts_sec =3D track->ts_nsec;
@@ -207,8 +208,6 @@ void kfence_report_error(unsigned long address, bool is_w=
rite, struct pt_regs *r
 	if (WARN_ON(type !=3D KFENCE_ERROR_INVALID && !meta))
 		return;
=20
-	if (meta)
-		lockdep_assert_held(&meta->lock);
 	/*
 	 * Because we may generate reports in printk-unfriendly parts of the
 	 * kernel, such as scheduler code, the use of printk() could deadlock.
@@ -263,6 +262,7 @@ void kfence_report_error(unsigned long address, bool is_w=
rite, struct pt_regs *r
 	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr, 0);
=20
 	if (meta) {
+		lockdep_assert_held(&meta->lock);
 		pr_err("\n");
 		kfence_print_object(NULL, meta);
 	}

