Return-Path: <linux-tip-commits+bounces-3084-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D09F5C03
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F58B168E90
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7A13AD22;
	Wed, 18 Dec 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EmuP3beW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HnQLuZuN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A0130499;
	Wed, 18 Dec 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483622; cv=none; b=C420XhIFnE0RYt+GGNHc/pg8niVqsb9ebuL7/ylaJUUC15FRcBdMXhuMPBVTklNf/fAyzZf1toD3r2KfTJPq1WREQ7b0Uih0Qw/oMZFDa80fhoyW5SqBB1SPbGb5HvSA0lFGhsSDcG2SMpn5W8GUnlmrVlPA49gi/wcuCpR0Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483622; c=relaxed/simple;
	bh=DJ227+BzVIKNNiysyWQx0zlyekooA3KAViN4IvH6pig=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FTox6F1CdjRqXCFBVHzELqLDY1P5IO5gayQAUfoNIgWra703JBajMg0f4WQcFsE8rUmBJEjjlPm7+WQEbrgIxoY2YTYID8C7k1YBxJti4K4VACzEWQdzB6PXbFBxAMh+d/fglG3srFDBDCba4mbXTuQO61RhkFwozq06Dgi8SLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EmuP3beW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HnQLuZuN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 01:00:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734483618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zAyjp6wSv/J0qi8WHYRXmD8X861vKPnt2Fi7wxBz13E=;
	b=EmuP3beWhgxdnu/24dqDTb/FhK/60WWmHPbEucQpuhDBEWsrwEBw3lDBiYqqAvwsNuJYYJ
	y9AkxHJS+d3GhFYb2P8X04PlBxOPJgE5uxJ3YwzLOByDzqF4z+k2yUvpkItDWGWcN4JKCQ
	eFRhu0iVfW8ZerHHQsVd7qoGoDwKRYwRxeIbrKOLjU1yYhTLRbP0EdYR91XllEMcDzD1BT
	q5pAnyIDmHeCySqxvsTVB8mEHvB/bx7PNMZk2/o67O8LVrKD/H0ejRDp39clMVry4GUWbu
	XRTm71GB/YgE5+xum0w/ORCmW9zMXS1w67pXoEU2PcGUCaCJvITgR6ZeOfj4XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734483618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zAyjp6wSv/J0qi8WHYRXmD8X861vKPnt2Fi7wxBz13E=;
	b=HnQLuZuNbRZUPRj2IwKbYjj4JTll6+MzZraCxUKudMMZIzAHLLNSdAXpFD3Jsn7uwk2V8V
	Sk4daLLKbxEYfIBg==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove 'x86_cpu_desc' infrastructure
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173448361172.7135.15505935935362312264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     58d3a643fda70211058a8ec0237597652ec1b75d
Gitweb:        https://git.kernel.org/tip/58d3a643fda70211058a8ec0237597652ec1b75d
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 10:51:33 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Dec 2024 16:19:57 -08:00

x86/cpu: Remove 'x86_cpu_desc' infrastructure

All the users of 'x86_cpu_desc' are gone.  Zap it from the tree.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213185133.AF0BF2BC%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 35 +---------------------------
 arch/x86/kernel/cpu/match.c          | 31 +------------------------
 2 files changed, 66 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 88564bb..ba32e0f 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -243,42 +243,7 @@
 		VFM_MODEL(vfm),				\
 		X86_STEPPING_ANY, feature, data)
 
-/*
- * Match specific microcode revisions.
- *
- * vendor/family/model/stepping must be all set.
- *
- * Only checks against the boot CPU.  When mixed-stepping configs are
- * valid for a CPU model, add a quirk for every valid stepping and
- * do the fine-tuning in the quirk handler.
- */
-
-struct x86_cpu_desc {
-	u8	x86_family;
-	u8	x86_vendor;
-	u8	x86_model;
-	u8	x86_stepping;
-	u32	x86_microcode_rev;
-};
-
-#define INTEL_CPU_DESC(vfm, stepping, revision) {		\
-	.x86_family		= VFM_FAMILY(vfm),		\
-	.x86_vendor		= VFM_VENDOR(vfm),		\
-	.x86_model		= VFM_MODEL(vfm),		\
-	.x86_stepping		= (stepping),			\
-	.x86_microcode_rev	= (revision),			\
-}
-
-#define AMD_CPU_DESC(fam, model, stepping, revision) {		\
-	.x86_family		= (fam),			\
-	.x86_vendor		= X86_VENDOR_AMD,		\
-	.x86_model		= (model),			\
-	.x86_stepping		= (stepping),			\
-	.x86_microcode_rev	= (revision),			\
-}
-
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
-extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 2de2a83..1a714f7 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -56,37 +56,6 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 }
 EXPORT_SYMBOL(x86_match_cpu);
 
-static const struct x86_cpu_desc *
-x86_match_cpu_with_stepping(const struct x86_cpu_desc *match)
-{
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-	const struct x86_cpu_desc *m;
-
-	for (m = match; m->x86_family | m->x86_model; m++) {
-		if (c->x86_vendor != m->x86_vendor)
-			continue;
-		if (c->x86 != m->x86_family)
-			continue;
-		if (c->x86_model != m->x86_model)
-			continue;
-		if (c->x86_stepping != m->x86_stepping)
-			continue;
-		return m;
-	}
-	return NULL;
-}
-
-bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table)
-{
-	const struct x86_cpu_desc *res = x86_match_cpu_with_stepping(table);
-
-	if (!res || res->x86_microcode_rev > boot_cpu_data.microcode)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);
-
 bool x86_match_min_microcode_rev(const struct x86_cpu_id *table)
 {
 	const struct x86_cpu_id *res = x86_match_cpu(table);

