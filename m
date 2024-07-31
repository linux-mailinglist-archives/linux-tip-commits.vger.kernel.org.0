Return-Path: <linux-tip-commits+bounces-1897-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B89436BD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 21:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC2B218FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA81304BF;
	Wed, 31 Jul 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFKPt8tM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yVgJmY9q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0A44C8C;
	Wed, 31 Jul 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455457; cv=none; b=ccFfYz+wvEZ8ZpQv7y5mIJSyDOqNpZT8WAm/+iiFFd0gS5MIZItXA8j0r7wQ4ega3bgEgifbrrtoiMPni0q1dwTWmmw2vX/Vr0YYR6uBHcjxphAozh9TFLxNNI2acdLCoMAExklkiisFxgPtUKC8ZcTZ4jPoiU8sXWH0yELv7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455457; c=relaxed/simple;
	bh=Pyl4iTuhvAopPLvqGGBErERlPtsZfMqhWgvF0qlDSI4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y2j5qZ33/oRFv6XfkbfffPoct2jUfFi6LytLeZpa8eJcHL5jHy+dNnOENroFv+dcoagoRYH0WnvgzWBhno0z++31jiVFlhwYrSYWstq2Kvjb0JR37Yt/OHnRYW8HvGw3pVKVYbpaRKrP8mJ453j6/rDGB8tHVc2yjWwRCd0oNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFKPt8tM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yVgJmY9q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jul 2024 19:50:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722455453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mfpyun4RRF1sf8RFlUm3v26OdJAfZXEPHj2ZGoI2UYg=;
	b=sFKPt8tMaOKdUkbzf6Bh2C0sWGBTRe2ZptVonltjyJuRj6kvxLU9hQVlF3+aFVatPIrSKX
	2u75HL7sA4KFEzrLdqDs0ips4C99xmRt2X45AUt8pXLAkrEfxABpTLX85SV1E+PuraZt9b
	ZMFhdgrt1fSKSBW6BbAkDsw55dUbgummITmW9wJjWJZ4Z6mvGxv8AthG0Vr6/dfOJHMiV6
	dJpE7EOLuElZd7jTfX+yY4ptRwne4Rr/0n6kh/4c8vcH+v3l5claHAC9X4CxOg5khmZ9wu
	av/QGLfAtRkJN6/fwROUaER1xDmQSN9tNEhDPRUPdW32lFA93XgR6yjVP0INNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722455453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mfpyun4RRF1sf8RFlUm3v26OdJAfZXEPHj2ZGoI2UYg=;
	b=yVgJmY9qZ5w2xqfl+aeRnGQ9EIRs9c0djmJRqxyiGFrKoWWidPGH+pzHVA8pgxkJ939wLO
	KxL+8nV49/r4j/Cg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/setup: Parse the builtin command line before merging
Cc: Mike Lothian <mike@fireburn.co.uk>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240730152108.GAZqkE5Dfi9AuKllRw@fat_crate.local>
References: <20240730152108.GAZqkE5Dfi9AuKllRw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172245545300.2215.16469263909855039141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bf514327c324bc8af64f359b341cc9b189c096fd
Gitweb:        https://git.kernel.org/tip/bf514327c324bc8af64f359b341cc9b189c096fd
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jul 2024 16:15:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 31 Jul 2024 21:46:35 +02:00

x86/setup: Parse the builtin command line before merging

Commit in Fixes was added as a catch-all for cases where the cmdline is
parsed before being merged with the builtin one.

And promptly one issue appeared, see Link below. The microcode loader
really needs to parse it that early, but the merging happens later.

Reshuffling the early boot nightmare^W code to handle that properly would
be a painful exercise for another day so do the chicken thing and parse the
builtin cmdline too before it has been merged.

Fixes: 0c40b1c7a897 ("x86/setup: Warn when option parsing is done too early")
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240730152108.GAZqkE5Dfi9AuKllRw@fat_crate.local
Link: https://lore.kernel.org/r/20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local
---
 arch/x86/include/asm/cmdline.h |  4 ++++
 arch/x86/kernel/setup.c        |  2 +-
 arch/x86/lib/cmdline.c         | 25 ++++++++++++++++++-------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/cmdline.h b/arch/x86/include/asm/cmdline.h
index 6faaf27..6cbd9ae 100644
--- a/arch/x86/include/asm/cmdline.h
+++ b/arch/x86/include/asm/cmdline.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_X86_CMDLINE_H
 #define _ASM_X86_CMDLINE_H
 
+#include <asm/setup.h>
+
+extern char builtin_cmdline[COMMAND_LINE_SIZE];
+
 int cmdline_find_option_bool(const char *cmdline_ptr, const char *option);
 int cmdline_find_option(const char *cmdline_ptr, const char *option,
 			char *buffer, int bufsize);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5d34cad..6129dc2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -164,7 +164,7 @@ unsigned long saved_video_mode;
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
 bool builtin_cmdline_added __ro_after_init;
 #endif
 
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 384da1f..c65cd55 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -207,18 +207,29 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
 int cmdline_find_option_bool(const char *cmdline, const char *option)
 {
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
-		WARN_ON_ONCE(!builtin_cmdline_added);
+	int ret;
 
-	return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
+	ret = __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
+	if (ret > 0)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) && !builtin_cmdline_added)
+		return __cmdline_find_option_bool(builtin_cmdline, COMMAND_LINE_SIZE, option);
+
+	return ret;
 }
 
 int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
 			int bufsize)
 {
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
-		WARN_ON_ONCE(!builtin_cmdline_added);
+	int ret;
+
+	ret = __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
+	if (ret > 0)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) && !builtin_cmdline_added)
+		return __cmdline_find_option(builtin_cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
 
-	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
-				     buffer, bufsize);
+	return ret;
 }

