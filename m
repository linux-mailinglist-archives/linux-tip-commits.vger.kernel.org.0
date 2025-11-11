Return-Path: <linux-tip-commits+bounces-7283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324DC4D6C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC109345D62
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47F5357A36;
	Tue, 11 Nov 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJNjg+GW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVhnNAaX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04378357715;
	Tue, 11 Nov 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861024; cv=none; b=sjKznxLuHypbME71PwsG6DAFJ4E8spYfFscQ6wvLnAd/shYh4voVUz52RWdR8CgvCyrKHm5hfWOlYfxqDF62EbbAi76dZjvy2/osAQCMLb5Bm1DVQhehT06i8QQ8TDP1DdgF9q0/VWiaCcIeKot8EgNjItGk818sbUOpf/tK2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861024; c=relaxed/simple;
	bh=YH/+D/avQHpmuEle+3bfUoGr3kiUocL4eAf/w9Jm4sI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RUCj2ocniXO7gOldu9IhP6yGuU46ZG34FzANtZDJDxNM4rqQHkA0fhPtJE8c5E79isbwrif80sEB8eqKYGy/bqSOpxCWjHJeysq5dkATzmwwCWqMrxTVlK9ULUAPqhhA4wG1I/mc6pCViGluWgvviHfnaUo9ckg5q+nn9g1KlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJNjg+GW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVhnNAaX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:36:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MR4HZBqputn0em0YdKVD18nCSyW0UJVyYzWCwO+07vY=;
	b=oJNjg+GWlHZPorfb7WzYyIKzB8uEyym7k3z16QmM6qEKaU6ywYiaBCEAFpOrHXgMQRDniy
	CqKPDscgp+TisWfp3OwDd6og8ixrINzJR1+4g32CT5CtZrRXpW3qGu8aTwCBAEQMGf1Bfx
	rBpGZdgXHAHSkDHg8jAcYhIdpyZ9hIZwsTaG+efFuyYikgbthAsjENp3fhnpGbe8UuCArR
	LdKpbXX1UBaH6nYMFTpMh10YTcMtIeRHXN3c4JwdPMj0WeuGZf16PoxYeJfPmCvQ/9bL6l
	WYczkK3Ntpr9x4xYA8IZDmAQqRxuAcC1nFNkEpXThnztX8oFRsF80COdxnFjtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MR4HZBqputn0em0YdKVD18nCSyW0UJVyYzWCwO+07vY=;
	b=FVhnNAaX5a5hlXMQVLxAvDyYROCtXkLN/OzPth1VXpM511Hg3hz6RvP75Hmdz5icdi0pr6
	6cpTxBU8nz3BABCw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add a check for dynamic constraints
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250512175542.2000708-1-kan.liang@linux.intel.com>
References: <20250512175542.2000708-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286101919.498.13654178101048929710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd24f9beed591422f45fa6d8d0d3bd3a755b8a48
Gitweb:        https://git.kernel.org/tip/bd24f9beed591422f45fa6d8d0d3bd3a755=
b8a48
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 May 2025 10:55:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:23 +01:00

perf/x86/intel: Add a check for dynamic constraints

The current event scheduler has a limit. If the counter constraint of an
event is not a subset of any other counter constraint with an equal or
higher weight. The counters may not be fully utilized.

