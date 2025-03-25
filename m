Return-Path: <linux-tip-commits+bounces-4515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B6A6ECCA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B5F3B6D6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2FA259C88;
	Tue, 25 Mar 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pbKfff+e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBshtQLx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF0258CC0;
	Tue, 25 Mar 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895399; cv=none; b=FHqm41lG5z2ssm76k/5Plj3+6swwGGSqko446G48IqI5FS+7mhkISa8yLsn0j5bKDCDWJWXAwfQtjpbV0U3bAc5fPJ73LH5ODfgW83tA6GYHJvGVZxlxijs3NW4tjoCa83BObKHYaDNlJM/OLk23YQ/6u5wH3C1zRcZoIUSsuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895399; c=relaxed/simple;
	bh=ujQJ5FcI0oPWFOSYLo3PbiThkCD8fBqcJp+FtNZsMXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iETbcvvY1z45IuGjpZ+AbENB8XeMY4rk7ts815IuMQ4mZKMdqnyTVFIlnyarYrKJPBOKERMfnkvAGo1ugMlJRJ7bhONK545fKIRCCST/l7A46RcFKqRwb6ra5sKsZQ/HP2LvGTWZr7OUoMKglE089vQ7hHo4pPscuT7tAHBcy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pbKfff+e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBshtQLx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckMkWFyL15oZPKx/fwQW4ULCNO1G6vjvrnB413H+Xko=;
	b=pbKfff+ecjeMd3e1Qv865oq5fU5x9NHW4QoZC2ITdahlSbmLrIdZF/vxJTcXsPOO5RYtNK
	umx5r3XFoSiQpsCHln0GIhSsX0KcSqWIABVA/ht2a0t+9Vnk6+LJ+CH8bpqrk1tOmuBnXs
	P8XDH2FBEb7az0cZdpJU5FoERxI/6TV7evLAFdoZJ9YH2jaYIpmtatKxUvWvXjKRxsDuSP
	8NoRnhlhgZkM9K7bZcqxUNHhbxx+XBfcMR/C++hHB2BGIomY0EHbcCgguWZdzgIXRT7BBb
	DFc7OWbTNMC9OQSUFGZUQ9ZS2R+o8XOovSx0CDOYGi3I3jk5vh61lUQkNCCRNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckMkWFyL15oZPKx/fwQW4ULCNO1G6vjvrnB413H+Xko=;
	b=sBshtQLx1CmQ2h6mzQd1heeghdOWptJb1bf2Mcur9dfgyYxEfvRit51dilgSOL7rdF1TAH
	8w4uryDj8fifmcBg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Use CPUID leaf 0x2 parsing helpers
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-5-darwi@linutronix.de>
References: <20250324133324.23458-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539531.14745.15757204719873652263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a078aaa38a23a2595addb14ac286d8b8ae793d39
Gitweb:        https://git.kernel.org/tip/a078aaa38a23a2595addb14ac286d8b8ae793d39
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:32:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:10 +01:00

x86/cacheinfo: Use CPUID leaf 0x2 parsing helpers

Parent commit introduced CPUID leaf 0x2 parsing helpers at
<asm/cpuid/leaf_0x2_api.h>.  The new API allows sharing leaf 0x2's output
validation and iteration logic across both intel.c and cacheinfo.c.

Convert cacheinfo.c to that new API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-5-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 36782fd..6c61080 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <asm/amd_nb.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid.h>
 #include <asm/mtrr.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
@@ -783,29 +784,16 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		u32 regs[4];
-		u8 *desc = (u8 *)regs;
+		union leaf_0x2_regs regs;
+		u8 *desc;
 
-		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-		/* Intel CPUs must report an iteration count of 1 */
-		if (desc[0] != 0x01)
-			return;
-
-		/* If a register's bit 31 is set, it is an unknown format */
-		for (int i = 0; i < 4; i++) {
-			if (regs[i] & (1 << 31))
-				regs[i] = 0;
-		}
-
-		/* Skip the first byte as it is not a descriptor */
-		for (int i = 1; i < 16; i++) {
-			u8 des = desc[i];
+		cpuid_get_leaf_0x2_regs(&regs);
+		for_each_leaf_0x2_desc(regs, desc) {
 			u8 k = 0;
 
 			/* look up this descriptor in the table */
 			while (cache_table[k].descriptor != 0) {
-				if (cache_table[k].descriptor == des) {
+				if (cache_table[k].descriptor == *desc) {
 					switch (cache_table[k].cache_type) {
 					case LVL_1_INST:
 						l1i += cache_table[k].size;

