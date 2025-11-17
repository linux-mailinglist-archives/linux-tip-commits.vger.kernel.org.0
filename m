Return-Path: <linux-tip-commits+bounces-7379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D45C6528E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C938328F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541FB2D8DA6;
	Mon, 17 Nov 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="liW17BDo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PdMFHKXN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002A2D7DC5;
	Mon, 17 Nov 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396624; cv=none; b=PcPcfuay14py+yVCURSHYyEkI7H+qEhfFweBiFncQxkNj+8F7RaVoWl1oTf4rbu0Epo6GXWHKBTGMp4z7oql7ADLVQiCI5KIC/mgYWDdphaakl3UowgIKickpvPfGIs1C+Ty318APsDv7EEamj8y+0J1XLhgxXxoEdAuNWx4kmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396624; c=relaxed/simple;
	bh=l3TafBG3k5Zj/9OLKK3/Kvl6UN7/V9Pq9eObciPt6vk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JthyEombohwht7OHqjlmj3VVReQhTxbsY0aR1u4FPR3t21+u+W7Xz09Gdli85tKdBeUHje/JPyxK1jzBmh83J7krwWcwP4h4enAZ7PbjA/oAlLlVcVIeT0zg+PrImLizz2WJ9xYYBa4S7HPpVUrSXFfWFSI1kqIw6kUv/jaE1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=liW17BDo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PdMFHKXN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+H2cRFxt4kPDPDbdnpx6+6+hVs04Meluv15XeyStG8M=;
	b=liW17BDoTQ7GbsngBVvNq2AjjIu15QVUv5dTpEMYgGIP1bce6r2qTo2BBBWPshMttaibuj
	rC3pIbpOuKlKngPrlEaJxp2f9AAQagdlfEw9321EPb9Rxi6A2iEc5cSASSiBf0OWJ4hHo+
	4K+pq9dPHw4n8m5ij7FWJ69HagqYnuYInO+VtBHk5Oraa+8ImkyMH4EGsxHCbcgQlGZIxC
	dQXWBc3eUOqdSYPF4zN86LZvrfHBqHgdnLzvZUV7R1jLfT2MAD/P4rkWICIHtNQ7Q+witZ
	jjx2a58rVFMyZY0ge0/QRdeJ9PULy3J+MXCGjB+V3gfTjnBHEnpWFEaA7cde8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+H2cRFxt4kPDPDbdnpx6+6+hVs04Meluv15XeyStG8M=;
	b=PdMFHKXN8dR+xCQYe7FZZl27KS7HaRuSEJr2/hOFVIDEZCTYApSwYD4mW2NcSpet3uvgl8
	ATqZ75evWpWucNCA==
From: "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srikar Dronamraju <srikar@linux.ibm.com>,
 Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6fed119b723c71552943bfe5798c93851b30a361=2E1762800?=
 =?utf-8?q?251=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C6fed119b723c71552943bfe5798c93851b30a361=2E17628002?=
 =?utf-8?q?51=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176339661932.498.15491008222212450109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3324b2180c17b21c31c16966cc85ca41a7c93703
Gitweb:        https://git.kernel.org/tip/3324b2180c17b21c31c16966cc85ca41a7c=
93703
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Mon, 10 Nov 2025 10:47:35 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:12:00 +01:00

sched/fair: Skip sched_balance_running cmpxchg when balance is not due

The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
only one NUMA load balancing operation to run system-wide at a time.

Currently, each sched group leader directly under NUMA domain attempts
to acquire the global sched_balance_running flag via cmpxchg() before
checking whether load balancing is due or whether it is the designated
load balancer for that NUMA domain. On systems with a large number
of cores, this causes significant cache contention on the shared
sched_balance_running flag.

This patch reduces unnecessary cmpxchg() operations by first checking
that the balancer is the designated leader for a NUMA domain from
should_we_balance(), and the balance interval has expired before
trying to acquire sched_balance_running to load balance a NUMA
domain.

