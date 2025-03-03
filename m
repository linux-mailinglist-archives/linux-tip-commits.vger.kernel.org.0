Return-Path: <linux-tip-commits+bounces-3795-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDEA4BE1D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFE8164718
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692CC1F4CB0;
	Mon,  3 Mar 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdUgXYpa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+I2RLATJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BE1F4161;
	Mon,  3 Mar 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000370; cv=none; b=LKqCLIvsOImNzI18ULCtmAhNXw3VkG+uhHe4LWiHOKmuxFyHgPKwZ0u8CGwU/D3DKdD6gocSmACt9ficfc2TdRHKrCUOXVjpAUkdi0lA7nUSTjEKUhAJEk53s/3pwJcKYP/uaM/fHlrmaJVDhL1SmGfZzTbtRBQHPVghhqMFV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000370; c=relaxed/simple;
	bh=ahjmgJYDw+8twcIuj1CA7pYsDGp1tY0FUDr0YjMWKUs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qfO352NGMLHnTqsVPIVE3lSiTvyLaeNfK4gh69di2QUF4Pl3QqHH1djJe86Q0AqFFm3XSR8ct6eRqfgduJZ4jLI4kvD9wRPX5skqEzo2UvyvIWlQjoAkQvKYCEDIWewTulBJr/zrtZVCnTwTWDsI65bwQl0GTkZRlgMAwQBFJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZdUgXYpa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+I2RLATJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:12:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gc8q9STxMxo2Nk1OCA3Ak5V9SYnqBUBVhH8/jL7oC8k=;
	b=ZdUgXYpaFr5Go8mCNoUIit3TzOv8GoES2ME+fxAiHOU7kDOj7noORWAfnYVyt/xBDroTXA
	6xTHsVOtwTte4HBCYhocdaBkM83q6N5Y9sT8EyIfSBBMRPSJx8zawpwGZFMA5tR5A5RXbq
	Y8SlzUzZAIOQFKVI7x8CHA3UEvlGLt25Fzp+iWYuo009CiccVZJiDM3eSa/jbJWjt92s6s
	qBZzqQG7Wg+b4azqwBivwm72VlqufprlhAGWiT1NetHMljh91AbG+ohZSfL9grA0yxa03h
	xLOp6mzjqBg/lYKZF3CWNGZiR7MVtdyTo7GA7QoeLn9wga6xjw3abhPvMGb3XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gc8q9STxMxo2Nk1OCA3Ak5V9SYnqBUBVhH8/jL7oC8k=;
	b=+I2RLATJfySIytch5vKNcqH2VO0pL5irMeZxeYPzucloQeQ3LZeAZSWdz8mWaxAks/cjp5
	DvohfaH2Ll5SR1Bw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/speculation: Simplify and make CALL_NOSPEC consistent
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com>
References: <20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174100036652.10177.5645930763525779591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     010c4a461c1dbf3fa75ddea8df018a6128b700c6
Gitweb:        https://git.kernel.org/tip/010c4a461c1dbf3fa75ddea8df018a6128b700c6
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Fri, 28 Feb 2025 18:35:43 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 12:04:42 +01:00

x86/speculation: Simplify and make CALL_NOSPEC consistent

CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
indirect branches. At compile time the macro defaults to indirect branch,
and at runtime those can be patched to thunk based mitigations.

This approach is opposite of what is done for the rest of the kernel, where
the compile time default is to replace indirect calls with retpoline thunk
calls.

Make CALL_NOSPEC consistent with the rest of the kernel, default to
retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
enabled.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78..1e6b915 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -424,16 +424,11 @@ static inline void call_depth_return_thunk(void) {}
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
-# define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+#ifdef CONFIG_MITIGATION_RETPOLINE
+#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#else
+#define CALL_NOSPEC	"call *%[thunk_target]\n"
+#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

