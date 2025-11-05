Return-Path: <linux-tip-commits+bounces-7262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD606C35BEE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 05 Nov 2025 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235175604AC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Nov 2025 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF4D22F389;
	Wed,  5 Nov 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGhzfLqj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="REvYQ2nn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24023161BC;
	Wed,  5 Nov 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347664; cv=none; b=LDqPwDnFeKFn1uMbU0bv4vi+p7TNu/vJ7MD1GnBYSvHRM9GTuH2FY1ZkV20Fa+6GTHaTKbfMuMBvUCcm+0i5pvZz66kpYh79xj4LLBlUrGYs/HyIXvhCXm7+dGo8O1O4sTdL5TfaoqWbLSU36MRlO/xiP4pzvC05FueMdOLSgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347664; c=relaxed/simple;
	bh=t4Cx2mFtN8jnmwhYbtwop1LWt3hgla29HOyT/twWY/o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hn7XlmKpxVnaVQ1FKt3oW9ytyJv8/V0HpxUZOJRlzjSh1dRJP6HM4c1Zi8aj3Sgv5nx4xpwilJshBXOLBCveGrOV/eYkB9JQ4fBaZBExjvm1tltRUxQHqXs6agExKvBWyjn9B+U8AKfhxUpNB59fR4SYiNbfOtBDxpvvBNDmVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGhzfLqj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=REvYQ2nn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Nov 2025 13:00:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762347659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CboAPnZGVq8QmhqYTIdS27j9IaKB415/9HLvfhRzUo=;
	b=IGhzfLqj2g2Tr7RCVLWOV0D5C91r6x0GSQA6VIkTo76+EktF/rrHjYk5cPteWDDuA31+5f
	nBx6dqoNuhvbKZFRSdUL2FaWGv1Swij2PvsrwLWcJrYXlUAu+hG2IURITWlaKz0cMvRyAJ
	3gPMEB/RDSWEa+LSEhXVQ2TQS5EOajjPaMxShQUbwCDOTQwOZzEVxd1X7RLdoykLszkgFR
	8rjibETaqSEMTPkSvul2+MdKaS0pFDwATAnx8Aj2DKD1mIPEMa4Zr9ZhMK8rgV1OP/ec2a
	zTskEcUaOeV8pCkmTzlln2LZMWYL6UnC8kg/9M4VTBACv6YhwwjG6DAlglLP0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762347659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CboAPnZGVq8QmhqYTIdS27j9IaKB415/9HLvfhRzUo=;
	b=REvYQ2nnCX0efqJbnluEpzkLYxYFSfaHlnQlzA9Pc/hJTadeE70ZlWAjxOv6rt/GCHs9sP
	WX8S+W5dJM3skcCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] entry,unwind/deferred: Fix unwind_reset_info() placement
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105100014.GY4068168@noisy.programming.kicks-ass.net>
References: <20251105100014.GY4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176234765743.2601451.1305731973420064193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cf76553aaa363620f58a6b6409bf544f4bcfa8de
Gitweb:        https://git.kernel.org/tip/cf76553aaa363620f58a6b6409bf544f4bc=
fa8de
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 05 Nov 2025 11:00:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Nov 2025 13:57:32 +01:00

entry,unwind/deferred: Fix unwind_reset_info() placement

Stephen reported that on KASAN builds he's seeing:

vmlinux.o: warning: objtool: user_exc_vmm_communication+0x15a: call to __kasa=
n_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_debug_user+0x182: call to __kasan_check_read=
() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_int3+0x123: call to __kasan_check_read() lea=
ves .noinstr.text section
vmlinux.o: warning: objtool: noist_exc_machine_check+0x17a: call to __kasan_c=
heck_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: fred_exc_machine_check+0x17e: call to __kasan_ch=
eck_read() leaves .noinstr.text section

This turns out to be atomic ops from unwind_reset_info() that have
explicit instrumentation. Place unwind_reset_info() in the preceding
instrumentation_begin() section.

Fixes: c6439bfaabf2 ("Merge tag 'trace-deferred-unwind-v6.17' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/trace/linux-trace")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251105100014.GY4068168@noisy.programming.kic=
ks-ass.net
---
 include/linux/irq-entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index d643c7c..ba1ed42 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -253,11 +253,11 @@ static __always_inline void exit_to_user_mode_prepare(s=
truct pt_regs *regs)
 static __always_inline void exit_to_user_mode(void)
 {
 	instrumentation_begin();
+	unwind_reset_info();
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
=20
-	unwind_reset_info();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);

