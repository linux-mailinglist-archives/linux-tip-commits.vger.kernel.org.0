Return-Path: <linux-tip-commits+bounces-6640-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD2B59356
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F2A1896ED8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B53302CA2;
	Tue, 16 Sep 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KparWfr1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bNG/8vNu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739032E62CB;
	Tue, 16 Sep 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018100; cv=none; b=sYzkbnemptGV633JHkVPOW4iu9DCy9V/E/RbbfY2oPmF1wDm9Gmo8OTOY1zwMXWUR2v2nNbdJ8kKPJ8TK88UAw/a+uE1fTt1lOG+1Zvb1H1JMqNgwzNPVo0y9/oWGUrSsskUQPGSHkv3PECo3SlbenfLOQkjp8YYmOV+vklDr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018100; c=relaxed/simple;
	bh=cYsZHmp7i+Z9ryHycu5ZJkKXLF/TcKduDh6r6OuYkbw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Khn1wv+0EK24nZaAgb2pQQ3F5scRo53Lo9/t8h7IdyCgrE5oHMaf1jxPQDInZTBJP43XTfwd/rbVmPxBDsHRgjucxxnaqT6GaXcDSq1AO0agIC2QoC1ikehP8TjjAypGZ2zFiTwydxm5W475wIjAz9EMUytgt4DjcYdLgd+Khd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KparWfr1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bNG/8vNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 10:21:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758018096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UxVBwFW8DfHkNR6cpZy6Voeg8hJ7Pgmt9WAVS2rvFFg=;
	b=KparWfr1pEiWKRvY/Bs4zG63vYEnRpn90COzDYRF4TRRPEcTlNZPWG0X4/dp6tZ7dTc3SO
	nONzXWeRPMkPULMbV0dsijo1NSUMRCzuQGgv8+9nsNhy0TAKIaTZDHYb2X34Hisz3KRxUx
	5eNdFzaZuwY4KCJ2jb8pmtZcFe8nGnRIsIenPiiua03QIuSeBpM5nKOSpqlq1QyewAy1ty
	tUhoDZdv4V944Vn0JqqLIv7b++pQHqaVstd9J6WcXTzQzSGO73qMu24Ff+Y/pXrTT3ZMPu
	q7T/0EDrWfYIYy/Qy+Wc+hRhuDybSSnenev8HXXFQS5A7tyKV47Fpu5Xqu1qJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758018096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UxVBwFW8DfHkNR6cpZy6Voeg8hJ7Pgmt9WAVS2rvFFg=;
	b=bNG/8vNuuLRr24TMqwsgmkqHMIG+pXGv863cCrQa5HT++Pd51YFvviB2sWqFrO57z0pcpx
	05jFuj6GVzutx3DA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/topology: Define AMD64_CPUID_EXT_FEAT MSR
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175801809516.709179.4496581529220212494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d5efcab393837421a9ab5b14e6475fc8fc3ec02a
Gitweb:        https://git.kernel.org/tip/d5efcab393837421a9ab5b14e6475fc8fc3=
ec02a
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:17=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 15:38:14 +02:00

x86/cpu/topology: Define AMD64_CPUID_EXT_FEAT MSR

Add defines for the 0xc001_1005 MSR (Core::X86::Msr::CPUID_ExtFeatures) used
to toggle the extended CPUID features, instead of using naked numbers. Also
define and use the bits necessary for an old TOPOEXT fixup on AMD Family 0x15
processors.

No functional changes intended.

  [ bp: Massage, rename MSR to adhere to the documentation name. ]

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250901170418.4314-1-kprateek.nayak@amd.com
---
 arch/x86/include/asm/msr-index.h   | 5 +++++
 arch/x86/kernel/cpu/topology_amd.c | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index b65c3ba..a734b56 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -631,6 +631,11 @@
 #define MSR_AMD_PPIN			0xc00102f1
 #define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
+
+#define MSR_AMD64_CPUID_EXT_FEAT	0xc0011005
+#define MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT_BIT	54
+#define MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT	BIT_ULL(MSR_AMD64_CPUID_EXT_FEAT_TO=
POEXT_BIT)
+
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_TW_CFG		0xc0011023
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
index 7ebd4a1..6ac097e 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -163,11 +163,12 @@ static void topoext_fixup(struct topo_scan *tscan)
 	    c->x86 !=3D 0x15 || c->x86_model < 0x10 || c->x86_model > 0x6f)
 		return;
=20
-	if (msr_set_bit(0xc0011005, 54) <=3D 0)
+	if (msr_set_bit(MSR_AMD64_CPUID_EXT_FEAT,
+			MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT_BIT) <=3D 0)
 		return;
=20
-	rdmsrq(0xc0011005, msrval);
-	if (msrval & BIT_64(54)) {
+	rdmsrq(MSR_AMD64_CPUID_EXT_FEAT, msrval);
+	if (msrval & MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT) {
 		set_cpu_cap(c, X86_FEATURE_TOPOEXT);
 		pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Suppor=
t.\n");
 	}

