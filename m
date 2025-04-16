Return-Path: <linux-tip-commits+bounces-5011-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E9A8B33C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B8B16B499
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C29235360;
	Wed, 16 Apr 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pRKj3Uj4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmT+AOsi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44A233D99;
	Wed, 16 Apr 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791448; cv=none; b=fp8oLozYZ6AnOuc3QpZlnXFCBYSRqQTiEPHskeupMnI8oNti5ozj4M+8FdcKIINdWDfCDsSsCyampe4naOwQGVPGol4QDF0ovcGBgJHMOBWHOkhEVduPw4DK97rRYGappkrgLsTk9Ao4lwTOy6OYO55/T7+7jujUPwsZcftwPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791448; c=relaxed/simple;
	bh=O6U9L/GDpTxJ/C0Q1lEFP/UOtuwtNahlYHDGSF31/lg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZdsXQrdXetrF4JaRAZ/1ZTkDt5q4NG2KOdZdMMmYUX8jNJmpgdk3Tof4bOmG02B9Scbee7Co4J8+O12ip4CJOkhP9nThf/uJrN3eKQwyoF6RsY9wPy+TU5xo2VqnHaMpr886zmOoP6eFxIsUP9QgSVTGLoajC8erBmBWUrPnWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pRKj3Uj4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmT+AOsi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymomHhGJrk96U+g98Vn35z0YTRnnikt/pkEedxF152I=;
	b=pRKj3Uj4XRGKh/spcCrU+VnSG0Kf73BmgqJOBCkN6U9Q7yE9vh1q7OK0GiAbhaoG1xdNoV
	3grjO9OFtddX4zulW0+rcD7PdkN/3SaGHU6yz/bHOxs4HCi/aoqdJ6KrPzi525IeZdhxla
	SYt4qcSfqy90edxK1uKNZ9kGYVDiy+8zIv8bms/otgAeablXWHncIw99xq5Pxx8i6MeDWu
	bXwaQTqOGrRDfJU9N+fWXcx4gKwEjTkWrOpjKWvpSO5jy/n9ev+FHFfvAkV5yVErBX0/ch
	0GPX/+r7hmLQLqUPHa+Slc+BJy6xXZT8O5l/boJhPPiUwwjsyv4GVE8AL4Krmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymomHhGJrk96U+g98Vn35z0YTRnnikt/pkEedxF152I=;
	b=hmT+AOsiSJhy+ZvGqDzU7lpFSpEWUTN5eDjvThoEI2yhlqBFQR5CSIVTEfYk3SY/2VmAXs
	TDYdKdzNw//ii5Dg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/cpufeatures: Add X86_FEATURE_APX
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-2-chang.seok.bae@intel.com>
References: <20250416021720.12305-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479144436.31282.15337641551401312247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b02dc185ee86836cf1d8a37b81349374e4018ee0
Gitweb:        https://git.kernel.org/tip/b02dc185ee86836cf1d8a37b81349374e4018ee0
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:44:13 +02:00

x86/cpufeatures: Add X86_FEATURE_APX

Intel Advanced Performance Extensions (APX) introduce a new set of
general-purpose registers, managed as an extended state component via the
xstate management facility.

Before enabling this new xstate, define a feature flag to clarify the
dependency in xsave_cpuid_features[]. APX is enumerated under CPUID level
7 with EDX=1. Since this CPUID leaf is not yet allocated, place the flag
in a scattered feature word.

While this feature is intended only for userspace, exposing it via
/proc/cpuinfo is unnecessary. Instead, the existing arch_prctl(2)
mechanism with the ARCH_GET_XCOMP_SUPP option can be used to query the
feature availability.

Finally, clarify that APX depends on XSAVE.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-2-chang.seok.bae@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bc81b9d..478ab36 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -481,6 +481,7 @@
 #define X86_FEATURE_AMD_HTR_CORES	(21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
+#define X86_FEATURE_APX			(21*32+ 9) /* Advanced Performance Extensions */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 94c062c..46efcbd 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -28,6 +28,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_PKU,			X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_MPX,			X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XGETBV1,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_APX,			X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_CMOV,			X86_FEATURE_FXSR      },
 	{ X86_FEATURE_MMX,			X86_FEATURE_FXSR      },
 	{ X86_FEATURE_MMXEXT,			X86_FEATURE_MMX       },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c75c57b..dbf6d71 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -27,6 +27,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,		CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,			CPUID_ECX,  3, 0x00000006, 0 },
 	{ X86_FEATURE_INTEL_PPIN,		CPUID_EBX,  0, 0x00000007, 1 },
+	{ X86_FEATURE_APX,			CPUID_EDX, 21, 0x00000007, 1 },
 	{ X86_FEATURE_RRSBA_CTRL,		CPUID_EDX,  2, 0x00000007, 2 },
 	{ X86_FEATURE_BHI_CTRL,			CPUID_EDX,  4, 0x00000007, 2 },
 	{ X86_FEATURE_CQM_LLC,			CPUID_EDX,  1, 0x0000000f, 0 },

