Return-Path: <linux-tip-commits+bounces-4169-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7763A5E480
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59A47AE645
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7A258CE1;
	Wed, 12 Mar 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glrH9p3i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6bUukeO+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D40256C9E;
	Wed, 12 Mar 2025 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808008; cv=none; b=UhfDQL/eFzN68HAbytJuxT0StOARRkbvWSmIz2C6gQ6RERmvhOW22YFAy1r9V25HE2eGERaj6zLsWj0sCNMkZCYCfOT34s9WdjpkzloQILG/AiEhEyS4aQW2tZgHBgBmHqQIjcUDNvrnOobVFNiMYJ1n36Cc+UGpqPvYLGD9Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808008; c=relaxed/simple;
	bh=6vu15Ib9aLrwFjeQdNe/+ZLPjyebMJla16sDmQW0Gb0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E3KKR5lkP31wSzhFm2Wf+DKK2dNwQ4+59OO+5ak9adqoKuXUknWvMMesYxhOEZqbwrT13aKtzvLTOvyG1y630INUeB7aFqbi98/UXoPpc2eglS6pBC8jAYYWxf0Kv2RqQSc3Ryu+quf4LzRGcpGUUr2KfATi+GwBFXV0+9cudrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=glrH9p3i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6bUukeO+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 19:33:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741808005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kbnfj5Ei/ha6BJWluR/rjmRYxcV74cTN8s3mCpdRWo=;
	b=glrH9p3ihErUV0cWQ5zu94f7FBAgg/o8d/jGbvyXDIYPJEz0fb6h/Rpz66WKeBuj+4qSAB
	UqmwKTEN+HEp8/AQ4KVovSWdxgVVmo0IdzYPBdPTObdJTixrH0UcVd/eDh5ASaXb3MA3fW
	qrkYSyd1wtrUZ5YbgXvxDmBkJBj7JSLjC9GYAB7vZii0fV8kSvRK4FQynqeE068EVk76qQ
	rOALfF5/TMW32Ec3xYeeX4eylS9SE4GMEA4jTcgPa7JkneUDH2USX7bUorZnp1hKFtHmzN
	GKYxCH5j6BVIHO6YbjLpJHTMWJQSNAZRc0qRZ6Pxa3LhaXhvgvd9O5NJguWbXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741808005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kbnfj5Ei/ha6BJWluR/rjmRYxcV74cTN8s3mCpdRWo=;
	b=6bUukeO+BHAvK9WZ0U2M7WmLArKF5LHoTggi9i2TB4y7ozWs/JsJJdzY+Jg/fEcxdSBbUR
	kGakkzXnCnWEyTCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312123905.149298-2-ubizjak@gmail.com>
References: <20250312123905.149298-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180800206.14745.2087027613593191613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     01ba23bf1b3f9a4035faedc2aa450e251bcc2c7c
Gitweb:        https://git.kernel.org/tip/01ba23bf1b3f9a4035faedc2aa450e251bcc2c7c
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 13:38:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Mar 2025 20:18:29 +01:00

x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()

Use ASM_CALL_CONSTRAINT to prevent inline asm() that includes call
instruction from being scheduled before the frame pointer gets set
up by the containing function. This unconstrained scheduling might
cause objtool to print a "call without frame pointer save/setup"
warning. Current versions of compilers don't seem to trigger this
condition, but without this constraint there's nothing to prevent
the compiler from scheduling the insn in front of frame creation.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312123905.149298-2-ubizjak@gmail.com
---
 arch/x86/include/asm/arch_hweight.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index a11bb84..f233eb0 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -17,7 +17,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res)
+			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;
@@ -45,7 +45,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res)
+			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;

