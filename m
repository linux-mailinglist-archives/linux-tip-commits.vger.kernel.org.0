Return-Path: <linux-tip-commits+bounces-4425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380FA6EA6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F268416DAB8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113BB225410;
	Tue, 25 Mar 2025 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHpkvqy6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kG23MEBC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132D38385;
	Tue, 25 Mar 2025 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887540; cv=none; b=M2rHzmFVr/y5gLs+ouVsm9Poj6eKlaQEGgBk/MpTHNab6IbOFhBzAzxUCGUZSwhJ0sDipXUJZYqtdmwTQ7bqLb3Vbb5A2S0vQW6TF5kFLirlRumiU96Z/nVZtHR+Aap1QG+YYth81DRieQB/1azEuB3CVb9/kpZgQmACaL/dCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887540; c=relaxed/simple;
	bh=NU7OtMmJEqvgQKpdQKFt5CI57ZgVV61oCeCB9Fq1xV8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AGG3Q5kxRh3WSOCNjF/xmyDimQk+I9bbjp60F3H9uQ/g2tV4aptfLV5ZV+O4vS+FsxECIt4rgYbxfc1ivED/F/lSQNn8cgf0ee/73vCuj2kNVwY3xtopi2Nb+guAI/GQ/BV4GMe8naH66HSy9U/8nw2MODvRpbdmI7o3Ia9YCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHpkvqy6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kG23MEBC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:25:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742887535;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHG4OQsCSVdlOAAnlv8byGZNX+v3qDa7dPbyE4sYyiA=;
	b=uHpkvqy6PHshTC7yBYdTrqNIvgEdsO/mmDkXbZN54VSVp/rdP5u+EykuFzAMbljhn3ebA0
	Dqbk673mfhFsZzKR5+GwGwl5IpPdW2d3/KSdG/7L2NNPOBk+XKDqgiT2+UUfg0jSHIvbz/
	KFPGRgc7xcYGPXVu2ya447ZCn2ex+i3zozghTXs4uMyidTyXb2oCwxmY3oHlKqle+v3Dxb
	usBBCaL3eupA2JxE7jy9Pm04OgumYdu5ZIpMoaZnIopAHYhN6ddeLxnGARrfJEejBEK/2i
	wdYPcHHYmE5erzj61zRzYwmXp68cw4vlSjMpMXezWcKHx3+mJFQ9bb6rIc7sBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742887535;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHG4OQsCSVdlOAAnlv8byGZNX+v3qDa7dPbyE4sYyiA=;
	b=kG23MEBCkVr97dsTgi7Gzad0ksT/d029x7vlePFe6T616UbxP4EcQrX95kK92YyEVwAxCq
	dqpKckRcXzqErgCg==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Improve code-patching
 scalability by removing false sharing in poke_int3_handler()
Cc: Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250325043316.874518-1-edumazet@google.com>
References: <20250325043316.874518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288753039.14745.12919435244978493101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     41e4ceece5913b867604a28298612f397072e1b4
Gitweb:        https://git.kernel.org/tip/41e4ceece5913b867604a28298612f397072e1b4
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Tue, 25 Mar 2025 04:33:16 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:10:30 +01:00

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
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250325043316.874518-1-edumazet@google.com
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

