Return-Path: <linux-tip-commits+bounces-3098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C559F6838
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD716E0ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB161B4227;
	Wed, 18 Dec 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTdYZlGQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDysEePG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77481A23B6;
	Wed, 18 Dec 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531757; cv=none; b=HFvZZmFYQjCembLyQtyVFJ9qTwJ85CZfHLLJvVipvd+hGpBaSugxfezPsFviuAED4vsZNvwgDL2IcyjWbcFd0WB0kWfzhM305oJzxJKKow/Fo+p2+4NIyhb7URjHjDlkV9pvJCiObm3Otq1tZ+vxBGualE+QWKTyGjV5wKg0MFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531757; c=relaxed/simple;
	bh=OepCWIht7N1cOFgQtFNJTrfNIGs+b1m4TFDB/zcFe5U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uezyagfc83oj0T/QViATydct6LchF9BnfjBMcUt+GiC2uzVUOY42PYcPFmcQZMVBcAAQSwHCUtntkWFoo4Aspvj0b1XotDQ5B554rymafGLLoBvpVV3MGkgYHJ/TXLkVP9vaTYnS4TevFv+N5k39swRiAcQyDw20J7KCQoDbIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTdYZlGQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDysEePG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AYUhRtj/CPkEPwneLGhCvpWHNMPjIQjZs92g864b3CQ=;
	b=NTdYZlGQCkIFzvmBmp06bqIiNVT5yAGFRnbhPbtRgkn2SPSWcFVHz9MYmbnNUo0LzkzrZy
	0IaRDEQxgM6slX47CEQlGkStytYM4NKlM4aA+lVD9OpquWAVllqHKLvW6Lr4CqKRddPT1d
	GG8EfI9ngzsbtMxA4MZAVd17Ty5gX6OZ4bdOC6BzGvNlh4urmTZ5WINyb2roKTRE2JyNxu
	PyRF3jW4CtwMDqPur2hxQCYa0o+BKtc3JZOhsL/B0KHpj+j6+r7ChNlrSGWhiQ/o7w57RO
	hoQ95N2GTeXvs8WvKlJ/bftV4LBoDB7hSkZMCA4Xo/d2l/Z6cCYQhKI3yztC4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AYUhRtj/CPkEPwneLGhCvpWHNMPjIQjZs92g864b3CQ=;
	b=eDysEePGwdwJhkuTEW/FkOzXYQV+yDS4YyEVsUxAxfnOspAwpoToI4o9fhrzQ1hOhuyrSU
	0zvtshM2UwPVR+CA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/fpu: Move CPUID leaf definitions to common code
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175311.7135.18250531637951797464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     754aaac3bbf13bdbbed9da94b56f371e90fd9c96
Gitweb:        https://git.kernel.org/tip/754aaac3bbf13bdbbed9da94b56f371e90fd9c96
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:37 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:42 -08:00

x86/fpu: Move CPUID leaf definitions to common code

Move the XSAVE-related CPUID leaf definitions to common code.  Then,
use the new definition to remove the last magic number from the CPUID
level dependency table.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205037.43C57CDE%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpuid.h      | 2 ++
 arch/x86/include/asm/fpu/xstate.h | 4 ----
 arch/x86/kernel/cpu/common.c      | 2 +-
 arch/x86/kernel/fpu/xstate.c      | 1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index e7803c2..a86097e 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -23,8 +23,10 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define XSTATE_CPUID		0x0d
 #define CPUID_TSC_LEAF		0x15
 #define CPUID_FREQ_LEAF		0x16
+#define TILE_CPUID		0x1d
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d4427b8..7f39fe7 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -12,10 +12,6 @@
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
 
-#define XSTATE_CPUID		0x0000000d
-
-#define TILE_CPUID		0x0000001d
-
 #define FXSAVE_SIZE	512
 
 #define XSAVE_HDR_SIZE	    64
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5ffa1f4..f5c33e1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -639,7 +639,7 @@ static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
-	{ X86_FEATURE_XSAVE,		0x0000000d },
+	{ X86_FEATURE_XSAVE,		XSTATE_CPUID },
 	{ 0, 0 }
 };
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 22abb5e..bf38b3e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
 
+#include <asm/cpuid.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
 #include <asm/elf.h>

