Return-Path: <linux-tip-commits+bounces-6637-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98929B57896
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6D61745D3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BE73009E5;
	Mon, 15 Sep 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsxdQOtP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KF5canzG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC652F0C6A;
	Mon, 15 Sep 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936164; cv=none; b=qfQHBsDe1/qBRsbygA9J2gVy3HlsaFYVVE3MZZIbnCIBqUe2iuPcWIlZBSywtQjAyZtWaAunVVTOvkGpgS3VHlvjH3ZhNygiFYNfbWj3K5yiIYtMLjVw1jRuEyzlYLd1m2D09tE1Dg+raSoVOExPctgvtz/u9F0HB1oGAdUAIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936164; c=relaxed/simple;
	bh=2JjvbUTrei+c5E+gZThMsmibb/zRz7ArkqNgH3OFc+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NDjkT50GXEPOU1mbOUQVD27WvdZnW9wpq3jKTVrY/oSv/WcMlioZhBSeNm76sIVShu8L6VsBrPOwsibQvxDuMZAjEsQRcHogr2I4nlXqjElgAp6kjHNw1CgZKQ3g+N++HgzxX5BWxFAmeq2cDeLfo6SkqqWevIOw0c4SNSds6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsxdQOtP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KF5canzG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMdvk19ZfvJq73ahr0Vzcg8M1yW/Ta2JPjiC6NpUM80=;
	b=SsxdQOtPZeFaSN1r591MTpZSr95I/D9QtdpXH0erRoafK7NEx/TdRGjGXAgaFBF/vtnZft
	rXbjfs5x6JyTbmu8IjTSoYd/JKjHutu6S8bY0F2VwoKsxvhCQOSmLXiv1uqjS2YfZ81CA7
	8XcamgI2Fo4tMg4dA7vZw0R+zzRTOAONUC7mDvkw7JSknfjBk2Z05jOaAimc9yh2ZCU4BX
	2ZO/IfZyzIdNZjWKsVVefTAlDEL36Rl6i5BkCyiXic0wjeIadhB29LjyCHoJq74TlnyI4r
	Of5L/Urze4Nt15H6neVavdGj32Hv8O8KEdOwnnuPZg09l2bF4s6plNoXHrGtrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMdvk19ZfvJq73ahr0Vzcg8M1yW/Ta2JPjiC6NpUM80=;
	b=KF5canzGOUGpARaWs/ub1TY/1WcsbaljRlNAOqt6dZ4OD1a1k3wee9NvX0BWchtfZ3CAs4
	CPLhzAtvhyF9oUBA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Configure mbm_event mode if supported
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e37577c1c0bb22c2e1e5e28f36f831623d56221a.1757108044.git.babu.moger@amd.com>
References:
 <e37577c1c0bb22c2e1e5e28f36f831623d56221a.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564043.709179.420128871131571525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0f1576e43adc62756879a240e66e89ce386b6eb9
Gitweb:        https://git.kernel.org/tip/0f1576e43adc62756879a240e66e89ce386=
b6eb9
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:31 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:52:04 +02:00

x86/resctrl: Configure mbm_event mode if supported

Configure mbm_event mode on AMD platforms. On AMD platforms, it is
recommended to use the mbm_event mode, if supported, to prevent the
hardware from resetting counters between reads. This can result in
misleading values or display "Unavailable" if no counter is assigned
to the event.

Enable mbm_event mode, known as ABMC (Assignable Bandwidth Monitoring
Counters) on AMD, by default if the system supports it.

Update ABMC across all logical processors within the resctrl domain to
ensure proper functionality.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 2e68aa0..06ca5a3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -520,6 +520,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resour=
ce *r)
 		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
=20
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		/* Update the mbm_assign_mode state for the CPU if supported */
+		if (r->mon.mbm_cntr_assignable)
+			resctrl_arch_mbm_cntr_assign_set_one(r);
 		return;
 	}
=20
@@ -539,6 +542,10 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resou=
rce *r)
 	d->ci_id =3D ci->id;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
=20
+	/* Update the mbm_assign_mode state for the CPU if supported */
+	if (r->mon.mbm_cntr_assignable)
+		resctrl_arch_mbm_cntr_assign_set_one(r);
+
 	arch_mon_domain_online(r, d);
=20
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index e5edddb..9f4c2f0 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -215,5 +215,6 @@ bool rdt_cpu_has(int flag);
 void __init intel_rdt_mbm_apply_quirk(void);
=20
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 0b3c199..c894561 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -456,6 +456,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		r->mon.mbm_cntr_assignable =3D true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs =3D (ebx & GENMASK(15, 0)) + 1;
+		hw_res->mbm_cntr_assign_enabled =3D true;
 	}
=20
 	r->mon_capable =3D true;
@@ -557,3 +558,10 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, st=
ruct rdt_mon_domain *d,
 	if (am)
 		memset(am, 0, sizeof(*am));
 }
+
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
+
+	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
+}

