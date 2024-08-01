Return-Path: <linux-tip-commits+bounces-1905-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F49945362
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279411C21D2A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537B1494A7;
	Thu,  1 Aug 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SCY+TDW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SDJWgApK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404814264C;
	Thu,  1 Aug 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540486; cv=none; b=JJSuACeGM+qNVQRNhvog39bmQ0tyRSdUMIhD333vZCJmMFelBWID19su3snRr95TU05prHSfNaj8XehqQ5NP3nxNORWw7X+F1ZDQIiDl2PazkQ4ua8rHn8Fyw4V19/mvcRWzJet+89Ye5H9cnr1pJzuwOhH3MUnKBNIo0SBxq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540486; c=relaxed/simple;
	bh=laFCcnE8RzbTNiLZ6afDx3BTIB2TGKp//62l2UIfXiI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hrN9/zm2FDCBN68n0Ge84VC4efVws7UXTroYGj90pbEOCHGgBPZehdcA1wt0uAddL2lKpmsFf+PvPUOYtf67lzU4kjXX/89KtjfAs+TEAGvQPA+ROk3mMxeo3lSppswsgrk3O5SlHRels9fvUm0XbvA6KFXkSvdQWzUxTq5KG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SCY+TDW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SDJWgApK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 19:28:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722540483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LGBsf9/eA8XWrPH0BImEQwXWt+BeL0wBa/t6+K9mvo=;
	b=SCY+TDW5PLSgi/KGK8wjmFJvNdVbVsNlO3vxZ0BByd9bdYhPzGbpkkxlTPHCFBRSRNy3G1
	LpEqw/CArhAIwm6aczsI7TOUVKZujg7qd+Aqs6OFCR/dc4OPFUrzhodXWJz/Ay4yAdaf6O
	EUE5XlmpF/e5xOgnerrCPxwzELAjUglISIgk5Vesomq7HclQrJYqOSjCU5YsmutM9OLS+z
	WN4w3BpmTMYTNhyHT7PXwccIZDEt8xKskT0aMJ5uD0Q1VB1Ook1+KhhpbDFfq9rOzcQhlF
	uSEswsqS1Hsm4SXbfpG+n3RRpZ2PcNQPWq244j4gcKVZi4N878DB4MIlV+by4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722540483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LGBsf9/eA8XWrPH0BImEQwXWt+BeL0wBa/t6+K9mvo=;
	b=SDJWgApKGcI6C/6kQSDtIS//o2zcV9iv9lZ5sWWf0tFrodspRrhktjygnXn4MYQoTtBWUy
	3RkIPtCteDqgYhCQ==
From: "tip-bot2 for David Gow" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/uaccess: Zero the 8-byte get_range case on
 failure on 32-bit
Cc: David Gow <davidgow@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731073031.4045579-1-davidgow@google.com>
References: <20240731073031.4045579-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172254048273.2215.2288359377768979680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dd35a0933269c636635b6af89dc6fa1782791e56
Gitweb:        https://git.kernel.org/tip/dd35a0933269c636635b6af89dc6fa1782791e56
Author:        David Gow <davidgow@google.com>
AuthorDate:    Wed, 31 Jul 2024 15:30:29 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Aug 2024 21:19:10 +02:00

x86/uaccess: Zero the 8-byte get_range case on failure on 32-bit

While zeroing the upper 32 bits of an 8-byte getuser on 32-bit x86 was
fixed by commit 8c860ed825cb ("x86/uaccess: Fix missed zeroing of ia32 u64
get_user() range checking") it was broken again in commit 8a2462df1547
("x86/uaccess: Improve the 8-byte getuser() case").

This is because the register which holds the upper 32 bits (%ecx) is being
cleared _after_ the check_range, so if the range check fails, %ecx is never
cleared.

This can be reproduced with:
./tools/testing/kunit/kunit.py run --arch i386 usercopy

Instead, clear %ecx _before_ check_range in the 8-byte case. This
reintroduces a bit of the ugliness we were trying to avoid by adding
another #ifndef CONFIG_X86_64, but at least keeps check_range from needing
a separate bad_get_user_8 jump.

Fixes: 8a2462df1547 ("x86/uaccess: Improve the 8-byte getuser() case")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/20240731073031.4045579-1-davidgow@google.com
---
 arch/x86/lib/getuser.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index a314622..d066aec 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -88,12 +88,14 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
+#ifndef CONFIG_X86_64
+	xor %ecx,%ecx
+#endif
 	check_range size=8
 	ASM_STAC
 #ifdef CONFIG_X86_64
 	UACCESS movq (%_ASM_AX),%rdx
 #else
-	xor %ecx,%ecx
 	UACCESS movl (%_ASM_AX),%edx
 	UACCESS movl 4(%_ASM_AX),%ecx
 #endif