On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
running an OLTP workload, 7.8% of total CPU cycles were previously spent
in sched_balance_domain() contending on sched_balance_running before
this change.

         : 104              static __always_inline int arch_atomic_cmpxchg(at=
omic_t *v, int old, int new)
         : 105              {
         : 106              return arch_cmpxchg(&v->counter, old, new);
    0.00 :   ffffffff81326e6c:       xor    %eax,%eax
    0.00 :   ffffffff81326e6e:       mov    $0x1,%ecx
    0.00 :   ffffffff81326e73:       lock cmpxchg %ecx,0x2394195(%rip)       =
 # ffffffff836bb010 <sched_balance_running>
         : 110              sched_balance_domains():
         : 12234            if (atomic_cmpxchg_acquire(&sched_balance_running=
, 0, 1))
   99.39 :   ffffffff81326e7b:       test   %eax,%eax
    0.00 :   ffffffff81326e7d:       jne    ffffffff81326e99 <sched_balance_d=
omains+0x209>
         : 12238            if (time_after_eq(jiffies, sd->last_balance + int=
erval)) {
    0.00 :   ffffffff81326e7f:       mov    0x14e2b3a(%rip),%rax        # fff=
fffff828099c0 <jiffies_64>
    0.00 :   ffffffff81326e86:       sub    0x48(%r14),%rax
    0.00 :   ffffffff81326e8a:       cmp    %rdx,%rax

After applying this fix, sched_balance_domain() is gone from the profile
and there is a 5% throughput improvement.

[peterz: made it so that redo retains the 'lock' and split out the
         CPU_NEWLY_IDLE change to a separate patch]
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://patch.msgid.link/6fed119b723c71552943bfe5798c93851b30a361.17628=
00251.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b4617d6..59b17f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11681,6 +11681,21 @@ static void update_lb_imbalance_stat(struct lb_env *=
env, struct sched_domain *sd
 }
=20
 /*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running =3D ATOMIC_INIT(0);
+
+/*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
  */
@@ -11705,6 +11720,7 @@ static int sched_balance_rq(int this_cpu, struct rq *=
this_rq,
 		.fbq_type	=3D all,
 		.tasks		=3D LIST_HEAD_INIT(env.tasks),
 	};
+	bool need_unlock =3D false;
=20
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
=20
@@ -11716,6 +11732,14 @@ redo:
 		goto out_balanced;
 	}
=20
+	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle !=3D CPU_NEWLY_IDLE)=
 {
+		int zero =3D 0;
+		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
+			goto out_balanced;
+
+		need_unlock =3D true;
+	}
+
 	group =3D sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11956,6 +11980,9 @@ out_one_pinned:
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *=3D 2;
 out:
+	if (need_unlock)
+		atomic_set_release(&sched_balance_running, 0);
+
 	return ld_moved;
 }
=20
@@ -12081,21 +12108,6 @@ out_unlock:
 }
=20
 /*
- * This flag serializes load-balancing passes over large domains
- * (above the NODE topology level) - only one load-balancing instance
- * may run at a time, to reduce overhead on very large systems with
- * lots of CPUs and large NUMA distances.
- *
- * - Note that load-balancing passes triggered while another one
- *   is executing are skipped and not re-tried.
- *
- * - Also note that this does not serialize rebalance_domains()
- *   execution, as non-SD_SERIALIZE domains will still be
- *   load-balanced in parallel.
- */
-static atomic_t sched_balance_running =3D ATOMIC_INIT(0);
-
-/*
  * Scale the max sched_balance_rq interval with the number of CPUs in the sy=
stem.
  * This trades load-balance latency on larger machines for less cross talk.
  */
@@ -12150,7 +12162,7 @@ static void sched_balance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance =3D jiffies + 60*HZ;
 	int update_next_balance =3D 0;
-	int need_serialize, need_decay =3D 0;
+	int need_decay =3D 0;
 	u64 max_cost =3D 0;
=20
 	rcu_read_lock();
@@ -12174,13 +12186,6 @@ static void sched_balance_domains(struct rq *rq, enu=
m cpu_idle_type idle)
 		}
=20
 		interval =3D get_sd_balance_interval(sd, busy);
-
-		need_serialize =3D sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
-				goto out;
-		}
-
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
@@ -12194,9 +12199,6 @@ static void sched_balance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
 			sd->last_balance =3D jiffies;
 			interval =3D get_sd_balance_interval(sd, busy);
 		}
-		if (need_serialize)
-			atomic_set_release(&sched_balance_running, 0);
-out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance =3D sd->last_balance + interval;
 			update_next_balance =3D 1;

