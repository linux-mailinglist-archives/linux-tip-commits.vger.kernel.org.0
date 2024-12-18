Return-Path: <linux-tip-commits+bounces-3091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB09F67DF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB687A27B9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D7B1C5CD9;
	Wed, 18 Dec 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EE/oSNYU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRNAj8jM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D01BEF6C;
	Wed, 18 Dec 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530604; cv=none; b=lz9XyFyUIBXeHcoSIjiwV+0fIIJEoo9IPFQV8EuTlSqxkhNe9WWqpPKbaSucQgXL+gUTRx6kAJK7N9/l1Q+WlT80GJI5tU0AaSOimj1TMHHVpD4sKoO3fSLyp00dmnc5MQR/+bsgSjeGnjTC/s4Bh3Vsn/c9ek+LR2UwF1sY1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530604; c=relaxed/simple;
	bh=ONKVGXjIR+vNUZdbkTjsPultC9IRhTAUwrNkhiAqNBo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=psxlRMSwBLR2UGtXDrNox7nqCXKy9X8kt1tFOiYlvv3RX7OyM2vnMJoMVtLyY0gpppNoB/o+z2ykPBw/wiv0f0jhgQkBf8i3AS4o68+hfXh9P+3gd6oct8/tPK0/0zK6TZ+3RdyR52dIIthvV8yOoZMttwIKNBvhC0MBKIUa0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EE/oSNYU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRNAj8jM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mTLEHWhGXRXcA8UeUPAB45V14Y8jJpBm8GIosLGsRJw=;
	b=EE/oSNYUWcAr0L42YQlF7dLPa98wtcwzt7tsFokqP4u6npV6USloHJHMtByIaQFnWNpa2v
	t2svfgwidmbBHu3/XNQXEFuTlFkpw0BPGIxPxuGa2SlioOiPHcUBFGp6Gj4j3gxUSYCGGw
	4ndNtHPM0YPcMC0uvLPe01NM31oJYKflnN9X8GoOdZaDC9r/aVapnDrTxN/bfdMYtkLkk0
	tHHDDTqd3OgxHb4iNNBHz+Zo34uYkNktAwAq2TZksM+uFnJTWNmVMh3ZmBlRwxQ+m761Pj
	DG3HHG1RqU8F8oKnAfYXlNN4/7yuH3xs/nSxaJhkGMwa7lL9Lnsj4o3h3ra4VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mTLEHWhGXRXcA8UeUPAB45V14Y8jJpBm8GIosLGsRJw=;
	b=dRNAj8jMqwKIyHX2GrRCyAY9cPACX38ipt6ADtlQbgvKcvhpyG5DQyj7jdnph8k6qSxZlJ
	ivYSogdU8VCGKHDA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Move TSC CPUID leaf definition
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453059993.7135.13790159616723914717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8f0d085e4d1078407d23beac09d05c074703c147
Gitweb:        https://git.kernel.org/tip/8f0d085e4d1078407d23beac09d05c074703c147
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:33 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:43 -08:00

x86/cpu: Move TSC CPUID leaf definition

Prepare to use the TSC CPUID leaf definition more widely by moving
it to the common header.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205033.68799E53%40davehans-spike.ostc.intel.com
---
 arch/x86/events/intel/pt.c   | 1 +
 arch/x86/events/intel/pt.h   | 3 ---
 arch/x86/include/asm/cpuid.h | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 4b0373b..6081455 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 #include <asm/io.h>
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 7ee94fc..2ac3625 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -37,9 +37,6 @@ struct topa_entry {
 	u64	rsvd4	: 12;
 };
 
-/* TSC to Core Crystal Clock Ratio */
-#define CPUID_TSC_LEAF		0x15
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 8ba4d9f..9b0d14b 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -23,6 +23,7 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define CPUID_TSC_LEAF		0x15
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);

