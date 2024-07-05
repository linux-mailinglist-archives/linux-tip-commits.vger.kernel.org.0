Return-Path: <linux-tip-commits+bounces-1603-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5A928E79
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5603EB27757
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772F5145B14;
	Fri,  5 Jul 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mXSGYWWJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BX0tEogx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB413D63D;
	Fri,  5 Jul 2024 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213605; cv=none; b=ZIy20iKpOeF/KTFFfrKV3SbDv4d7mBgSUO81IY0zWg3pA4mTAwfndT8CwDRoftRMOdj4KwKZVG8QZhuFvYW3VRfWruxDe+dHRRZoTduRwWuQZam41aOxWAdRxLct7eRQtSs+hsObzz6hGjE0lLkJqgvMinb0YS425bsvGmY5WZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213605; c=relaxed/simple;
	bh=DluL7O/+70fSAgET6Fi7V2sNSgmRP8Czesa7hzvpLKw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ubhjeqYJeZoX5nTz5bPKdWVaVGQBZsBjoJYIMaI8VLySMu11c3CjRjBwDVPvLCl3QBmXZ7i9rxziZHyVEx3Dd1mKeTyFQdciixAmwAv7ysq79ShwKtOcH8d5lqmJO8pHOcDVbEj+ZfrqzseGBQSLKFf1JKhLDNZELtphf+H/Sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mXSGYWWJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BX0tEogx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jH2+Ilj4JlNVcNdvu5x7AFPbSb6Wq9vreJsBLrRNTGA=;
	b=mXSGYWWJTS3zEOLO9LBj/Z6HY82MtDrPRplDkZIW6bX5EvGQHk6S0ioFUM4fb7WtVR59rR
	7Z5dxU1Z4j/PxMXNmfNekiy92J/z3fEBftYYifWlIL8qaNmNnUI8ppzK74U+cSCC0U80Qd
	I6fcz9QWHoA5/ob8kDo48fYBXKOPc4nPH1ZdQw2BT2iKIqdTglixn8fjpxcKzAvro8MCAB
	2GiRKImkCzZdFlNZGzDm/yuZHrY9L2bOzC/YarY+xusG555aMEG5U9JRcHupy41DqlKWuS
	ntlwyl2R5Uu08cHzwy+IJjhovjCdjDmV6O+nOuh7CvobOaHtpfFIuavXADCKrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jH2+Ilj4JlNVcNdvu5x7AFPbSb6Wq9vreJsBLrRNTGA=;
	b=BX0tEogxehc67O28pzBuwnWP+MtX9lFhytXS0cFjuFIVMf/qLAjj7EX3orVwCLDWLH7uyO
	ZHyvSBQGD8ooAMCw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support PERFEVTSEL extension
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-8-kan.liang@linux.intel.com>
References: <20240626143545.480761-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360135.2215.18390376313385685944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dce0c74d2d180ce21d074b4f977821a567ab0020
Gitweb:        https://git.kernel.org/tip/dce0c74d2d180ce21d074b4f977821a567ab0020
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:40 +02:00

perf/x86/intel: Support PERFEVTSEL extension

Two new fields (the unit mask2, and the equal flag) are added in the
IA32_PERFEVTSELx MSRs. They can be enumerated by the CPUID.23H.0.EBX.

Update the config_mask in x86_pmu and x86_hybrid_pmu for the true layout
of the PERFEVTSEL.
Expose the new formats into sysfs if they are available. The umask
extension reuses the same format attr name "umask" as the previous
umask. Add umask2_show to determine/display the correct format
for the current machine.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-8-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 69 ++++++++++++++++++++++++++++--
 arch/x86/include/asm/perf_event.h |  4 ++-
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6e42ba0..fa0550e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4632,8 +4632,55 @@ PMU_FORMAT_ATTR(pc,	"config:19"	);
 PMU_FORMAT_ATTR(any,	"config:21"	); /* v3 + */
 PMU_FORMAT_ATTR(inv,	"config:23"	);
 PMU_FORMAT_ATTR(cmask,	"config:24-31"	);
-PMU_FORMAT_ATTR(in_tx,  "config:32");
-PMU_FORMAT_ATTR(in_tx_cp, "config:33");
+PMU_FORMAT_ATTR(in_tx,  "config:32"	);
+PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
+PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
+
+static ssize_t umask2_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *page)
+{
+	u64 mask = hybrid(dev_get_drvdata(dev), config_mask) & ARCH_PERFMON_EVENTSEL_UMASK2;
+
+	if (mask == ARCH_PERFMON_EVENTSEL_UMASK2)
+		return sprintf(page, "config:8-15,40-47\n");
+
+	/* Roll back to the old format if umask2 is not supported. */
+	return sprintf(page, "config:8-15\n");
+}
+
+static struct device_attribute format_attr_umask2  =
+		__ATTR(umask, 0444, umask2_show, NULL);
+
+static struct attribute *format_evtsel_ext_attrs[] = {
+	&format_attr_umask2.attr,
+	&format_attr_eq.attr,
+	NULL
+};
+
+static umode_t
+evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	u64 mask;
+
+	/*
+	 * The umask and umask2 have different formats but share the
+	 * same attr name. In update mode, the previous value of the
+	 * umask is unconditionally removed before is_visible. If
+	 * umask2 format is not enumerated, it's impossible to roll
+	 * back to the old format.
+	 * Does the check in umask2_show rather than is_visible.
+	 */
+	if (i == 0)
+		return attr->mode;
+
+	mask = hybrid(dev_get_drvdata(dev), config_mask);
+	if (i == 1)
+		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
+
+	return 0;
+}
 
 static struct attribute *intel_arch_formats_attr[] = {
 	&format_attr_event.attr,
@@ -4786,8 +4833,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
-	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
+
+	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
+
+	if (ebx & ARCH_PERFMON_EXT_UMASK2)
+		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
+	if (ebx & ARCH_PERFMON_EXT_EQ)
+		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
 
 	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
@@ -5810,6 +5863,12 @@ static struct attribute_group group_format_extra_skl = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_format_evtsel_ext = {
+	.name       = "format",
+	.attrs      = format_evtsel_ext_attrs,
+	.is_visible = evtsel_ext_is_visible,
+};
+
 static struct attribute_group group_default = {
 	.attrs      = intel_pmu_attrs,
 	.is_visible = default_is_visible,
@@ -5823,6 +5882,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_lbr,
 	&group_format_extra,
 	&group_format_extra_skl,
+	&group_format_evtsel_ext,
 	&group_default,
 	NULL,
 };
@@ -6042,6 +6102,7 @@ static const struct attribute_group *hybrid_attr_update[] = {
 	&group_caps_gen,
 	&group_caps_lbr,
 	&hybrid_group_format_extra,
+	&group_format_evtsel_ext,
 	&group_default,
 	&hybrid_group_cpus,
 	NULL,
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 400c909..91b7357 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -32,6 +32,8 @@
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 #define ARCH_PERFMON_EVENTSEL_BR_CNTR			(1ULL << 35)
+#define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
+#define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
 
 #define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -185,6 +187,8 @@ union cpuid10_edx {
  * detection/enumeration details:
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
+#define ARCH_PERFMON_EXT_UMASK2			0x1
+#define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 

