Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F442D8FA5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgLMTDG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391254AbgLMTDA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B370C0619DF;
        Sun, 13 Dec 2020 11:01:16 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m8JNUP2/pbTevFrZm6hQKuzsUyHWYvdRLF+tbCV4F90=;
        b=yPgNWfLQm3QGeYSuJRSdNJkot29QoT6B4Wou3iY87K66wQrO0V5OvSrHa0axKx8KtCHtix
        zgzDxi/fYLQDWOgXM9Fw4GtO2xg6JpA3rRtumUbuGE85AmyF+UZbXDDWtv4sTlYIKOoxBA
        k7ciQvEOQvMUsy7vxq4jCl3wkOL/UcqBaZG8Mdwnm9fImiLEhIxOfPln/NY67voGtUFCqm
        YSb4W0oAEx+/8ypz+FJfRx8lzM2Y5h5lEDMqmVH1Bv+A8yfdSWNxJaZbX3n7yX46Rhg1B7
        bcj33eN2GOmCSUhGaYMci3kxxHyPezAiGSSBrVv8DiYTncEepIbk0EBrD0OUcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m8JNUP2/pbTevFrZm6hQKuzsUyHWYvdRLF+tbCV4F90=;
        b=7X1be6H/bC/IngtM2xiy/2y4dR+TQmQ3tCmNyXCXaOM2SfUxMytW+n3gkH3JgSM/ldPmXH
        qr3pwyEGTFqdpqDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] x86/cpu: Avoid cpuinfo-induced IPI pileups
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607214.3364.10384643659601866486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f4deaf90212c18d4b6d0687f0cba4c22d90b3391
Gitweb:        https://git.kernel.org/tip/f4deaf90212c18d4b6d0687f0cba4c22d90b3391
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 02 Sep 2020 13:19:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 16:58:40 -08:00

x86/cpu: Avoid cpuinfo-induced IPI pileups

The aperfmperf_snapshot_cpu() function is invoked upon access to
/proc/cpuinfo, and it does do an early exit if the specified CPU has
recently done a snapshot.  Unfortunately, the indication that a snapshot
has been completed is set in an IPI handler, and the execution of this
handler can be delayed by any number of unfortunate events.  This means
that a system that starts a number of applications, each of which
parses /proc/cpuinfo, can suffer from an smp_call_function_single()
storm, especially given that each access to /proc/cpuinfo invokes
smp_call_function_single() for all CPUs.  Please note that this is not
theoretical speculation.  Note also that one CPU's pending IPI serves
all requests, so there is no point in ever having more than one IPI
pending to a given CPU.

This commit therefore suppresses duplicate IPIs to a given CPU via a
new ->scfpending field in the aperfmperf_sample structure.  This field
is set to the value one if an IPI is pending to the corresponding CPU
and to zero otherwise.

The aperfmperf_snapshot_cpu() function uses atomic_xchg() to set this
field to the value one and sample the old value.  If this function's
"wait" parameter is zero, smp_call_function_single() is called only if
the old value of the ->scfpending field was zero.  The IPI handler uses
atomic_set_release() to set this new field to zero just before returning,
so that the prior stores into the aperfmperf_sample structure are seen
by future requests that get to the atomic_xchg().  Future requests that
pass the elapsed-time check are ordered by the fact that on x86 loads act
as acquire loads, just as was the case prior to this change.  The return
value is based off of the age of the prior snapshot, just as before.

Reported-by: Dave Jones <davej@codemonkey.org.uk>
[ paulmck: Allow /proc/cpuinfo to take advantage of arch_freq_get_on_cpu(). ]
[ paulmck: Add comment on memory barrier. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/cpu/aperfmperf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e2f319d..dd3261d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -19,6 +19,7 @@
 
 struct aperfmperf_sample {
 	unsigned int	khz;
+	atomic_t	scfpending;
 	ktime_t	time;
 	u64	aperf;
 	u64	mperf;
@@ -62,17 +63,20 @@ static void aperfmperf_snapshot_khz(void *dummy)
 	s->aperf = aperf;
 	s->mperf = mperf;
 	s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
+	atomic_set_release(&s->scfpending, 0);
 }
 
 static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 {
 	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
+	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
 
 	/* Don't bother re-computing within the cache threshold time. */
 	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return true;
 
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
+	if (!atomic_xchg(&s->scfpending, 1) || wait)
+		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
 
 	/* Return false if the previous iteration was too long ago. */
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
@@ -118,6 +122,8 @@ void arch_freq_prepare_all(void)
 
 unsigned int arch_freq_get_on_cpu(int cpu)
 {
+	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
+
 	if (!cpu_khz)
 		return 0;
 
@@ -131,6 +137,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 		return per_cpu(samples.khz, cpu);
 
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
+	atomic_set(&s->scfpending, 1);
+	smp_mb(); /* ->scfpending before smp_call_function_single(). */
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
 
 	return per_cpu(samples.khz, cpu);
