Return-Path: <linux-tip-commits+bounces-1296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B18D0967
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 19:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3037B2300A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107644C9B;
	Mon, 27 May 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T2PKLJt8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="roJU0M78"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C052628B;
	Mon, 27 May 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831167; cv=none; b=fZUaizmFAIubhZvyHh6/LnoBF/mr6g27GTr3ZvVjo/2it62QgkbUfORpLv6uAZ3Xn3WAA1Hpibe7s3r4JvzbNhTj6h2zATPGMg/gfJ9HpQlH/n0ne8TU40Ul0cLS+MKQJnnXxE4fFAx+DTVL1B77d8Jry4GXwShXqFH4mrsNzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831167; c=relaxed/simple;
	bh=xph9HqOHF5oSvesYzia/6qvqMq+qW1FJiEOBj3pWlwA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rZC4zVcAgnipIe89HabivevN3YMESsUxEtz2fjC3iStJAQNfOBYTSgHg3M/iM/U10lj4wfKoB8YpEE5zKKVFzLs/s/xpYALLDTwl1ODCfjJu7YfF/SKIXjfUZeuTd1DXiS8F8dI+vJIqn/Msvs7k4+YQdCyw70wmhpOnB5uj8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T2PKLJt8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=roJU0M78; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 17:32:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716831163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZYBMdLsa9K+LrzU0iHckKHgocxEKbi3cQi6MxeWuU0=;
	b=T2PKLJt8A0ya+cdneAJZghIMI+Ufyqy8Og5R+HoIg+TN+eo/gBw5wtKDQzEgmPudtkquNn
	MqVNJ455ICsb/hxyybFQLLxK10ICXRRDUHsdhD87x2leR6I1eHz73TG2AMhENz4w4W/PfX
	mqcD5Rxm2uGFHQF5PTfaYqS0aaTQysYiE++A+EL686NHnx3AEEfzQACbJ1j9RbinEQP7+Y
	Iws/R+mdQoawi46z5+/rFG683JZTQKaxdL3GFqB7PFFtLdOv5555v8gDWJRgXAohITzWWj
	FBfNFQFJSeoG45j5VtUiLz8YMNOOUwMi33MCEMsZ1Us8lHKV1fVNCjn9BQV/tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716831163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZYBMdLsa9K+LrzU0iHckKHgocxEKbi3cQi6MxeWuU0=;
	b=roJU0M78DsrjHXvOu4z9J8gDck/c+/+ebaKBbbLtB2SAsjMKzuut/kqoHDXRGbvJNBZ/sP
	p1Ascho7w2flNqDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Warn when option parsing is done too early
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240409152541.GCZhVd9XIPXyTNd9vc@fat_crate.local>
References: <20240409152541.GCZhVd9XIPXyTNd9vc@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171683116337.10875.5456098859763818369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0c40b1c7a897bd9733e72aca2396fd3a62f1db17
Gitweb:        https://git.kernel.org/tip/0c40b1c7a897bd9733e72aca2396fd3a62f1db17
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 08 Apr 2024 19:46:03 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 May 2024 18:54:45 +02:00

x86/setup: Warn when option parsing is done too early

Commit

  4faa0e5d6d79 ("x86/boot: Move kernel cmdline setup earlier in the boot process (again)")

fixed and issue where cmdline parsing would happen before the final
boot_command_line string has been built from the builtin and boot
cmdlines and thus cmdline arguments would get lost.

Add a check to catch any future wrong use ordering so that such issues
can be caught in time.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240409152541.GCZhVd9XIPXyTNd9vc@fat_crate.local
---
 arch/x86/include/asm/setup.h | 8 ++++++++
 arch/x86/kernel/setup.c      | 2 ++
 arch/x86/lib/cmdline.c       | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e61e68d..0667b2a 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -28,6 +28,8 @@
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
 #ifndef __ASSEMBLY__
+#include <linux/cache.h>
+
 #include <asm/bootparam.h>
 #include <asm/x86_init.h>
 
@@ -133,6 +135,12 @@ asmlinkage void __init __noreturn x86_64_start_reservations(char *real_mode_data
 #endif /* __i386__ */
 #endif /* _SETUP */
 
+#ifdef CONFIG_CMDLINE_BOOL
+extern bool builtin_cmdline_added __ro_after_init;
+#else
+#define builtin_cmdline_added 0
+#endif
+
 #else  /* __ASSEMBLY */
 
 .macro __RESERVE_BRK name, size
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 05c5aa9..728927e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -165,6 +165,7 @@ unsigned long saved_video_mode;
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
 static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+bool builtin_cmdline_added __ro_after_init;
 #endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
@@ -765,6 +766,7 @@ void __init setup_arch(char **cmdline_p)
 		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
+	builtin_cmdline_added = true;
 #endif
 
 	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 80570eb..384da1f 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -6,8 +6,10 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+
 #include <asm/setup.h>
 #include <asm/cmdline.h>
+#include <asm/bug.h>
 
 static inline int myisspace(u8 c)
 {
@@ -205,12 +207,18 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
 int cmdline_find_option_bool(const char *cmdline, const char *option)
 {
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
+		WARN_ON_ONCE(!builtin_cmdline_added);
+
 	return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
 }
 
 int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
 			int bufsize)
 {
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
+		WARN_ON_ONCE(!builtin_cmdline_added);
+
 	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
 				     buffer, bufsize);
 }

