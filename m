Return-Path: <linux-tip-commits+bounces-6816-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D2BDFC7D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEA8405C3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A033A037;
	Wed, 15 Oct 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgIJ+sS9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3/z2kCO5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3E338F3D;
	Wed, 15 Oct 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547141; cv=none; b=Ed26Qxja3bbFGo46rmbtY7M8TQB/BdhheYCJDX2xJAaNOBxLbywfJtiV9zkh6WSGo/K4TZh4zK8VffCms7TcIWozSEdiWFHySzkgWxRIlPFTGUtQDZfEYH8858AXb+u9xoDezpi8jmBvI//ZfXBV9+0MgIZvhMyx4z1IMbQspUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547141; c=relaxed/simple;
	bh=6FOL4O1iGW1etK1LM0S8nFEbb4WwJuchIRFnoNEV1tc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LkOM0OJPX8e1K7pyxW7FJ1DSNR3M+S8mmifff4fL7zTDfcFBGvciwKJGJUx5Spx2fsPORjiYA2prUw5gIrIwn4sVJqiwwPDZA8GJkCZ5I+y+ZO76tTS1oWMierZPTNP+RzGAtuqKeueMGkrA4lsgYjW1woDzT976nKBuIdATkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgIJ+sS9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3/z2kCO5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYMSYZC17VCfNFIdEOUO48Hze5znio+1AaXbq2ulr2Y=;
	b=JgIJ+sS9McL+g5eJwUII9cHDGDQbqcNfc+py2K7FJzcF7AQDjx1vIDoADVsE9z6yIrnh9v
	Y2pp5lyf5nT0W4rDREqm/MbnuPoyWfTd95lxRCkvzE0qXfs2QUX+s2xMsu+uvEpZ3+/edC
	TSw2m3EESne6KSeYV6Uq5sWy/stvhIKtBPh2l1T+m3RAwDwDjPCH2HvtYK/FqNgM7QKkZh
	2LEEwubFlsR9PpED0rV83boa7MQCIQJfakJsup2vrVTnBL/ujwuc3oc5RBoX75zIvQjuZB
	HK7gjvdVomqNIK1QGWZzYgzS3KKBzk+Shpum2rau0NvAILtCdYVb+OzMxErDrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYMSYZC17VCfNFIdEOUO48Hze5znio+1AaXbq2ulr2Y=;
	b=3/z2kCO5V8PXt5GVHEOmMWBuoPPNKeDeZOGa/O4YRjP9XP9wN4KparHOpzVrjekHSQz63s
	TojglzG3o5eoCWAA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/microcode/intel: Enable staging when available
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Chao Gao <chao.gao@intel.com>,
 Tony Luck <tony.luck@intel.com>, Anselm Busse <abusse@amazon.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-8-chang.seok.bae@intel.com>
References: <20250921224841.3545-8-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054713282.709179.14172574656114661140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     bffeb2fd0b9c99d8af348da88335bff408c63882
Gitweb:        https://git.kernel.org/tip/bffeb2fd0b9c99d8af348da88335bff408c=
63882
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:41 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:47:50 +02:00

x86/microcode/intel: Enable staging when available

With staging support implemented, enable it when the CPU reports the
feature.

  [ bp: Sort in the MSR properly. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/20250320234104.8288-1-chang.seok.bae@intel.com
---
 arch/x86/include/asm/msr-index.h      |  8 ++++++++
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 2b4560b..2324ad7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -166,6 +166,10 @@
 						 * Processor MMIO stale data
 						 * vulnerabilities.
 						 */
+#define ARCH_CAP_MCU_ENUM		BIT(16) /*
+						 * Indicates the presence of microcode update
+						 * feature enumeration and status information.
+						 */
 #define ARCH_CAP_FB_CLEAR		BIT(17)	/*
 						 * VERW clears CPU fill buffer
 						 * even on MDS_NO CPUs.
@@ -929,6 +933,10 @@
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
=20
 #define MSR_IA32_UCODE_WRITE		0x00000079
+
+#define MSR_IA32_MCU_ENUMERATION	0x0000007b
+#define MCU_STAGING			BIT(4)
+
 #define MSR_IA32_UCODE_REV		0x0000008b
=20
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index a42c5ef..8744f3a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -983,6 +983,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo=
_x86 *c)
 	llc_size_per_core =3D (unsigned int)llc_size;
 }
=20
+static __init bool staging_available(void)
+{
+	u64 val;
+
+	val =3D x86_read_arch_cap_msr();
+	if (!(val & ARCH_CAP_MCU_ENUM))
+		return false;
+
+	rdmsrq(MSR_IA32_MCU_ENUMERATION, val);
+	return !!(val & MCU_STAGING);
+}
+
 struct microcode_ops * __init init_intel_microcode(void)
 {
 	struct cpuinfo_x86 *c =3D &boot_cpu_data;
@@ -993,6 +1005,11 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
=20
+	if (staging_available()) {
+		microcode_intel_ops.use_staging =3D true;
+		pr_info("Enabled staging feature.\n");
+	}
+
 	calc_llc_size_per_core(c);
=20
 	return &microcode_intel_ops;

