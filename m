Return-Path: <linux-tip-commits+bounces-3088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290349F67D9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4117A16B54B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A31BEF6A;
	Wed, 18 Dec 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQR9wkEV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9kAgnlh9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67751B0405;
	Wed, 18 Dec 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530602; cv=none; b=R21vhSJuh7lgo1xrzVQL5LXcDbqyEp5AQXfcFlEn4P1IK8w5xSU1rQvJAandsytkUSrAsy1ZR4TLEOGbheUa4iFF8So4RGMqYry3WtLydNBCRx5xMq/DvMZ9Cvzu+ixg3myrGKFbWlok8VDEajHWdard1Q43vbwgrHnyPySZcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530602; c=relaxed/simple;
	bh=KXznSwTlU+51djthLqnOxeCaxI2uM8ozMgLv7aMdOBM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mxazg5JfJ1+n4HDnH5ywu/FMR5rzHG8spXFXdObkFmhZBRhxMe9Va6MnhIjy48ndmW/DNHPiNDzUIXsdmtsSD7YBF6B8GOWOWtHOOq/Cbl+aBZzNuhwAN0ymVMlCGOh3F33eUwV2xWPqAGHDEiledUIPb2WTL8SHLMflBIOaTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQR9wkEV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9kAgnlh9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J+9MPIOjMQqW3H+StmMyv+i7XKntL1dQs9tfJOeSlQY=;
	b=mQR9wkEVFxhxzBkqklo1nwrtZmiD6ogseg8hhtk6z6Q7DaFcg2L2JE5w9CHQKqV3mBO2hU
	xKxSL631/DSPLd3ONACDnXIlxdb4zQN8JxwSyvmOMgRej1wtAzi75RRy1wHIUBKmC09lr8
	W9/ajkmGl9Hc+kum+46gXSZzJtuPxioxalrd0HmUBxPXp3VwosCum7jhpurwAi+R8ZtcBG
	wUKLLD+aU90EZ7igjx9bZdhrPmNyKdn30lIuXgje8tv5MVFdSDl/HE2zsllKrCI3JcRhnS
	DsIH8wMIOxTi7w+zMqlDy7kI6b3UQDZ37M5+gVLdO3953Edgv/0iXRJa83p5bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J+9MPIOjMQqW3H+StmMyv+i7XKntL1dQs9tfJOeSlQY=;
	b=9kAgnlh98tli9gV2t3PWPRfURZkQ+zQZeMiDlPuHlJYJPR4ZgEXt8Kpx3iwR/N6EzTErQs
	p5WwrdJXSJ+pqqCQ==
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
Message-ID: <173453059679.7135.4767647940058902790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0a90ece4b53b46e2ae0a9438677822de9c57c4db
Gitweb:        https://git.kernel.org/tip/0a90ece4b53b46e2ae0a9438677822de9c57c4db
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:37 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:43 -08:00

x86/fpu: Move CPUID leaf definitions to common code

Move the XSAVE-related CPUID leaf definitions to common code.  Then,
use the new definition to remove the last magic number from the CPUID
level dependency table.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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

