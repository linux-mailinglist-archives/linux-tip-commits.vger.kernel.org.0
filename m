Return-Path: <linux-tip-commits+bounces-4886-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E7A85921
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B3F7B9789
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39A274716;
	Fri, 11 Apr 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u4SniE30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sju37sXu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC8272F84;
	Fri, 11 Apr 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365746; cv=none; b=bS3jjwqlm35s2MwsGHOawNHFeKbJ9WfqseTGE5jmM6Dd994nlLtAFtaYZ2x6wfs9u9eAYvOkxMFcGOBHIUCBaNFeM7hiyUBlyUKVMlfmvyUB0vywuwLjNODtlOIFN3Dnbj4JDfTesa4884iolYXIpL9Fruzvkbb8iYghXgxEFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365746; c=relaxed/simple;
	bh=3EI7RVm3E4Cwu9jD8fthGTz5HJd369zihOfh2jj7Lls=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kM1r7dKkvXlSks2JPb8sUi63w6FIro+1YZaUUJE+QeAM7cyYOGo6egDQbZo+GT0XvN3MLef69qFbf+sJ3OKhusS+zF95rCcaXGHE3Ffh4IGkEMTvD4CzXDVc3tK5Sr9oNWjKD88TK3pmvSTs+DKxN4K9emWTLLK+G2u4CXkadYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u4SniE30; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sju37sXu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfSJs3NEn09Rg5yMWrHkDB6oSjkcGzo4qsE10+aXtTs=;
	b=u4SniE30pCGhVswfU5xVNR2wAqyRqWY0FyhrkUm4MLozttNvk+21Vmtk37DB0VQgEoxDX1
	5ZoRSQtxJlbfBXFQeOmCJLiotmWJvLdHjVWFszfPRzDP3nFOfZTKaC645kG5JEwwIzwN0B
	5vN2Hatgj0MR8quJOERT8qkEDQ9nDu45HI2g3qD+06euzVaFAW7erGbaNVgyygsn5mTY2h
	ffP748QemGVP6v1bTVCb55/2bsx4PszCBtikJT6Kd3a7GMjf0acGBhlf1LJ3cNIrgYkxzr
	I+lkf19J5Xub8ksFsbsHPYbyxmFKldyzYruTocpZ82y6kNF+zxi0EPYL8dhbHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfSJs3NEn09Rg5yMWrHkDB6oSjkcGzo4qsE10+aXtTs=;
	b=sju37sXuzn9ndPkGi8lW3zi05bGvKdMo06gMuXC9BHEbLFCSq1XhBPKSdBqO6C188tpwT6
	Dq99YyEYf0mttvDQ==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Improve code-patching
 scalability by removing false sharing in poke_int3_handler()
Cc: Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>,
 Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-2-mingo@kernel.org>
References: <20250411054105.2341982-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436574204.31282.3287557599806306109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     4334336e769bea1351ab82b22b06118c81bd217f
Gitweb:        https://git.kernel.org/tip/4334336e769bea1351ab82b22b06118c81bd217f
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Fri, 11 Apr 2025 07:40:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Improve code-patching scalability by removing false sharing in poke_int3_handler()

eBPF programs can be run 50,000,000 times per second on busy servers.

Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
hundreds of calls sites are patched from text_poke_bp_batch()
and we see a huge loss of performance due to false sharing
on bp_desc.refs lasting up to three seconds.

   51.30%  server_bin       [kernel.kallsyms]           [k] poke_int3_handler
            |
            |--46.45%--poke_int3_handler
            |          exc_int3
            |          asm_exc_int3
            |          |
            |          |--24.26%--cls_bpf_classify
            |          |          tcf_classify
            |          |          __dev_queue_xmit
            |          |          ip6_finish_output2
            |          |          ip6_output
            |          |          ip6_xmit
            |          |          inet6_csk_xmit
            |          |          __tcp_transmit_skb

Fix this by replacing bp_desc.refs with a per-cpu bp_refs.

Before the patch, on a host with 240 cores (480 threads):

  $ sysctl -wq kernel.bpf_stats_enabled=0

  text_poke_bp_batch(nr_entries=164) : Took 2655300 usec

  $ bpftool prog | grep run_time_ns
  ...
  105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
  3009063719 run_cnt 82757845 : average cost is 36 nsec per call

After this patch:

  $ sysctl -wq kernel.bpf_stats_enabled=0

  text_poke_bp_batch(nr_entries=164) : Took 702 usec

  $ bpftool prog | grep run_time_ns
  ...
  105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
  1928223019 run_cnt 67682728 : average cost is 28 nsec per call

Ie. text-patching performance improved 3700x: from 2.65 seconds
to 0.0007 seconds.

Since the atomic_cond_read_acquire(refs, !VAL) spin-loop was not triggered
even once in my tests, add an unlikely() annotation, because this appears
to be the common case.

[ mingo: Improved the changelog some more. ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250411054105.2341982-2-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index bf82c6f..85089c7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2474,28 +2474,29 @@ struct text_poke_loc {
 struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
-	atomic_t refs;
 };
 
+static DEFINE_PER_CPU(atomic_t, bp_refs);
+
 static struct bp_patching_desc bp_desc;
 
 static __always_inline
 struct bp_patching_desc *try_get_desc(void)
 {
-	struct bp_patching_desc *desc = &bp_desc;
+	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
-	if (!raw_atomic_inc_not_zero(&desc->refs))
+	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
 
-	return desc;
+	return &bp_desc;
 }
 
 static __always_inline void put_desc(void)
 {
-	struct bp_patching_desc *desc = &bp_desc;
+	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
 	smp_mb__before_atomic();
-	raw_atomic_dec(&desc->refs);
+	raw_atomic_dec(refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
@@ -2528,9 +2529,9 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_desc with non-zero refcount:
 	 *
-	 *	bp_desc.refs = 1		INT3
-	 *	WMB				RMB
-	 *	write INT3			if (bp_desc.refs != 0)
+	 *	bp_refs = 1		INT3
+	 *	WMB			RMB
+	 *	write INT3		if (bp_refs != 0)
 	 */
 	smp_rmb();
 
@@ -2636,7 +2637,8 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Corresponds to the implicit memory barrier in try_get_desc() to
 	 * ensure reading a non-zero refcount provides up to date bp_desc data.
 	 */
-	atomic_set_release(&bp_desc.refs, 1);
+	for_each_possible_cpu(i)
+		atomic_set_release(per_cpu_ptr(&bp_refs, i), 1);
 
 	/*
 	 * Function tracing can enable thousands of places that need to be
@@ -2750,8 +2752,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * Remove and wait for refs to be zero.
 	 */
-	if (!atomic_dec_and_test(&bp_desc.refs))
-		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
+	for_each_possible_cpu(i) {
+		atomic_t *refs = per_cpu_ptr(&bp_refs, i);
+
+		if (unlikely(!atomic_dec_and_test(refs)))
+			atomic_cond_read_acquire(refs, !VAL);
+	}
 }
 
 static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,

