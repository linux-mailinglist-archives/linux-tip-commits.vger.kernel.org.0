Return-Path: <linux-tip-commits+bounces-4843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F37A858B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286704A2CC8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868129CB4E;
	Fri, 11 Apr 2025 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3I4H5Ikr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpNrDjaG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE029C342;
	Fri, 11 Apr 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365707; cv=none; b=F8GN/jvAuYsPFNN5SHqzKlX38sCto+p7EzNzvh4H+oQ06o6CpADVVhdEm6QOtv2xGg1m1/+/Guv+ac+QMRaJ9zbxmeVpzMfYmjGovKiUDjnPlO39FKyW0z2pEotlrgl+sOXBths6HnL2pfc5ebwMXgvjVpnHBGqTqv8e6txae28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365707; c=relaxed/simple;
	bh=hFWT5sM5BNVwMlz6W9OH0RqjDQDAaGVFzyricsMucT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H8zhjWysjRkaxHzhOhMuiidXl+wgqVXV7WKoTvkIpilYn7i15H7Yy9KpONtB7ULF1WELXw7u7VvwfMVjdd7j4D9bkm8lBlspYPtTfmAGMdxQXzMPVrdaLViI0XNi6QC9Ut+vAy6kxpgb+B89s39VntUBSC7QyJE3p8+yt2vWRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3I4H5Ikr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QpNrDjaG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/niuLqY/eeNxG06GOZ1d0rqnFDMcKFj61+ogwYeFSc=;
	b=3I4H5Ikrx9s7EHDBiO7KYTRnKdwS44wEdU7TUeT8RrPFTHj1mTkPzRK15dvWv8DTAq6jSU
	7tZZUXvGtaFxnZpMzbItq7jGV0QHAYeaE8KY1VCYPsDz4z/XfQWQ7nqXwqZM0s9OGae3kV
	3twK5i+9NZ0EcQdadHLGuhSCXq4b7BSFhIckG7IPQeA7g6YWTtRTUZWxeR+2MYM9fszoLS
	npOtPZjGpQRLiBfM7sGyB4m+DLVzJvgT9h8m8w5U/4rHFIr47no6GrAqsWnY/jnkXWKvo0
	QtskvlhzTN1OJ9JYyf5kD5PCzz/O/EOczNrJ0u8daEODSDn/MPTdr1ArHT811A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/niuLqY/eeNxG06GOZ1d0rqnFDMcKFj61+ogwYeFSc=;
	b=QpNrDjaGPUBs+WCLavXvsbMYiwowscYA1VeqoQZuIAh7i27g/o1sQv3L7dxf5hstnyJukr
	KTdLNygvhakyNMDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename
 'POKE_MAX_OPCODE_SIZE' to 'TEXT_POKE_MAX_OPCODE_SIZE'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-47-mingo@kernel.org>
References: <20250411054105.2341982-47-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570249.31282.18245046767723205634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     3c8454dfc9143c992375a166a620ea3d62c3e434
Gitweb:        https://git.kernel.org/tip/3c8454dfc9143c992375a166a620ea3d62c3e434
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Rename 'POKE_MAX_OPCODE_SIZE' to 'TEXT_POKE_MAX_OPCODE_SIZE'

Join the TEXT_POKE_ namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-47-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h | 4 ++--
 arch/x86/kernel/alternative.c        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index d9dbbe9..a45ac8a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -11,7 +11,7 @@
  * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
  * Raise it if needed.
  */
-#define POKE_MAX_OPCODE_SIZE	5
+#define TEXT_POKE_MAX_OPCODE_SIZE	5
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
@@ -82,7 +82,7 @@ static __always_inline int text_opcode_size(u8 opcode)
 }
 
 union text_poke_insn {
-	u8 text[POKE_MAX_OPCODE_SIZE];
+	u8 text[TEXT_POKE_MAX_OPCODE_SIZE];
 	struct {
 		u8 opcode;
 		s32 disp;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4b460de..b8e0b1b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2461,7 +2461,7 @@ struct smp_text_poke_loc {
 	s32 disp;
 	u8 len;
 	u8 opcode;
-	const u8 text[POKE_MAX_OPCODE_SIZE];
+	const u8 text[TEXT_POKE_MAX_OPCODE_SIZE];
 	/* see smp_text_poke_batch_process() */
 	u8 old;
 };
@@ -2653,8 +2653,8 @@ static void smp_text_poke_batch_process(void)
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < text_poke_array.nr_entries; i++) {
-		u8 old[POKE_MAX_OPCODE_SIZE+1] = { text_poke_array.vec[i].old, };
-		u8 _new[POKE_MAX_OPCODE_SIZE+1];
+		u8 old[TEXT_POKE_MAX_OPCODE_SIZE+1] = { text_poke_array.vec[i].old, };
+		u8 _new[TEXT_POKE_MAX_OPCODE_SIZE+1];
 		const u8 *new = text_poke_array.vec[i].text;
 		int len = text_poke_array.vec[i].len;
 

