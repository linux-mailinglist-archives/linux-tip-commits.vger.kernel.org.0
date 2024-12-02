Return-Path: <linux-tip-commits+bounces-2898-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD79DFFEC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D7B27D09
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC871FDE32;
	Mon,  2 Dec 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PprAYotv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ATdEelw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C81FDE1D;
	Mon,  2 Dec 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138054; cv=none; b=oHS7A3m0e5rY+RPgLI8BxjZGFvuUB+sH/weqIdypotSgkNNZWDTi7YYyQ0UiQUpJGGybsUx8c0l6Dr+Wcx66Jgd3uLXPYcCZ5/VCK+ph399Wae4/VApCz+SMrINDzntVVX4UFRGm9iCf7sHuqmAd8IHqS4KtxQGstYPaX9aZwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138054; c=relaxed/simple;
	bh=aC4gv9LFdAIY2rGIq8AETgI+PjO8g77BcvzLFwQuTdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S8VrjLMBBMtV89EIKCU/+NKuW+oPf1d/j97j2hI3z9wTCirLFB1NwwjQ/ERlgMJpjwNrFjFqbooMhpXGtYhvp/vlW8ToKIh5y0au/tw5kSnw/4c2BUxkOjOE4KBlgOZp7ZcKwTWMPDEdC7+Cus2CW3vtHucZClEXC7YITPP74TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PprAYotv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ATdEelw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5qKxeqR9rjPDCzSJbwHbsdytosWufphrcr2lGL4L78=;
	b=PprAYotvkghNezIXzjoNS/V3nlPvNj+PRfSeyWOb+dHigBhesUGE4CkvkvfpjyJnHDUWu8
	JHQjxqubI9ILk+RqaRZN8J1shxzMMd497s1S0j/WiukQguniGuIQw+/2xe5FaFWLip5tXZ
	F/uAf1QXUD3Ug6IoPm+4cX0XfCtzvu70ZZqpjzyxCEvgSw9WFYeQqeL0pPbWd/wwnHkBhU
	WtvYhfwTRZC75CvOUSyaTIGdxCD+15xPKc3qOcqRssFq/s90w9aRUFew/75NDkJJkRcQEy
	/45O2V6/GtoSWD7QhipkjihupMdBsqV2p612RONTu7fvmr5s7sJfr1p0VxCyZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5qKxeqR9rjPDCzSJbwHbsdytosWufphrcr2lGL4L78=;
	b=4ATdEelwL3Y/3CLEdx8Uib0fVeGwWuxXtqtL460QPaCm97+xXz83CV10ok1sLf8AKy6P7w
	VTsJpnf5e+09aDBg==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Cc: Matthew Wilcox <willy@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241122035922.3321100-3-andrii@kernel.org>
References: <20241122035922.3321100-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313804816.412.16764384544456207666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e0925f2dc4de2d8ba987392d3239e8edf88f8b96
Gitweb:        https://git.kernel.org/tip/e0925f2dc4de2d8ba987392d3239e8edf88=
f8b96
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 21 Nov 2024 19:59:22 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:38 +01:00

uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution

Given filp_cachep is marked SLAB_TYPESAFE_BY_RCU (and FMODE_BACKING
files, a special case, now goes through RCU-delated freeing), we can
safely access vma->vm_file->f_inode field locklessly under just
rcu_read_lock() protection, which enables looking up uprobe from
uprobes_tree completely locklessly and speculatively without the need to
acquire mmap_lock for reads. In most cases, anyway, assuming that there
are no parallel mm and/or VMA modifications. The underlying struct
file's memory won't go away from under us (even if struct file can be
reused in the meantime).

We rely on newly added mmap_lock_speculate_{try_begin,retry}() helpers to
validate that mm_struct stays intact for entire duration of this
speculation. If not, we fall back to mmap_lock-protected lookup.
The speculative logic is written in such a way that it will safely
handle any garbage values that might be read from vma or file structs.

Benchmarking results speak for themselves.

BEFORE (latest tip/perf/core)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.384 =C2=B1 0.004M/s  (  3.384M/s/cpu)
uprobe-nop            ( 2 cpus):    5.456 =C2=B1 0.005M/s  (  2.728M/s/cpu)
uprobe-nop            ( 3 cpus):    7.863 =C2=B1 0.015M/s  (  2.621M/s/cpu)
uprobe-nop            ( 4 cpus):    9.442 =C2=B1 0.008M/s  (  2.360M/s/cpu)
uprobe-nop            ( 5 cpus):   11.036 =C2=B1 0.013M/s  (  2.207M/s/cpu)
uprobe-nop            ( 6 cpus):   10.884 =C2=B1 0.019M/s  (  1.814M/s/cpu)
uprobe-nop            ( 7 cpus):    7.897 =C2=B1 0.145M/s  (  1.128M/s/cpu)
uprobe-nop            ( 8 cpus):   10.021 =C2=B1 0.128M/s  (  1.253M/s/cpu)
uprobe-nop            (10 cpus):    9.932 =C2=B1 0.170M/s  (  0.993M/s/cpu)
uprobe-nop            (12 cpus):    8.369 =C2=B1 0.056M/s  (  0.697M/s/cpu)
uprobe-nop            (14 cpus):    8.678 =C2=B1 0.017M/s  (  0.620M/s/cpu)
uprobe-nop            (16 cpus):    7.392 =C2=B1 0.003M/s  (  0.462M/s/cpu)
uprobe-nop            (24 cpus):    5.326 =C2=B1 0.178M/s  (  0.222M/s/cpu)
uprobe-nop            (32 cpus):    5.426 =C2=B1 0.059M/s  (  0.170M/s/cpu)
uprobe-nop            (40 cpus):    5.262 =C2=B1 0.070M/s  (  0.132M/s/cpu)
uprobe-nop            (48 cpus):    6.121 =C2=B1 0.010M/s  (  0.128M/s/cpu)
uprobe-nop            (56 cpus):    6.252 =C2=B1 0.035M/s  (  0.112M/s/cpu)
uprobe-nop            (64 cpus):    7.644 =C2=B1 0.023M/s  (  0.119M/s/cpu)
uprobe-nop            (72 cpus):    7.781 =C2=B1 0.001M/s  (  0.108M/s/cpu)
uprobe-nop            (80 cpus):    8.992 =C2=B1 0.048M/s  (  0.112M/s/cpu)

