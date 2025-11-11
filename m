Return-Path: <linux-tip-commits+bounces-7285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1DC4D6D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A0A3A7493
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69406357A5A;
	Tue, 11 Nov 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wudJYCXG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="47JJds4y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0858357A31;
	Tue, 11 Nov 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861026; cv=none; b=PCabDqgZc+RCQSnLLN82hdG58cFmDDkNuLhatMXGABCGjgA7DeInlwhPCj1lsvXYgjfN7+EkYX9zT37HWHg8w/5ay05eNQXKa6TdjerTQjITzojZIfty4GRXBCt9cQP8+bK5lrEO8Tq+7hynE33OgRiUv0Oi7rz9E95oT4CuNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861026; c=relaxed/simple;
	bh=Ewp3MG0nIeuyIkmj8Ot3amMivKkJ46X+mdSYvl3UUIg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rbUxs8frdMMNXwUg6EhP2mfCFf59aw5kqhf3afFSQzy0aqDYkQ3keIlX5TPmJ5LtilQFJw54+h4WvgjRIoSiDRJeI9ppWQOEE7mEKGWEClGdxrA/pU5sg50v2KjOU3XgjUDE0xOeVdYqgqQlEo9Fi6x14aras3tiEaTC0lJ8A28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wudJYCXG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=47JJds4y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/I+0T/F1qPJiPDl5pUz3tpy2Kdy8diieMtHYQ6T6dY=;
	b=wudJYCXGSgnRAqgWE+bFBqrrOdBpIvnMOFxznp+j/jtmYWVoqkHMoG6r1aeBn0Rh52dnR+
	UZhteGDhoehfnCOYCh9MsyEC/5nWbjmPdr0kwD5jJal3BRudO/h83iIAs8fEVgNR/uV3XR
	5h+wPSpgt4UiCEU56w95x3yOmWJLZDiHSbCkpYSZQ0c0jgXZW4H7FhH03OtxPJcLc0LsiK
	beJ1diYfQjU/RorJwGX6z+4NNENsuXl1lusYxjOUvABzK7edTwHhUE+rjMZNeEK27Df21s
	ur47KZYdSuB5spUmeTh90Fq12zd3FZiBlIGef8gPARcaK2s43fKO/AlyiWO2Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/I+0T/F1qPJiPDl5pUz3tpy2Kdy8diieMtHYQ6T6dY=;
	b=47JJds4ycIS1ZfFy19AxuuyL7V9eDFPkiNb4NePzQebvPnz56xP7/WBkGrqcvB6q5Ud8JD
	exhjxn80YBWOhZAg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Update dyn_constraint base on PEBS
 event precise level
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102226.498.11338928495001432142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e89c5d1f290e8915e0aad10014f2241086ea95e4
Gitweb:        https://git.kernel.org/tip/e89c5d1f290e8915e0aad10014f2241086e=
a95e4
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:34 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:22 +01:00

perf/x86/intel: Update dyn_constraint base on PEBS event precise level

arch-PEBS provides CPUIDs to enumerate which counters support PEBS
sampling and precise distribution PEBS sampling. Thus PEBS constraints
should be dynamically configured base on these counter and precise
distribution bitmap instead of defining them statically.

Update event dyn_constraint base on PEBS event precise level.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-11-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 11 +++++++++++
 arch/x86/events/intel/ds.c   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6e04d73..40ccfd8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4252,6 +4252,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
=20
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap =3D hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) =3D=3D INTEL_FIXED_VLBR_E=
VENT)
 			return -EINVAL;
=20
@@ -4265,6 +4267,15 @@ static int intel_pmu_hw_config(struct perf_event *even=
t)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (x86_pmu.arch_pebs) {
+			u64 cntr_mask =3D hybrid(event->pmu, intel_ctrl) &
+						~GLOBAL_CTRL_EN_PERF_METRICS;
+			u64 pebs_mask =3D event->attr.precise_ip >=3D 3 ?
+						pebs_cap.pdists : pebs_cap.counters;
+			if (cntr_mask !=3D pebs_mask)
+				event->hw.dyn_constraint &=3D pebs_mask;
+		}
 	}
=20
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5c26a52..1179980 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3005,6 +3005,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size =3D PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs =3D intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable =3D ~0ULL;
+	x86_pmu.flags |=3D PMU_FL_PEBS_ALL;
=20
 	x86_pmu.pebs_enable =3D __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable =3D __intel_pmu_pebs_disable;