To workaround it, the commit bc1738f6ee83 ("perf, x86: Fix event
scheduler for constraints with overlapping counters") introduced an
overlap flag, which is hardcoded to the event constraint that may
trigger the limit. It only works for static constraints.

Many features on and after Intel PMON v6 require dynamic constraints. An
event constraint is decided by both static and dynamic constraints at
runtime. See commit 4dfe3232cc04 ("perf/x86: Add dynamic constraint").
The dynamic constraints are from CPUID enumeration. It's impossible to
hardcode it in advance. It's not practical to set the overlap flag to all
events. It's harmful to the scheduler.

For the existing Intel platforms, the dynamic constraints don't trigger
the limit. A real fix is not required.

However, for virtualization, VMM may give a weird CPUID enumeration to a
guest. It's impossible to indicate what the weird enumeration is. A
check is introduced, which can list the possible breaks if a weird
enumeration is used.

Check the dynamic constraints enumerated for normal, branch counters
logging, and auto-counter reload.
Check both PEBS and non-PEBS constratins.

Closes: https://lore.kernel.org/lkml/20250416195610.GC38216@noisy.programming=
.kicks-ass.net/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250512175542.2000708-1-kan.liang@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 156 ++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cb64018..93780af 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5420,6 +5420,151 @@ static void intel_pmu_check_event_constraints(struct =
event_constraint *event_con
 					      u64 fixed_cntr_mask,
 					      u64 intel_ctrl);
=20
+enum dyn_constr_type {
+	DYN_CONSTR_NONE,
+	DYN_CONSTR_BR_CNTR,
+	DYN_CONSTR_ACR_CNTR,
+	DYN_CONSTR_ACR_CAUSE,
+
+	DYN_CONSTR_MAX,
+};
+
+static const char * const dyn_constr_type_name[] =3D {
+	[DYN_CONSTR_NONE] =3D "a normal event",
+	[DYN_CONSTR_BR_CNTR] =3D "a branch counter logging event",
+	[DYN_CONSTR_ACR_CNTR] =3D "an auto-counter reload event",
+	[DYN_CONSTR_ACR_CAUSE] =3D "an auto-counter reload cause event",
+};
+
+static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
+					 enum dyn_constr_type type, u64 mask)
+{
+	struct event_constraint *c1, *c2;
+	int new_weight, check_weight;
+	u64 new_mask, check_mask;
+
+	for_each_event_constraint(c1, constr) {
+		new_mask =3D c1->idxmsk64 & mask;
+		new_weight =3D hweight64(new_mask);
+
+		/* ignore topdown perf metrics event */
+		if (c1->idxmsk64 & INTEL_PMC_MSK_TOPDOWN)
+			continue;
+
+		if (!new_weight && fls64(c1->idxmsk64) < INTEL_PMC_IDX_FIXED) {
+			pr_info("The event 0x%llx is not supported as %s.\n",
+				c1->code, dyn_constr_type_name[type]);
+		}
+
+		if (new_weight <=3D 1)
+			continue;
+
+		for_each_event_constraint(c2, c1 + 1) {
+			bool check_fail =3D false;
+
+			check_mask =3D c2->idxmsk64 & mask;
+			check_weight =3D hweight64(check_mask);
+
+			if (c2->idxmsk64 & INTEL_PMC_MSK_TOPDOWN ||
+			    !check_weight)
+				continue;
+
+			/* The same constraints or no overlap */
+			if (new_mask =3D=3D check_mask ||
+			    (new_mask ^ check_mask) =3D=3D (new_mask | check_mask))
+				continue;
+
+			/*
+			 * A scheduler issue may be triggered in the following cases.
+			 * - Two overlap constraints have the same weight.
+			 *   E.g., A constraints: 0x3, B constraints: 0x6
+			 *   event	counter		failure case
+			 *   B		PMC[2:1]	1
+			 *   A		PMC[1:0]	0
+			 *   A		PMC[1:0]	FAIL
+			 * - Two overlap constraints have different weight.
+			 *   The constraint has a low weight, but has high last bit.
+			 *   E.g., A constraints: 0x7, B constraints: 0xC
+			 *   event	counter		failure case
+			 *   B		PMC[3:2]	2
+			 *   A		PMC[2:0]	0
+			 *   A		PMC[2:0]	1
+			 *   A		PMC[2:0]	FAIL
+			 */
+			if (new_weight =3D=3D check_weight) {
+				check_fail =3D true;
+			} else if (new_weight < check_weight) {
+				if ((new_mask | check_mask) !=3D check_mask &&
+				    fls64(new_mask) > fls64(check_mask))
+					check_fail =3D true;
+			} else {
+				if ((new_mask | check_mask) !=3D new_mask &&
+				    fls64(new_mask) < fls64(check_mask))
+					check_fail =3D true;
+			}
+
+			if (check_fail) {
+				pr_info("The two events 0x%llx and 0x%llx may not be "
+					"fully scheduled under some circumstances as "
+					"%s.\n",
+					c1->code, c2->code, dyn_constr_type_name[type]);
+			}
+		}
+	}
+}
+
+static void intel_pmu_check_dyn_constr(struct pmu *pmu,
+				       struct event_constraint *constr,
+				       u64 cntr_mask)
+{
+	enum dyn_constr_type i;
+	u64 mask;
+
+	for (i =3D DYN_CONSTR_NONE; i < DYN_CONSTR_MAX; i++) {
+		mask =3D 0;
+		switch (i) {
+		case DYN_CONSTR_NONE:
+			mask =3D cntr_mask;
+			break;
+		case DYN_CONSTR_BR_CNTR:
+			if (x86_pmu.flags & PMU_FL_BR_CNTR)
+				mask =3D x86_pmu.lbr_counters;
+			break;
+		case DYN_CONSTR_ACR_CNTR:
+			mask =3D hybrid(pmu, acr_cntr_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC=
 - 1, 0);
+			break;
+		case DYN_CONSTR_ACR_CAUSE:
+			if (hybrid(pmu, acr_cntr_mask64) =3D=3D hybrid(pmu, acr_cause_mask64))
+				continue;
+			mask =3D hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERI=
C - 1, 0);
+			break;
+		default:
+			pr_warn("Unsupported dynamic constraint type %d\n", i);
+		}
+
+		if (mask)
+			__intel_pmu_check_dyn_constr(constr, i, mask);
+	}
+}
+
+static void intel_pmu_check_event_constraints_all(struct pmu *pmu)
+{
+	struct event_constraint *event_constraints =3D hybrid(pmu, event_constraint=
s);
+	struct event_constraint *pebs_constraints =3D hybrid(pmu, pebs_constraints);
+	u64 cntr_mask =3D hybrid(pmu, cntr_mask64);
+	u64 fixed_cntr_mask =3D hybrid(pmu, fixed_cntr_mask64);
+	u64 intel_ctrl =3D hybrid(pmu, intel_ctrl);
+
+	intel_pmu_check_event_constraints(event_constraints, cntr_mask,
+					  fixed_cntr_mask, intel_ctrl);
+
+	if (event_constraints)
+		intel_pmu_check_dyn_constr(pmu, event_constraints, cntr_mask);
+
+	if (pebs_constraints)
+		intel_pmu_check_dyn_constr(pmu, pebs_constraints, cntr_mask);
+}
+
 static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
=20
 static inline bool intel_pmu_broken_perf_cap(void)
@@ -5537,10 +5682,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hyb=
rid_pmu *pmu)
 	else
 		pmu->intel_ctrl &=3D ~GLOBAL_CTRL_EN_PERF_METRICS;
=20
-	intel_pmu_check_event_constraints(pmu->event_constraints,
-					  pmu->cntr_mask64,
-					  pmu->fixed_cntr_mask64,
-					  pmu->intel_ctrl);
+	intel_pmu_check_event_constraints_all(&pmu->pmu);
=20
 	intel_pmu_check_extra_regs(pmu->extra_regs);
 }
@@ -7963,10 +8105,8 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.intel_cap.anythread_deprecated)
 		x86_pmu.format_attrs =3D intel_arch_formats_attr;
=20
-	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
-					  x86_pmu.cntr_mask64,
-					  x86_pmu.fixed_cntr_mask64,
-					  x86_pmu.intel_ctrl);
+	intel_pmu_check_event_constraints_all(NULL);
+
 	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
 	 * Check all LBR MSR here.

