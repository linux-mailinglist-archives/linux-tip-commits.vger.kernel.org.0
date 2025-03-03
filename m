Return-Path: <linux-tip-commits+bounces-3789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A2A4BD5C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DBF188AE00
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2E1F3BB8;
	Mon,  3 Mar 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuuPQ+fM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5NZl5nNc"
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
 

