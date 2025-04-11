Return-Path: <linux-tip-commits+bounces-4888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5363A8592F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9889A3540
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28796278E50;
	Fri, 11 Apr 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1GaWGOa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+vmMGce"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131E278E46;
	Fri, 11 Apr 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365751; cv=none; b=UAYK0ws1h+bGEQ13sGS6DGbQeB5L8Lkxzl0fxlAKQ8VYDM3iN+GO9U33HjBk+x0OdMik7dlyCrDugk7ZT2kjTWfybdRqBO3j2VCichxYXhlFJeQV4YtOMmdTDaanw51gBxJxHoEjWS6vCm/rjcKUGeYwvLwcn59strmFN4irUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365751; c=relaxed/simple;
	bh=//L9wHAzF3eebKc5sAG6ZjvkftFhn91/cYdr6nzTJ5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xfj61c/SprhmVQj4QBI+UiUBe4pu1xj/N+PSuoI7pXVpSfjnkcBZMjqOb5g7IZhfBhE3YefHABZrs8TvXzZpf1WtosgvxYZQPKUKxexPHR12cRCHXPrsyRpWXtpulS8gI6R8QMTeZufeIDiiMXM4+0K6175FhD0BYH+ivvYtQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1GaWGOa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+vmMGce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkxZ7G/2KJvak1pRxCVMTByFiVlrIMnTYZDNguNtf3o=;
	b=z1GaWGOaK5Ji3fZFeOx/JzquE7vfNzX8jUVv0p6kn7vWX2H33RoXjTwsmP7UjsQuGvdIjZ
	L7Q23IGTdEWFzkZBuGRLATu4150JwRdRLsyNRbIIIxrSmLY2wHEWeR9AVAP0LpbQ2RQ9U1
	JaXWExd4DGF3AbCrDxNCdK2JNYgVDv+iW+kRsm0BOLvBymscEUd4zQo5+dwBCzDw6HTBpx
	kwdF1zcxNIlYl2jhpA6C2iUZ2bmKMyAaN+JLG6+MyY3mzpdJDrDq9dWIJcB83OfD8HEKil
	E7AU19itiNyq4XmbLIVK08M+xXIwo8EAFKprE3BNnCcnhmxhymgJE7oaB+wVRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkxZ7G/2KJvak1pRxCVMTByFiVlrIMnTYZDNguNtf3o=;
	b=0+vmMGceBudiTJ/gBnOpd3QITWBbH5349FqAUorlmR1oIxwveKtAifPPabr1Gn0qf85Dxs
	hI16DPJJHI308nBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Remove obsolete CPUID(0x2) iteration macro
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250411070401.1358760-2-darwi@linutronix.de>
References: <20250411070401.1358760-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436574746.31282.4756584311521374900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     718f9038acc53631cc887676b9c433e6fb9f15dc
Gitweb:        https://git.kernel.org/tip/718f9038acc53631cc887676b9c433e6fb9f15dc
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Apr 2025 09:04:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:14:55 +02:00

x86/cpuid: Remove obsolete CPUID(0x2) iteration macro

The CPUID(0x2) cache descriptors iterator at <cpuid/leaf_0x2_api.h>:

    for_each_leaf_0x2_desc()

has no more call sites.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250411070401.1358760-2-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/leaf_0x2_api.h | 23 +----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/leaf_0x2_api.h b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
index 46ecb15..09fa307 100644
--- a/arch/x86/include/asm/cpuid/leaf_0x2_api.h
+++ b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
@@ -41,29 +41,6 @@ static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 }
 
 /**
- * for_each_leaf_0x2_desc() - Iterator for CPUID leaf 0x2 descriptors
- * @regs:	Leaf 0x2 output, as returned by cpuid_get_leaf_0x2_regs()
- * @desc:	Pointer to the returned descriptor for each iteration
- *
- * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
- * @regs.  Provide each descriptor through @desc.
- *
- * Note that the first byte is skipped as it is not a descriptor.
- *
- * Sample usage::
- *
- *	union leaf_0x2_regs regs;
- *	u8 *desc;
- *
- *	cpuid_get_leaf_0x2_regs(&regs);
- *	for_each_leaf_0x2_desc(regs, desc) {
- *		// Handle *desc value
- *	}
- */
-#define for_each_leaf_0x2_desc(regs, desc)				\
-	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
-
-/**
  * for_each_leaf_0x2_entry() - Iterator for parsed leaf 0x2 descriptors
  * @regs:   Leaf 0x2 register output, returned by cpuid_get_leaf_0x2_regs()
  * @__ptr:  u8 pointer, for macro internal use only

