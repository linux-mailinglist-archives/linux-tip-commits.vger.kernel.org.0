Return-Path: <linux-tip-commits+bounces-3936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFEA4E2E7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6954C189DA1C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3210F209F5A;
	Tue,  4 Mar 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuuPQ+fM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5NZl5nNc"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E92080DC
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100902; cv=pass; b=hvopIvNaOuAjymCjt2/2zYQpaCZUGjg+1+k4CUReJGFDAdP7Std3ikat6Xthw6vFXb493HtMUeM5KoxmuQitIvRiAD4W0tZLzZ9/bp+8AlIQe6MhAXk/2quZJPVbXXvS85O8vbQ40SNSCKYTy48o0A/d1TKvyG5xpQ349Qlp7NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100902; c=relaxed/simple;
	bh=6BmY9HloQWmrIWcWlHrC1eQA/4eP0yEIEpkSTTKuxd0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ecbJ6DIuuslhOF6phJizWQhpFzE23oZ3z5d7oA84RwxoI3ArHTD4YOukp2oT2Nc6CgzNwVGFd06xUVhcKnNEFzDPamAD7pz6Jfv9Isr1e5mqQRyEwZYcVklopMbWJtN4reCC/CjTb6zgnRjsGe2NOgODYFT8rnXaEuex1zlfPMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuuPQ+fM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NZl5nNc; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 007CE40CEC8E
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:08:18 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VuuPQ+fM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5NZl5nNc
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f7r6Gh6zFyCF
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:03:20 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id DCB1442721; Tue,  4 Mar 2025 18:03:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuuPQ+fM;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NZl5nNc
X-Envelope-From: <linux-kernel+bounces-541485-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuuPQ+fM;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NZl5nNc
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 4CA1F42FEE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:06:39 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 232182DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:06:39 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA31188AF6D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054D1F4716;
	Mon,  3 Mar 2025 11:02:48 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6151F3BAC;
	Mon,  3 Mar 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999766; cv=none; b=RJzUHXH089W1VeUnk8eKcJTQfP0tw64h5/ABrPnVuahtEtFHwki4gEEZpprLPZYvOzuFi/yxVUfA4JPmxKY/KQW+EFjdtT2cw/4MpqdXCMDuYv8Zax44BpJt5I8G2aSJYn+ovFDoTbxmKqIZMrYwDKxX/g5omq7ARrUIO67KMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999766; c=relaxed/simple;
	bh=6BmY9HloQWmrIWcWlHrC1eQA/4eP0yEIEpkSTTKuxd0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RQEqmcurbAq3MMz3jfhxCeMhLF9EuEfxnS8uvKqKM+m02qWVi2Rbgou261u16jl8Tp/TLrCON53yfqTlTcVWLG7LDul+FzL+bV4Nhxb3VZ0tzM7n3uJewV/Hq35jSFbA5NR0KVmdCTpMBQLht91LQiI3oUP8hPx5q41ERNki4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuuPQ+fM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NZl5nNc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:02:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740999762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k00XNAJvAe2C6KjqVMcLSHnjJgrkU8rXHH4c4JwqzGQ=;
	b=VuuPQ+fMX4u/5tMZeBAp1d26H40t+byCaCFgJUvtg0HW8QguqZG80XiBgauFp5KQF/j65D
	hUg70kyM+BZqyjioWy5KKril+HS7pJTrm9NtJjrcR9YaKktKZJuFxho91KV5qprxh8YPaw
	GN7exZXoexlYsy03aa7VWcmliPc+ELmk6XKCIJW5mmRpB6gkxACdvHh/SP6p3eWn08cBOY
	Qp8KIQVEuo1rx7K/c23PYeHlyCaCTaZ4hjf57HqWXxtMNXl19OUtl0EqD5hitVnIDR3JQw
	vKkV81dhzfKTrt8ZJWLKD5ztddO3jIvy3OxmM729xzsVJM9nE0nJJ7eddNTl/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740999762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k00XNAJvAe2C6KjqVMcLSHnjJgrkU8rXHH4c4JwqzGQ=;
	b=5NZl5nNc6azhHUVy8/SSMOwdttI648gV7CNRcNJEl4x+p59kPWgRR306biK8g+/V/DLfU8
	Rn6UVcilh6MJVaDQ==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f7r6Gh6zFyCF
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705580.1291@OMXK9bcBiGtD9qZQC4hQ9w
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e5ff90b179d45df71373cf79f99d20c9abe229cb
Gitweb:        https://git.kernel.org/tip/e5ff90b179d45df71373cf79f99d20c9abe229cb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:21:03 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:39:54 +01:00

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
 


