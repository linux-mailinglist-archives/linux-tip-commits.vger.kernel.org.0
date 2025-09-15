Return-Path: <linux-tip-commits+bounces-6628-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F014EB5785E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8453B24BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94F306B07;
	Mon, 15 Sep 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXb09VP3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1Ic1nXS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD4306B05;
	Mon, 15 Sep 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935675; cv=none; b=AU3nhrOzFRDIZrgWeMv7RHQrQgSna5/1NCPbuG4ax+BmNMG0ZKbHfwiezcaLdOsDdsQn0KdSnMNjUJBj9rCQUCK6q9TilV74i+5PdyouJj/MWdQ4KFQSaRs0QhltHtbE+nLjubqrAmaA9T0g6iMjudeBPAEF0gtbXdaLf6ehDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935675; c=relaxed/simple;
	bh=MmIHk4ijuAmW7BEnAzFQSaWr+7NNP9f9cp7omOIDEwg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UGkT0bQP89BXTqKUFU/27CgOHdLl9XHxQvH+/GwAaEfGD3dbu2NM4R0OwjYyXoI80AyrFi9pJPbpv6ygtzMtOTkS1zUFlTkqe6rx7s2fdBHm9plk6eDCQ/KOpSDKt4Zx8aMCfMCPwpffv0t7fDVUfP/k3a8molWdLdZXChVY+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXb09VP3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y1Ic1nXS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nVDYLFbWbP9E7DXTxplZib7w9oHEK7vZ+M61DpV1PY=;
	b=kXb09VP3fq0mv3U0ZtG3VR8bftLWyogttrtF9lDfXHoYHKTJxr76XPiWrlA5jmpJVzvv+k
	9JXJvP1btV7kD70IjE6MiwYPqFGXvXjbiFGsykkEP23P/xG2jRoU64pouqaPavYHnavYRd
	PwVGEXAFTdpjXIbexwkG0PTEQj108cyMYUjN5MNyqCvfbIH2RLSoOjsODFnjq/x+GN6lS0
	boxm9vePxkwfHLoWTTmJQ7/IHUlnrnsWhXE7MTuOO9pxr4Ke93tWS+fZfFF8NlhtsgKJ/w
	ikxcYDgHwhS0oImZ0aT72Cs8BrJhyIE1HGY8TmpFSmZfOldRHX4Mfox/UZd5OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nVDYLFbWbP9E7DXTxplZib7w9oHEK7vZ+M61DpV1PY=;
	b=Y1Ic1nXStWNmF4z1P6Imcxhf1kp43nJ/EXtRzFPy3AcrHqYefLszHiAKBH/keIO0LrS2Ra
	ZBvt+n1qQ4GuzUAQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <37b798c0c4cf19365ca77a5ab4bc7dbba53b9aba.1757108044.git.babu.moger@amd.com>
References:
 <37b798c0c4cf19365ca77a5ab4bc7dbba53b9aba.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566810.709179.1589165423435066287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     13390861b426e936db20d675804a5b405622bc79
Gitweb:        https://git.kernel.org/tip/13390861b426e936db20d675804a5b40562=
2bc79
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:07 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:08:01 +02:00

x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The ABMC feature details are documented in APM [1] available from [2].

  [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
  Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
  Monitoring (ABMC).

Detect the feature and number of assignable counters supported. For backward
compatibility, upon detecting the assignable counter feature, enable the
mbm_total_bytes and mbm_local_bytes events that users are familiar with as
part of original L3 MBM support.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 # [2]
---
 arch/x86/kernel/cpu/resctrl/core.c    |  7 +++++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++---
 fs/resctrl/monitor.c                  |  7 +++++++
 include/linux/resctrl.h               |  4 ++++
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 267e920..2e68aa0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -883,6 +883,8 @@ static __init bool get_rdt_mon_resources(void)
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		ret =3D true;
 	}
+	if (rdt_cpu_has(X86_FEATURE_ABMC))
+		ret =3D true;
=20
 	if (!ret)
 		return false;
@@ -978,7 +980,7 @@ static enum cpuhp_state rdt_online;
 /* Runs once on the BSP during boot. */
 void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 {
-	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC) && !cpu_has(c, X86_FEATURE_ABMC)) {
 		c->x86_cache_max_rmid  =3D -1;
 		c->x86_cache_occ_scale =3D -1;
 		c->x86_cache_mbm_width_offset =3D -1;
@@ -990,7 +992,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
=20
 	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
 	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
+	    cpu_has(c, X86_FEATURE_ABMC)) {
 		u32 eax, ebx, ecx, edx;
=20
 		/* QoS sub-leaf, EAX=3D0Fh, ECX=3D1 */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 2558b1b..0a695ce 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -339,6 +339,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
 	unsigned int threshold;
+	u32 eax, ebx, ecx, edx;
=20
 	snc_nodes_per_l3_cache =3D snc_get_config();
=20
@@ -368,14 +369,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold =3D resctrl_arch_round_mon_val(threshold);
=20
-	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
-		u32 eax, ebx, ecx, edx;
-
+	if (rdt_cpu_has(X86_FEATURE_BMEC) || rdt_cpu_has(X86_FEATURE_ABMC)) {
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
 		r->mon.mbm_cfg_mask =3D ecx & MAX_EVT_CONFIG_BITS;
 	}
=20
+	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+		r->mon.mbm_cntr_assignable =3D true;
+		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+		r->mon.num_mbm_cntrs =3D (ebx & GENMASK(15, 0)) + 1;
+	}
+
 	r->mon_capable =3D true;
=20
 	return 0;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index e0dfa5f..b578451 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -922,6 +922,13 @@ int resctrl_mon_resource_init(void)
 	else if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mba_mbps_default_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
=20
+	if (r->mon.mbm_cntr_assignable) {
+		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+	}
+
 	return 0;
 }
=20
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fe2af6c..eb80cc2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -260,10 +260,14 @@ enum resctrl_schema_fmt {
  * @num_rmid:		Number of RMIDs available.
  * @mbm_cfg_mask:	Memory transactions that can be tracked when bandwidth
  *			monitoring events can be configured.
+ * @num_mbm_cntrs:	Number of assignable counters.
+ * @mbm_cntr_assignable:Is system capable of supporting counter assignment?
  */
 struct resctrl_mon {
 	int			num_rmid;
 	unsigned int		mbm_cfg_mask;
+	int			num_mbm_cntrs;
+	bool			mbm_cntr_assignable;
 };
=20
 /**

