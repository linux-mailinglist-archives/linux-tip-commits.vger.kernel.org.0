Return-Path: <linux-tip-commits+bounces-2940-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF39E0033
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB85163418
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BA20B204;
	Mon,  2 Dec 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IE/Rm+Cj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="97pBe4MP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65501FECBB;
	Mon,  2 Dec 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138126; cv=none; b=iQD+huEiA57uxCF2snVblIlMWgXcsEZNGahrRgENbODK8Atpeqdb79WtQdLGLe57nTUIB4Nzsn1oxaUcsa/fLjnohYOGa4Pti4szv6jFQug+sk7NuVIuMMcYEX0zlVI1T82KbL+OvQHF3mPwCMB4Dh0tadNL7CFYHPtDZh50ASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138126; c=relaxed/simple;
	bh=aA7UllYsUJecHTGrAebIh0ZXjyM8mVjEDqHRSiXU/ao=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iVqy4vAxVAu65B0kgfWDU1mrSYfOt3WPM7ktOzJJ16x5etUOi45qVkya6njb1sU4tQKTpDo+yGU+fLxxnLaVq4k4asO5ZOoBc8KOU1GNsJiYfyVUNw4npKUxCFi7KgBdztmszwunwac6470043OvokRGP0emamtUcpRpLJfYFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IE/Rm+Cj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=97pBe4MP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVFuvUCzgYqWSclEZWBWFyhUnjUNIzMgiN5u+3ggtio=;
	b=IE/Rm+CjReb6Vo72w/lA/AdT8ZqTTo+3hUekRukG8kgV69UwaKkeVMZo/i9YpThkjeWE73
	nxC1zib515S/ZJYAqvdqEo8djyq+IB63mX3WyRq27UMJFwALXvCY/5wkvE1p6Q4EGLtHN4
	ZaUE7sEndnk1mEOutuZss7a+4zHawvsZiKykNj/5zb4SurIu+xB+tCgKs25j66XOXiaimA
	gQKGRWZSrpdeXBRYR71FcdQNNRGioUT7NPLsiuV7QfB2eAXzFSIEmkLIy/SPYSUQjY/DU4
	bPDqqYYYxWg6201aMYfqtq9Ud98wCIFv8vKsG/yc6pfgBBgvpK9gQgRmopVDuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVFuvUCzgYqWSclEZWBWFyhUnjUNIzMgiN5u+3ggtio=;
	b=97pBe4MP9PvxBizV6815CKntF239uZTDzfau8ILsfsvxKkwFYXnyRbQuYJFwTCGt8qJrrq
	AemNiZVCPa2SVyAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] unreachable: Unify
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.924381359@infradead.org>
References: <20241128094311.924381359@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812253.412.16467163513447060969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c837de3810982cd41cd70e5170da1931439f025c
Gitweb:        https://git.kernel.org/tip/c837de3810982cd41cd70e5170da1931439f025c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:43 +01:00

unreachable: Unify

Since barrier_before_unreachable() is empty for !GCC it is trivial to
unify the two definitions. Less is more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.924381359@infradead.org
---
 include/linux/compiler-gcc.h | 12 ------------
 include/linux/compiler.h     | 10 +++++++---
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d0ed958..c9b5818 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -52,18 +52,6 @@
  */
 #define barrier_before_unreachable() asm volatile("")
 
-/*
- * Mark a position in code as unreachable.  This can be used to
- * suppress control flow warnings after asm blocks that transfer
- * control elsewhere.
- */
-#define unreachable() \
-	do {					\
-		annotate_unreachable();		\
-		barrier_before_unreachable();	\
-		__builtin_unreachable();	\
-	} while (0)
-
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 469a64d..7be8089 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -141,12 +141,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
 
-#ifndef unreachable
-# define unreachable() do {		\
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ */
+#define unreachable() do {		\
 	annotate_unreachable();		\
+	barrier_before_unreachable();	\
 	__builtin_unreachable();	\
 } while (0)
-#endif
 
 /*
  * KENTRY - kernel entry point

