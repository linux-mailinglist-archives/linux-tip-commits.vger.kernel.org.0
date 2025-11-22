Return-Path: <linux-tip-commits+bounces-7471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA8C7D383
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FC357318
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C382FC87E;
	Sat, 22 Nov 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBBZO0aj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGgLN5JD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519952F0C46;
	Sat, 22 Nov 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826527; cv=none; b=tff6TmfJf0hyEfU1slp76t4Ha+UdDOKEPs3CirmEm4tMFAZg/8HFneP5JSZ6syYF967mUhQW4WcoQ5x8AD+C6fKDB/fKUAfQGSU4gkBEE1rmAhdforqLFWnlxbKLXGCBZ+M8A21KVbr9A1r4plDkqR/LMXfuQp6FqqrAt+sr3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826527; c=relaxed/simple;
	bh=blnP7RJgnibSYACHc3nQNdHxr1c2IWCXd0D387TwscE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ckGS6FU45ybPSPmsA+LzRIt3CLPfGTEKEyuz2SL+R73Cb5GnI7WO/EjrZ6G18K+0bKVMK6+BwjpcCOJEPZYbKrIY4jS9xlgaPsgiuWIA7bqj95sD3H29vurc+wEv6RYaAQL4OAUGvo7q7N49spba8m4D9l75ve+N8IWtrRG+G5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBBZO0aj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGgLN5JD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCNYwGakVH+qFC305H9G/wDF5TOFs9xNLdmEqoP97oY=;
	b=TBBZO0ajWDbfgknRwa7HsDmCXN6D4Pa8YJoYnbnxTbObMqFpzYgvrWZ0xn9Jx+6KvYjvOC
	ZM3k86+PqzQegC9YkuFvtVwqI5jw/VHGdmgT03fhfJQ2eLGnJ94ugXEnu1GirMAdHoViw/
	+BwSDl2G647sXsmxw1Xf/em5cOb3Ohm4qTVk6yEP12mVC0FWQ8RV5cViJeEhaMDm1Sehve
	K9CNPdiaYYk+FFvoOMd24Ev/feYBvSCwzE9W8kWfMXJIDCL2sfVMCK92Z32P6P7cK9OXPm
	+04hhQPQfaZGV27zQ80YiUlvaEv11cCsXvuGMQgWge8ZAUczHWOj4QyCORyH0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCNYwGakVH+qFC305H9G/wDF5TOFs9xNLdmEqoP97oY=;
	b=HGgLN5JDGKZcSm2GuqZxKYPJVyw9d9vhfsca5JSsVnMiC0zLm9rE81l1ZPwMujbWs+Bj1F
	ylhg17HyKjm6IKAA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/cpufeatures: Add support for L3 Smart Data Cache
 Injection Allocation Enforcement
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <83ca10d981c48e86df2c3ad9658bb3ba3544c763.1762995456.git.babu.moger@amd.com>
References:
 <83ca10d981c48e86df2c3ad9658bb3ba3544c763.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382652244.498.3703313676953019180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3767def18f4cc394dc98cb93e78c3cc9afc4c515
Gitweb:        https://git.kernel.org/tip/3767def18f4cc394dc98cb93e78c3cc9afc=
4c515
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:27 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 22:03:07 +01:00

x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enf=
orcement

Smart Data Cache Injection (SDCI) is a mechanism that enables direct insertion
of data from I/O devices into the L3 cache. By directly caching data from I/O
devices rather than first storing the I/O data in DRAM, SDCI reduces demands =
on
DRAM bandwidth and reduces latency to the processor consuming the I/O data.

The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software to
control the portion of the L3 cache used for SDCI.

When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
partitions identified by the highest-supported L3_MASK_n register, where n is
the maximum supported CLOSID.

Add CPUID feature bit that can be used to configure SDCIAE.

The SDCIAE feature details are documented in:

  AMD64 Architecture Programmer's Manual Volume 2: System Programming
     Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
    Injection Allocation Enforcement (SDCIAE).

available at https://bugzilla.kernel.org/show_bug.cgi?id=3D206537

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/83ca10d981c48e86df2c3ad9658bb3ba3544c763.17629=
95456.git.babu.moger@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 4091a77..2abee3e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -500,6 +500,8 @@
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Coun=
ters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
=20
+#define X86_FEATURE_SDCIAE		(21*32+18) /* L3 Smart Data Cache Injection Allo=
cation Enforcement */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index 46efcbd..87e7858 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_SDCIAE,			X86_FEATURE_CAT_L3    },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index caa4dc8..d113863 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -53,6 +53,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
+	{ X86_FEATURE_SDCIAE,			CPUID_EBX,  6, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },

