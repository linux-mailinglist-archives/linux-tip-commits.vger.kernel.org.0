Return-Path: <linux-tip-commits+bounces-4011-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C45A50DC8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ADA3B1ACE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2762580C4;
	Wed,  5 Mar 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dr5Ms9P5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="woz6Yhk1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D2200BBD;
	Wed,  5 Mar 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210586; cv=none; b=VFZpAqC8EQmfv6laiBpOJBG81ynJ+csR9U6vYpRYH1SvqYgE4gU52CupLSFzOMCqvb2GnwVrrzdFLjRlnyd5w0DyziNW+ekKCM5n3nRz8RY/SBZ2jDD+TZMYYHxmgvpVbXUXLkh+LA/HnSRNpDHcswVfeY+QqWjfIlJ+GBHC1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210586; c=relaxed/simple;
	bh=0I0C62Eg0IuQ/vEb/v6pih6oOreEyqt2DYBEd4bM6Ck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IRkkWhyYQB3FD3/3p6Cqfo5dP81HBsmL+JW+/m+0dzd+uNs5MR+GYmG6skwlE7QUqN8/CepBsrRkIWaPnVas3zH7Mkgbu7W366QGYiyLOdUz8268rWazdxT0IcAa5aLwD3xelIvJHMzQ3X/d64kCxaZjAZ+IDtWjtmqCaifZqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dr5Ms9P5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=woz6Yhk1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99GlMlqxBmNIzqets5thWn2elM4WjMXDSvn+1ZxHMbE=;
	b=dr5Ms9P5BNKfHD9BP695YmTY1QFZpyIDSQ3rkOw9u3mXEz8cubtYCA060T0Xiw5z9kX97w
	vC0uL1x7lkp1Cb0LDjfXJlcNQCy27YKEAqX4Ok7DKPFRtQZI0hRav2BLb5rpEhuf9VTtu+
	m7EGANNPwXExGr7C6B2iAC6TInA9zhHYOn4S3gnlECcbdrEApoTV2RFIlLkcqqAVV26L3C
	MJQn4FI0PvB8nu3wocxB/CTCC94kn4MZmIH68rzsTu6SABwrRVoNVyXRvp7+3BhIJ0b1ea
	jb2oZi2k7txqIjDZvYGRzQkAFrp2AlxL9kpP+gyvYsLfThfdCYR7hEuFKj43cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99GlMlqxBmNIzqets5thWn2elM4WjMXDSvn+1ZxHMbE=;
	b=woz6Yhk1z8IGIdhCnJ+2gO6/qFn91PXVwotWHoOSNOZ89s9qElD4Nt30ZCtr5mJWXZNqh4
	qcN8ZnOzfFuD3uAw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Enable AMD translation cache extensions
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-13-riel@surriel.com>
References: <20250226030129.530345-13-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058250.14745.1312436108807852558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b95ef870dcd67c0fbfc57f808c4a0efd0bc2f144
Gitweb:        https://git.kernel.org/tip/b95ef870dcd67c0fbfc57f808c4a0efd0bc2f144
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:47 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 22:18:16 +01:00

x86/mm: Enable AMD translation cache extensions

With AMD TCE (translation cache extensions) only the intermediate mappings
that cover the address range zapped by INVLPG / INVLPGB get invalidated,
rather than all intermediate mappings getting zapped at every TLB invalidation.

This can help reduce the TLB miss rate, by keeping more intermediate mappings
in the cache.

>From the AMD manual:

Translation Cache Extension (TCE) Bit. Bit 15, read/write. Setting this bit to
1 changes how the INVLPG, INVLPGB, and INVPCID instructions operate on TLB
entries. When this bit is 0, these instructions remove the target PTE from the
TLB as well as all upper-level table entries that are cached in the TLB,
whether or not they are associated with the target PTE.  When this bit is set,
these instructions will remove the target PTE and only those upper-level
entries that lead to the target PTE in the page table hierarchy, leaving
unrelated upper-level entries intact.

  [ bp: use cpu_has()... I know, it is a mess. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-13-riel@surriel.com
---
 arch/x86/include/asm/msr-index.h       | 2 ++
 arch/x86/kernel/cpu/amd.c              | 4 ++++
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 72765b2..1aacd6b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7a72ef4..7058533 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1075,6 +1075,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
+
+	/* Enable Translation Cache Extension */
+	if (cpu_has(c, X86_FEATURE_TCE))
+		msr_set_bit(MSR_EFER, _EFER_TCE);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3..dc1c105 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -25,6 +25,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_TCE		15 /* Enable Translation Cache Extensions */
 #define _EFER_AUTOIBRS		21 /* Enable Automatic IBRS */
 
 #define EFER_SCE		(1<<_EFER_SCE)
@@ -34,6 +35,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_TCE		(1<<_EFER_TCE)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
 /*

