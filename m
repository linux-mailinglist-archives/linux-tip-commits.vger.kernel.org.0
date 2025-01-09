Return-Path: <linux-tip-commits+bounces-3187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D645A071CD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F21B3A340E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E22215776;
	Thu,  9 Jan 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSKTV52W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qTG4Awg/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829B215766;
	Thu,  9 Jan 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415828; cv=none; b=OxSbvv9Xc2IKp4utvfitaxz4sgvhZa735r5EzW+2u5BJ8JyJdTaznuD0r0KzHpzZ+Pf6bJ3/8FEMXycCT2nqiIY2dpwZ++Xmu0soioVCSVKijAM39H0TnwmSig697TG7yU0DVhyvT21s80pFsv5X83g/2h/wsJpzUSFaSl3X04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415828; c=relaxed/simple;
	bh=f83iJZ+JxXjIN4GexHOcqEM0lObZJlf/75IssjBaVqU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PcqQetpvtPHG4MVR6ig79YBXNZJwaGUJyo5xmryFnJBu7wctBeUtmI8w9zxhmZsSAAIyW6u3cCym8Iundx+BVbuEm6ibtkkwNVMBU5O8Sc34IUS0HOJp5gwIue8Gvo8b671i1+SV9nWZdf60SW3pl0lcsq90qWxELEVcttrCE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSKTV52W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qTG4Awg/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FY7fx8wPF54U3B77NcvehXuSdIE5npnJ9SgsH5uiGHo=;
	b=YSKTV52WMenButAVDyGIs6JcpYtl+RqY6uyEMvIXzunyi6tG6hbCg0GTs/5paLdGgVnNGv
	fA8RwCYdTomr+B5c6Daqc8LXqFysMnENEEiehNi7a3uuRMTfHpiwPsoJ4JOHM3pCqSnyhb
	BVThFsII5W+S2SX3wapwOyvHdQ1pBlT40COqnAlu/2Sw3i6jmCel80HDo5ZM0c+Rvtkj9e
	AOjuU3D1/QJEXSqXO5rnVlP2+MT4jsEIvuh47xQA1zUmkWXNno49famf+0bbCxYM1eEQSq
	+epNGme8/x0pVsMp1DR16YMJnlwGMVgmERYPEJ/txxMSduARHK2CVjo6MqXGoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FY7fx8wPF54U3B77NcvehXuSdIE5npnJ9SgsH5uiGHo=;
	b=qTG4Awg/x57PP8IQAkgz5aUpZfzw2UHvz+V5iQygPBG4hMk4+nPjyu4ydpo8PrKvb1nB2m
	dQ8O7oNsdosOtBDg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/tsc: Init the TSC for Secure TSC guests
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-11-nikunj@amd.com>
References: <20250106124633.1418972-11-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582478.399.12254551170361680814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     73bbf3b0fbba9aa27fef07a1fbd837661a863f03
Gitweb:        https://git.kernel.org/tip/73bbf3b0fbba9aa27fef07a1fbd837661a863f03
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:30 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 21:26:19 +01:00

x86/tsc: Init the TSC for Secure TSC guests

Use the GUEST_TSC_FREQ MSR to discover the TSC frequency instead of
relying on kvm-clock based frequency calibration.  Override both CPU and
TSC frequency calibration callbacks with securetsc_get_tsc_khz(). Since
the difference between CPU base and TSC frequency does not apply in this
case, the same callback is being used.

  [ bp: Carve out from
    https://lore.kernel.org/r/20250106124633.1418972-11-nikunj@amd.com ]

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250106124633.1418972-11-nikunj@amd.com
---
 arch/x86/coco/sev/core.c   | 21 +++++++++++++++++++++
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/kernel/tsc.c      |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 106bded..65d676c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -103,6 +103,7 @@ static u64 secrets_pa __ro_after_init;
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
+static u64 snp_tsc_freq_khz __ro_after_init;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
@@ -3278,3 +3279,23 @@ void __init snp_secure_tsc_prepare(void)
 
 	pr_debug("SecureTSC enabled");
 }
+
+static unsigned long securetsc_get_tsc_khz(void)
+{
+	return snp_tsc_freq_khz;
+}
+
+void __init snp_secure_tsc_init(void)
+{
+	unsigned long long tsc_freq_mhz;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		return;
+
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	rdmsrl(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
+	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
+
+	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
+	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index bdcdaac..5d9685f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -482,6 +482,7 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 			   struct snp_guest_request_ioctl *rio);
 
 void __init snp_secure_tsc_prepare(void);
+void __init snp_secure_tsc_init(void);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -524,6 +525,7 @@ static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
 static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
+static inline void __init snp_secure_tsc_init(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 67aeaba..0864b31 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -30,6 +30,7 @@
 #include <asm/i8259.h>
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
+#include <asm/sev.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1515,6 +1516,9 @@ void __init tsc_early_init(void)
 	/* Don't change UV TSC multi-chassis synchronization */
 	if (is_early_uv_system())
 		return;
+
+	snp_secure_tsc_init();
+
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
 	tsc_enable_sched_clock();

