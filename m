Return-Path: <linux-tip-commits+bounces-4921-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A82EA87122
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D644E3B5C47
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11561161310;
	Sun, 13 Apr 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A99rXV7D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qT/rD37q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B5339A8;
	Sun, 13 Apr 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744534913; cv=none; b=H4qrFDyBgVG6GACOZctwBb5d+GuTlZ2k+P6jBm8Px9JefU64fySWdcYp5Axmu4mHDgw4jvofoBVv0BYfIxJ+BX2o4HdL27aBiYnOpixOJyl44uH4e/gBJ/iJQ1dQw4vqPq7sCGiKzXEc1ZHslDQAjwINCtMc1qZBSeVOBKNr3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744534913; c=relaxed/simple;
	bh=45ocQFISqG4KV3czmx8gtFs2TjMm5kguDIVH+dXISoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ve6pYxZvxslotJWfoV86Fv/FnGQld2p28hbMIXttLzPUgNbzAtupeYK5Tsa1lLDGjIINyLUc3FvqOZU2DkNoUQdxS9Rm79JlP627zKbXgNufdLq5P2OuS/1icZXCe9vTmaROtMtbJDOfc3GQn5WKXA5H55acy5OOy8WWV1bRG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A99rXV7D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qT/rD37q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 09:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744534909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx0V8f12YaPJY88JOj0YQ+7lHhTjeAQTjZgPvXKE0ic=;
	b=A99rXV7Dr9gSGfrH1rOIObkMWfbCZ2k0awr4OB7y/b+dol1GE4F0Wh0Z3GUyPPi3UYcr9K
	K8qMBVPHROhG8nmdjSP0y6XSGSg7kRDzgPgVdI/wkP2cBP9ddYN4plGrdPe/806MlvE9GX
	yRvmZnboijg6FQEOEaTn81tGmKxebgDnNS459PHlFBW3U/MlyDyNrrSpiZRqJu1rZ+8UCe
	bmvombrbULCroxowjHHg2W6XG0EqxTmHmI09d48tolfprv/g2ZuAh5pZMpHDzLZhpFmxNK
	SgTyaP+CT2Ji9x5MLfE0pzxvpQL7OemDDPLIx71KneMcSuEjI4Jw64gA9oOBHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744534909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx0V8f12YaPJY88JOj0YQ+7lHhTjeAQTjZgPvXKE0ic=;
	b=qT/rD37q/am/bDNPi6QG6tCcngv+x2v2HqoCqGmEwP5JvLyOP7GMbICT19ajKgeMlUlSmR
	/CceKTY1wi3a8lDw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] objtool, x86/hweight: Remove ANNOTATE_IGNORE_ALTERNATIVE
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e7070dba3278c90f1a836b16157dcd34ccd21e21.1744318586.git.jpoimboe@kernel.org>
References:
 <e7070dba3278c90f1a836b16157dcd34ccd21e21.1744318586.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174453489941.31282.10931005949650290494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     7b3169dfa4ba1b1898d4bdfad6ddabbc9e8a57ed
Gitweb:        https://git.kernel.org/tip/7b3169dfa4ba1b1898d4bdfad6ddabbc9e8a57ed
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 13:58:35 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Apr 2025 09:52:42 +02:00

objtool, x86/hweight: Remove ANNOTATE_IGNORE_ALTERNATIVE

Since objtool's inception, frame pointer warnings have been manually
silenced for __arch_hweight*() to allow those functions' inline asm to
avoid using ASM_CALL_CONSTRAINT.

The potentially dubious reasoning for that decision over nine years ago
was that since !X86_FEATURE_POPCNT is exceedingly rare, it's not worth
hurting the code layout for a function call that will never happen on
the vast majority of systems.

However, those functions actually started using ASM_CALL_CONSTRAINT with
the following commit:

  194a613088a8 ("x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()")

And rightfully so, as it makes the code correct.  ASM_CALL_CONSTRAINT
will soon have no effect for non-FP configs anyway.

With ASM_CALL_CONSTRAINT in place, ANNOTATE_IGNORE_ALTERNATIVE no longer
has a purpose for the hweight functions.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/e7070dba3278c90f1a836b16157dcd34ccd21e21.1744318586.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/arch_hweight.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index cbc6157..b5982b9 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,8 +16,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
-				"call __sw_hweight32",
+	asm_inline (ALTERNATIVE("call __sw_hweight32",
 				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
@@ -46,8 +45,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
-				"call __sw_hweight64",
+	asm_inline (ALTERNATIVE("call __sw_hweight64",
 				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));

