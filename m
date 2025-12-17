Return-Path: <linux-tip-commits+bounces-7742-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3489BCC82A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 15:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A6A5308CDC4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630B346A02;
	Wed, 17 Dec 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EV5ixuAy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NV9AY/d1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F67346761;
	Wed, 17 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975091; cv=none; b=mNIb1RZPgQe1rvR1XLRURAlXidJtUjzgPD8+iBIS63GaLRA1TZaFym0jfECgSZkj4R+a6z3dpmoT/vRsJ9Kf9R1ua42pk5/T+pqQR8KgxjZQeYo8p2qDy9CMt4/HHeuJX18RLTiy2TKuNKb3NsU8amRrDy8wjEUuAbOUkb0NlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975091; c=relaxed/simple;
	bh=sAOexaFvt4D09WDgGvAD49Q2qhrePm5KclQ3/PYKDFo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XO9FjXdNCmrmbOTmo7I4IOiHKbXj6iLCyubawqG6j619uKNZ2N+gRCUNDDBWFbkFjL5IuOnY2DGfkIdiXeYfw66jlT4htensTVMbFWgizuKkjgOTR0XPb4yTu/k2uiG8dr0T7p8ZaOAT6nnc32mVWOWBpHP8m8ZtUgkFHq8Knl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EV5ixuAy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NV9AY/d1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ysuGWdoqkqqmD/7Q+2TcYSRA2Y8YORnnXhHDKRKMzU=;
	b=EV5ixuAyy1Ts0HbYNeE98JI6iqcKCD6HWutXh/vNCM+vM4hTMNB5JzoCcPcJIy8VrojEWE
	l7ye6EuMUgcB6AIUDJ7hkqkpP1TlUJigDTE9y+Eucsap/toDi29eo44eFJts9C+6IoI1o5
	RayJ9yIKrMlSBTzNybiu5c+ReZyy/jS69tl7Rkar+PcVpFgNHxSAiVW8xd+eV81aBRXR3C
	AKY05rNaPvD9ZZO2aAIGdtMru9FYLzztXbyeO7AFvXmfP6b14f0JMKhjIsbhZp/5lElWLB
	cJknxzsUNmQgee68ci1shnLc1GU0SkU8v/yaeNK4uyIXN3wdgt94BH2pQ+fE8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ysuGWdoqkqqmD/7Q+2TcYSRA2Y8YORnnXhHDKRKMzU=;
	b=NV9AY/d1bWnroNE7VENSj6J7adcIL4lu7F+L13ohD/52ZztqIC7VOwTXacgHmEL8ZXSvJI
	xJPT8+YJPmQwPJDw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
Cc: Kan Liang <kan.liang@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-13-seanjc@google.com>
References: <20251206001720.468579-13-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508743.510.8527612472256743629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4280d79587a3fd4bf9415705536fe385467c5f44
Gitweb:        https://git.kernel.org/tip/4280d79587a3fd4bf9415705536fe385467=
c5f44
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:48 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:06 +01:00

perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU

Apply the PERF_PMU_CAP_MEDIATED_VPMU for Intel core PMU. It only indicates
that the perf side of core PMU is ready to support the mediated vPMU.
Besides the capability, the hypervisor, a.k.a. KVM, still needs to check
the PMU version and other PMU features/capabilities to decide whether to
enable support mediated vPMUs.

[sean: massage changelog]
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-13-seanjc@google.com
---
 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bdf3f0d..0553c11 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5695,6 +5695,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybr=
id_pmu *pmu)
 	else
 		pmu->intel_ctrl &=3D ~GLOBAL_CTRL_EN_PERF_METRICS;
=20
+	pmu->pmu.capabilities |=3D PERF_PMU_CAP_MEDIATED_VPMU;
+
 	intel_pmu_check_event_constraints_all(&pmu->pmu);
=20
 	intel_pmu_check_extra_regs(pmu->extra_regs);
@@ -7314,6 +7316,9 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
=20
+	/* The perf side of core PMU is ready to support the mediated vPMU. */
+	x86_get_pmu(smp_processor_id())->capabilities |=3D PERF_PMU_CAP_MEDIATED_VP=
MU;
+
 	/*
 	 * Many features on and after V6 require dynamic constraint,
 	 * e.g., Arch PEBS, ACR.

