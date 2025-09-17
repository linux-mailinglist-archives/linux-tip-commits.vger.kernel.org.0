Return-Path: <linux-tip-commits+bounces-6660-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE7CB7CEE5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF241BC663A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C327B354;
	Wed, 17 Sep 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAAyiPBK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXMfqQjO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAF244681;
	Wed, 17 Sep 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089798; cv=none; b=F+rQcJk2kvHm8zGI5mo0R+dqTZLU0YaUOODABs+t++CgeQjy+KuztYFTkmmhoSW6vESZEWM0UdhIKizaGMkx09wWLsJSH9OByiWhKOkA2TRdc8Zn7kwIS9iQQl+4IPlj1Cf9Rk3GlOVdUYzJyUUi2/oB/0GX067gzT8iX7D0Zh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089798; c=relaxed/simple;
	bh=bO+OUuCTisX/JKgLlSFw6DfZkalg0tI56C36HW9i9uQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EVKAIF5i3PvK7euvqN4Yza/bC+Mr3j8MfXgjg+b1VLP2L5BNJ/wEfyPxV0xG+zixaukK7XcQ8Z6nwdFIzBq1IYgPWFmtCnPJQq0IzHs5w6yZB6M60e5y/IDLcrm/Nad8Wg264J8xQXsmSPEcYF31kf6+lfSE/K7WDZ2bxooPk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MAAyiPBK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXMfqQjO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 06:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QalizsiUAtUOr05WD8fJS5DGw/OMTG7ggrGY5GbGBpY=;
	b=MAAyiPBKqcqZ9CODINI2xtplLq8Erbm0Ee45OJGGnDjRFEI9sxDQ0opP7CuMA4hdPjlUcJ
	PWA/02vno9R3dTMO97F3c6KK7zMW2K66QbfaQaCt4n/DJVXKFxf7xFwo0aSxMIUAAl1X5N
	eFeRHCHq9Usa/cMfFLLeyjPefRQrxdy+ZWdqq6AoAQwBoLKEOL6Ms4ZOuyLIk6e3QsVOBd
	6ISw0m5NdsjnWnWXj232jVBWZMOrRNYu1DvRfkmoapOGRzjgOzX9NXMHsvvJvmWJs9FXw9
	wLcoYRmamoeXrZ2REqPZy5rS4b4rjfBi+1TccnzGQQPjzOvYh85ddpcil5+42A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QalizsiUAtUOr05WD8fJS5DGw/OMTG7ggrGY5GbGBpY=;
	b=LXMfqQjORpEornD4yur2r0BPCOME7wu26EwYba7VvXTMNm+GPkjNmOamOF/3K2mYgdnefH
	Jh1rwznl6ZCI/EDg==
From: "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] s390/entry: Remove unused TIF flags
Cc: Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250911092806.3262481-1-svens@linux.ibm.com>
References: <20250911092806.3262481-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175808979391.709179.13510719821562997846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     c7ac5a089d495fd57f6851126e83e9c19205afae
Gitweb:        https://git.kernel.org/tip/c7ac5a089d495fd57f6851126e83e9c1920=
5afae
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Thu, 11 Sep 2025 11:28:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 08:14:04 +02:00

s390/entry: Remove unused TIF flags

The conversion of s390 to generic entry missed to remove the
TIF_SYSCALL*/TIF_SECCOMP flags. Remove them as they are unused now.

Fixes: 56e62a737028 ("s390: convert to generic entry")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/thread_info.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thre=
ad_info.h
index fe6da06..7878e9b 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -74,12 +74,6 @@ void arch_setup_new_exec(void);
 #define TIF_BLOCK_STEP		22	/* This task is block stepped */
 #define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
=20
-/* These could move over to SYSCALL_WORK bits, no? */
-#define TIF_SYSCALL_TRACE	24	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
-#define TIF_SECCOMP		26	/* secure computing */
-#define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
-
 #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
@@ -88,9 +82,5 @@ void arch_setup_new_exec(void);
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
-#define _TIF_SYSCALL_TRACE	BIT(TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	BIT(TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		BIT(TIF_SECCOMP)
-#define _TIF_SYSCALL_TRACEPOINT	BIT(TIF_SYSCALL_TRACEPOINT)
=20
 #endif /* _ASM_THREAD_INFO_H */