AFTER
=3D=3D=3D=3D=3D
uprobe-nop            ( 1 cpus):    3.534 =C2=B1 0.033M/s  (  3.534M/s/cpu)
uprobe-nop            ( 2 cpus):    6.701 =C2=B1 0.007M/s  (  3.351M/s/cpu)
uprobe-nop            ( 3 cpus):   10.031 =C2=B1 0.007M/s  (  3.344M/s/cpu)
uprobe-nop            ( 4 cpus):   13.003 =C2=B1 0.012M/s  (  3.251M/s/cpu)
uprobe-nop            ( 5 cpus):   16.274 =C2=B1 0.006M/s  (  3.255M/s/cpu)
uprobe-nop            ( 6 cpus):   19.563 =C2=B1 0.024M/s  (  3.261M/s/cpu)
uprobe-nop            ( 7 cpus):   22.696 =C2=B1 0.054M/s  (  3.242M/s/cpu)
uprobe-nop            ( 8 cpus):   24.534 =C2=B1 0.010M/s  (  3.067M/s/cpu)
uprobe-nop            (10 cpus):   30.475 =C2=B1 0.117M/s  (  3.047M/s/cpu)
uprobe-nop            (12 cpus):   33.371 =C2=B1 0.017M/s  (  2.781M/s/cpu)
uprobe-nop            (14 cpus):   38.864 =C2=B1 0.004M/s  (  2.776M/s/cpu)
uprobe-nop            (16 cpus):   41.476 =C2=B1 0.020M/s  (  2.592M/s/cpu)
uprobe-nop            (24 cpus):   64.696 =C2=B1 0.021M/s  (  2.696M/s/cpu)
uprobe-nop            (32 cpus):   85.054 =C2=B1 0.027M/s  (  2.658M/s/cpu)
uprobe-nop            (40 cpus):  101.979 =C2=B1 0.032M/s  (  2.549M/s/cpu)
uprobe-nop            (48 cpus):  110.518 =C2=B1 0.056M/s  (  2.302M/s/cpu)
uprobe-nop            (56 cpus):  117.737 =C2=B1 0.020M/s  (  2.102M/s/cpu)
uprobe-nop            (64 cpus):  124.613 =C2=B1 0.079M/s  (  1.947M/s/cpu)
uprobe-nop            (72 cpus):  133.239 =C2=B1 0.032M/s  (  1.851M/s/cpu)
uprobe-nop            (80 cpus):  142.037 =C2=B1 0.138M/s  (  1.775M/s/cpu)

Previously total throughput was maxing out at 11mln/s, and gradually
declining past 8 cores. With this change, it now keeps growing with each
added CPU, reaching 142mln/s at 80 CPUs (this was measured on a 80-core
Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz).

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/20241122035922.3321100-3-andrii@kernel.org
---
 kernel/events/uprobes.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 62c14df..daf4314 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2294,6 +2294,47 @@ static int is_trap_at_addr(struct mm_struct *mm, unsig=
ned long vaddr)
 	return is_trap_insn(&opcode);
 }
=20
+static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct uprobe *uprobe =3D NULL;
+	struct vm_area_struct *vma;
+	struct file *vm_file;
+	loff_t offset;
+	unsigned int seq;
+
+	guard(rcu)();
+
+	if (!mmap_lock_speculate_try_begin(mm, &seq))
+		return NULL;
+
+	vma =3D vma_lookup(mm, bp_vaddr);
+	if (!vma)
+		return NULL;
+
+	/*
+	 * vm_file memory can be reused for another instance of struct file,
+	 * but can't be freed from under us, so it's safe to read fields from
+	 * it, even if the values are some garbage values; ultimately
+	 * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
+	 * that whatever we speculatively found is correct
+	 */
+	vm_file =3D READ_ONCE(vma->vm_file);
+	if (!vm_file)
+		return NULL;
+
+	offset =3D (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vma->vm_star=
t);
+	uprobe =3D find_uprobe_rcu(vm_file->f_inode, offset);
+	if (!uprobe)
+		return NULL;
+
+	/* now double check that nothing about MM changed */
+	if (mmap_lock_speculate_retry(mm, seq))
+		return NULL;
+
+	return uprobe;
+}
+
 /* assumes being inside RCU protected region */
 static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is=
_swbp)
 {
@@ -2301,6 +2342,10 @@ static struct uprobe *find_active_uprobe_rcu(unsigned =
long bp_vaddr, int *is_swb
 	struct uprobe *uprobe =3D NULL;
 	struct vm_area_struct *vma;
=20
+	uprobe =3D find_active_uprobe_speculative(bp_vaddr);
+	if (uprobe)
+		return uprobe;
+
 	mmap_read_lock(mm);
 	vma =3D vma_lookup(mm, bp_vaddr);
 	if (vma) {

