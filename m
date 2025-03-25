Return-Path: <linux-tip-commits+bounces-4438-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D934A6EACD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EFF16B340
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D59253F1F;
	Tue, 25 Mar 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u8UG49ps";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cl66EE0p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C511C6BE;
	Tue, 25 Mar 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888781; cv=none; b=QolNSMaOOEag9TXZ9ry0YEeSzcm8vCC08hC6BHt53JQVdbMGoqlLbvQOhVqiffrUV0jJm61KkArGn59D7buZ7bYWzB0FHXGgORoPC5f7vx7NWPLaaq0O3zIoH8AYrMbm54eeMzqKm52XSxG9Kf6cpTTuONdAqV0VQ33gXsgzHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888781; c=relaxed/simple;
	bh=fOTQI33fCywQcHYCKWm71893XqjWexah1qqeBVtb9OU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z/xpuxrJyH33f9zcGoreGKDX4jyymxmoPUeeoRzidJfQ5gWZ7dc7WHxj0qwfreUvDnMVj4TvWLjJoz9w5sk+FPnKSU4iugI/yqhumPhWpoD2vu9X0PW42dkG6/kPXFh0BmEjQllIxqcioUZ1fSU1yV/RnL2oU4UkG04Js1S5HCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u8UG49ps; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cl66EE0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Hl8J2E4prjoi30gTms+5b2r7UoGQSN4jQRmbg2cIgA=;
	b=u8UG49psMLD5Gsq2QWf/S3gt7M9Hlx18aob0gT0Hrp8kfjayArLefi0nBjGULx4WzSN+nH
	eK8vxMUJTF0vfVaxPTgmnU+XN2kvIrlj9vxD9yUS/1eOv+qSn5iOjuVs04BZLGg9C4k65S
	mcVYXTwD2Am9BUqerqHvi4uAxgzPuMl7xHzmKbCwwzU+tTPxfZMbEt8Rl7ninb+D55nh4Z
	c6Kn/TfFdf8RD9h8+iPLrcWUTxe4Pi/lAlHkS9hF+0qDk4h1jeum1JLVlA2AHEM7TR1yTl
	1ohWIRIuiRGfEPUlZThSKeiMIlEid9Vi0rn0+omJT6dHkRl+73r2xhL3pWw53w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Hl8J2E4prjoi30gTms+5b2r7UoGQSN4jQRmbg2cIgA=;
	b=Cl66EE0pWu2XVm/r7pO5r+472YwrEXqn22skLDiUAjl/sXoMIYiNrCQjIzdA1ARtN9COto
	ynsel012dU9fS1Ag==
From: "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/entry: Fix ORC unwinder for PUSH_REGS with save_ret=1
Cc: Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250325-2025-03-unwind-fixes-v1-1-acd774364768@google.com>
References: <20250325-2025-03-unwind-fixes-v1-1-acd774364768@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288877681.14745.1013174676126785609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     57e2428f8df8263275344566e02c277648a4b7f1
Gitweb:        https://git.kernel.org/tip/57e2428f8df8263275344566e02c277648a4b7f1
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Tue, 25 Mar 2025 03:01:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:30:43 +01:00

x86/entry: Fix ORC unwinder for PUSH_REGS with save_ret=1

PUSH_REGS with save_ret=1 is used by interrupt entry helper functions that
initially start with a UNWIND_HINT_FUNC ORC state.

However, save_ret=1 means that we clobber the helper function's return
address (and then later restore the return address further down on the
stack); after that point, the only thing on the stack we can unwind through
is the IRET frame, so use UNWIND_HINT_IRET_REGS until we have a full
pt_regs frame.

( An alternate approach would be to move the pt_regs->di overwrite down
  such that it is the final step of pt_regs setup; but I don't want to
  rearrange entry code just to make unwinding a tiny bit more elegant. )

Fixes: 9e809d15d6b6 ("x86/entry: Reduce the code footprint of the 'idtentry' macro")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250325-2025-03-unwind-fixes-v1-1-acd774364768@google.com
---
 arch/x86/entry/calling.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index cb0911c..d83236b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -70,6 +70,8 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
+	/* We just clobbered the return address - use the IRET frame for unwinding: */
+	UNWIND_HINT_IRET_REGS offset=3*8
 	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */

