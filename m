Return-Path: <linux-tip-commits+bounces-4967-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E105DA878EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B51884A35
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6B25E819;
	Mon, 14 Apr 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBdMlInf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUp7u4qO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5E25D8F0;
	Mon, 14 Apr 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616097; cv=none; b=Cq5uZS9QLUL62RG758ih0aJ7IlMAY3qi2bV3J0QNbjAu1ympHMmSmBeMtHMIum0kUiZI2UEexOdS+5GQA+/GNXcy1GaYdoXexhbwltQ4cD/jcpCpi6bJpB0S+AWtBMnFddAcmckI3FhE7EUG+VEqdUaj0yKyNZeKSjrg/fDDuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616097; c=relaxed/simple;
	bh=BbnOsEdNmc3zD8sDqozAFfusGwOVC7ccEYE3521DXBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AeQjCaZvRjngCFUjx2xty6rI4gS/pE6P3ZTZAkP4X1tA/ldxiuRkdwr0kfiyppC7iDAb5bMyBnebnMyaLgbP9fO1v1OcZ1qad5Lw4vH25WDNkJJi7umd10hQzQ34UBOuQ5C4ZiQBsdY72wfuNKAdptxWMfjyYEp2boFQ08BSREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBdMlInf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUp7u4qO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EitfPRLcZHVP5Ahy5o0TyYq2RUR2mXyGRJAgxNLtsH0=;
	b=sBdMlInfP1BiQx9ol9TUXpLCRqW2PN4xbz9lYURhHBTPHexgUoC1Hme876doNRu0BcpnLR
	TfAUTzAXzpPfxbkPwbswH7qTAAyvTWu4dUVFMsuo8xoNRWFzx3PMBlDv+jQ8Fy1uiJUfYq
	AdoYNCj2lKE3T/agbJidI+EVa3TNWdH53fFun0xuROmDj9CfKqvfH4uPEOWj6yOiIvooFd
	nv6ykGxCAu8WWhYbRHY4zX30oisMy7bQLq20UL3uM2aJbLdgcdQbs7H4gchswOq8HX74h8
	8eBnAls4QtpypbIJ6EEd7cR5s6jEuXUqB4PcKdtuMuZiX9wCeC4UqNMwsk8Cxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EitfPRLcZHVP5Ahy5o0TyYq2RUR2mXyGRJAgxNLtsH0=;
	b=UUp7u4qObTU672MHBuCRehHR8WfxX1wT7dIFk9nJEliS9q/K7pCPkFmUO1FlEVqQgxvQ/M
	BmwTliTVcHYtNmDQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu/xstate: Remove xstate offset check
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320234301.8342-2-chang.seok.bae@intel.com>
References: <20250320234301.8342-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461609349.31282.17899934397631644178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     031b33ef1a6a1129a1a02a16b89608ded2eff9be
Gitweb:        https://git.kernel.org/tip/031b33ef1a6a1129a1a02a16b89608ded2eff9be
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 20 Mar 2025 16:42:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu/xstate: Remove xstate offset check

Traditionally, new xstate components have been assigned sequentially,
aligning feature numbers with their offsets in the XSAVE buffer. However,
this ordering is not architecturally mandated in the non-compacted
format, where a component's offset may not correspond to its feature
number.

The kernel caches CPUID-reported xstate component details, including size
and offset in the non-compacted format. As part of this process, a sanity
check is also conducted to ensure alignment between feature numbers and
offsets.

This check was likely intended as a general guideline rather than a
strict requirement. Upcoming changes will support out-of-order offsets.
Remove the check as becoming obsolete.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250320234301.8342-2-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a41d16..542c698 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -216,9 +216,6 @@ static bool xfeature_enabled(enum xfeature xfeature)
 static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
-	/* start at the beginning of the "extended state" */
-	unsigned int last_good_offset = offsetof(struct xregs_state,
-						 extended_state_area);
 	/*
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
@@ -246,16 +243,6 @@ static void __init setup_xstate_cache(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
-
-		/*
-		 * In our xstate size checks, we assume that the highest-numbered
-		 * xstate feature has the highest offset in the buffer.  Ensure
-		 * it does.
-		 */
-		WARN_ONCE(last_good_offset > xstate_offsets[i],
-			  "x86/fpu: misordered xstate at %d\n", last_good_offset);
-
-		last_good_offset = xstate_offsets[i];
 	}
 }
 

