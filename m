Return-Path: <linux-tip-commits+bounces-3913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B36DA4DACE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE303A3995
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054C1FF1DB;
	Tue,  4 Mar 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWy8Fjg4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAYGv/9N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897E1FE479;
	Tue,  4 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084588; cv=none; b=X1ZVg6SdEVI3/bffIk0b4Vzz+ebZ7UnflxSKi8ZFX04ofAeINIAxpY82ZjegEEmqnr4HDI/l7LHcCtPi9pOaXw9M/QT/yHvgX0PhsGXX7GV7mwyt+TEZob0BJLSBPt8+XPo3vpMjhQq0D/6UqzMCfV1pkyugFbwZKnvswyC1ITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084588; c=relaxed/simple;
	bh=e1SARrvbpBB4U/RgDE7VLXbFnK7JnwtNO9GQbkoYQfw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MYbLyWCZP6UArkrux8LIkp3jfvuemUt1PsYbPMcC+RIdyaUjrTTJVq9YKcDNn6o8pxqpZOOijVx7sIAiQ5jp+aCOdR2Xa/W66q7dt8RnFe9qYSSJhvZf8M5FJ9nBa6/BYeedLrrAE1eeE9tRlnX9R1azfFlS2RtShS10AP9pd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWy8Fjg4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAYGv/9N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JlD6mMnwu9LK0aYzSAKHFUrnDdzOyXtbjr0QHYFeKzU=;
	b=JWy8Fjg4bQk8htAz0WEOtuSnVsDHKOazztNBgZ95xafDXZLNlFjFEdXTqaJTR2NzYLV3YB
	dSQ87SN1SCf/jYd8ifviEa6MpmKwfQhKATGLfxSu42qfsTGkcNVajNXxxVGGkHnblLBr0Q
	VszrJp3pxySwk4iBUm9DUcrFytkN9p2IO20z2fnsvW+CdjUGcTJ28RUlP0kPVLuQ8NhX//
	YdO2Ss21aPFcoLLxhb+RkfL6Chcw3BdopSQz/NKuRd+gPIydCznOHBpjI84O3+lr5yZfXx
	vO34vuKQH1GZmYTkPrsC+xOj6atpgj3ekcMRFrplxBM0erFkhWfE2mTEamMs9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JlD6mMnwu9LK0aYzSAKHFUrnDdzOyXtbjr0QHYFeKzU=;
	b=oAYGv/9NSPoyocMNExvcGNohtYgtZroFbt1YbJi7ixT30pGD00W0sD6bq65sjXkT34XAGp
	ev7i8IQnqhOTG5Ag==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame
 pointers
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     05844663b4fcf22bb3a1494615ae3f25852c9abc
Gitweb:        https://git.kernel.org/tip/05844663b4fcf22bb3a1494615ae3f25852c9abc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:21:03 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers

With frame pointers enabled, ASM_CALL_CONSTRAINT is used in an inline
asm statement with a call instruction to force the compiler to set up
the frame pointer before doing the call.

Without frame pointers, no such constraint is needed.  Make it
conditional on frame pointers.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/asm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0d268e6..f1db9e8 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -232,7 +232,11 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
  * gets set up by the containing function.  If you forget to do this, objtool
  * may print a "call without frame pointer save/setup" warning.
  */
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
 #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
+#else
+#define ASM_CALL_CONSTRAINT
+#endif
 
 #endif /* __ASSEMBLY__ */
 

