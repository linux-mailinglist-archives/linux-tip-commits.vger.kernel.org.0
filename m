Return-Path: <linux-tip-commits+bounces-4352-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03275A68ABF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2179A885350
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864225A2AE;
	Wed, 19 Mar 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Mqh7gLo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3I68Bw+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BF258CD2;
	Wed, 19 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382227; cv=none; b=enOEaL/RojZpknQESDXULledW3rf3JyHBqrapL234PzmRfUi6hqpGgK2Kx3UPSa5VrMnYCINFQ3Acg/BrO1SvzisKKDdPdbEW7UDqLHxQZOOyy0RCSO2w1+q/AuWu35lz9J1p28pAY5B5MZJAPrs6WZg7WfIZAPbicqBYdWB1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382227; c=relaxed/simple;
	bh=dGGQsmplpjbn4Dhc18NRPeRsGR5PC+ckVxQzt49/4ks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jTGDgwck2KOoIpI1AKGB4JtWoOt4hbatE1lq1g/2e8r0YgC3i7irn1OOGf5v3MNDbHerXFpVwI4pAVqbgn4NYWlCJqu/9ss8JNSk+EAO4A/MLkJsQs/LXd3yavTCIpRFu5XfcUpGMF3lgZx9BAangpEz39eu1jDriO4LrZ8KGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Mqh7gLo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3I68Bw+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCTuq6KSJLy2mbDo6j5D93bIKaA2HonRRybVnkvQOWc=;
	b=3Mqh7gLoqprqI/nVrdQPX66bfbZFFERi1lepjU6Irtjxss64PB4BYZHWY9PG37yRwRDOOr
	Wd77u9okcCsEkumlIU6kAMoWgXMT/v/NKducpyYSk2hNBABFVh0qSA17/tG308/c+c5o3Z
	oC32K565zaW8TxR3oQQqyhLCx4Pr4Gq78vlG6ju5QPvoPeBmO8kD0ZbPkPMsEmG5rN11HF
	Ert1ye4M8TKqgJ4SfQ5djElsj2JkSCpf9FnjL/CQgHc/cwMJ4UzKYRk6hgbZqD/CXxajZH
	2QA/L7O/Pbjh1xOzoaPVaKATPxcrx34Q/mCVQvRXGocOmmqkZct7r5dpDNHhjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCTuq6KSJLy2mbDo6j5D93bIKaA2HonRRybVnkvQOWc=;
	b=y3I68Bw+UobvSsF7dmj/LeTL9wPNt7Iol6rG6+RgFA725So1pMlp9Gz2Cy0X5Q7dl9N9Cw
	Fz/bjm220TQnVyDg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu/intel: Fix the MOVSL alignment preference for
 extended Families
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-3-sohil.mehta@intel.com>
References: <20250219184133.816753-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222360.14745.18333954428435041468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7e67f3617228318da655dc87bc705f9c5f7bb101
Gitweb:        https://git.kernel.org/tip/7e67f3617228318da655dc87bc705f9c5f7bb101
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:31 +01:00

x86/cpu/intel: Fix the MOVSL alignment preference for extended Families

The alignment preference for 32-bit MOVSL based bulk memory move has
been 8-byte for a long time. However this preference is only set for
Family 6 and 15 processors.

Use the same preference for upcoming Family numbers 18 and 19. Also, use
a simpler VFM based check instead of switching based on Family numbers.
Refresh the comment to reflect the new check.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250219184133.816753-3-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/intel.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291c828..99b4c40 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -440,23 +440,16 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
-
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	/*
-	 * Set up the preferred alignment for movsl bulk memory moves
+	 * MOVSL bulk memory moves can be slow when source and dest are not
+	 * both 8-byte aligned. PII/PIII only like MOVSL with 8-byte alignment.
+	 *
+	 * Set the preferred alignment for Pentium Pro and newer processors, as
+	 * it has only been tested on these.
 	 */
-	switch (c->x86) {
-	case 4:		/* 486: untested */
-		break;
-	case 5:		/* Old Pentia: untested */
-		break;
-	case 6:		/* PII/PIII only like movsl with 8-byte alignment */
+	if (c->x86_vfm >= INTEL_PENTIUM_PRO)
 		movsl_mask.mask = 7;
-		break;
-	case 15:	/* P4 is OK down to 8-byte alignment */
-		movsl_mask.mask = 7;
-		break;
-	}
 #endif
 
 	intel_smp_check(c);

