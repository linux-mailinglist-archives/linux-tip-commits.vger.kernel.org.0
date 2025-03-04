Return-Path: <linux-tip-commits+bounces-3919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B1A4DADE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149ED3A93B6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6775720110B;
	Tue,  4 Mar 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uda9TIcG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jbe4KBzq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF06200B96;
	Tue,  4 Mar 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084593; cv=none; b=VWZxjeMKphLoef/eFt4me05cXOBXKJItK4w8+Y5ODQWrhjlL+jADPk3Jn08ARAwWWc3M8BW1RdglZBdCeuNJaUZocY0SQzscu/mO7vHO5Vx46TkBbfku2B29EMy5v3Zpmddbf4qtTLKSk/2CPZ2PqG6BOlh66wJhoNX3MCDwrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084593; c=relaxed/simple;
	bh=gn7He+j5YgmQ4clZs0iVhLRLZP8xcX90eahZLe3E8GI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HWzpFceHjK5HvvLw2F4OXXJ00WrnzVr32I8kQJpSXMHYoAIP9eHDUKjjveesjxtdsWuU43hcJjlMr2kQQJ928+wyVmDIUbz5rVJTnqch+bFgrREtMrDFmOQVyb4OG+963olGtv1YaRMsycDb3JmwVqnP0kON4tAHZAU5G401TU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uda9TIcG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jbe4KBzq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIr8PIjOp2TyyKOdH8u8fZj5X/jAii2VV5ATHFUv2gk=;
	b=Uda9TIcGo8NfspEibrpixbGkWTZhl+xXHZbnK4zd/rvAwiHgRCyHQ1+70XLqxiLcKkUrbV
	FuqyLSVIWI8FWEPIOWwRbDs/IpNrwdY7QOdb3sH/KFSk8QX5XHkVO40ECI9nt7SOBSsDci
	ZdtS6D2rm6a5ZvnpK4IzRR+trFuoxEcGU6z3BKf9MrVnGOzBesSWRrn00wSKSe/Hz3l5tK
	t+0Ex0Q+OnIGGejrvDIhPYvhhrEfdd0EUtH7Q1sD7UWSb1GB0ZIQYBMGAdqS1A2l6rv+Wj
	itLHF+wt+iwb+zloysbhsBTvQxN3e2B5eYC+L6h2SPFbf3B+G3A++/Qj5r7xGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIr8PIjOp2TyyKOdH8u8fZj5X/jAii2VV5ATHFUv2gk=;
	b=Jbe4KBzqNDPAPIuCq14fmoolIa0neryeBrjOY6JszTDwgx2yabenxKHRbZRr2VcFr5JdLG
	1yCAql42LiyYB3Dw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/stackprotector: Move __stack_chk_guard to percpu
 hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-11-brgerst@gmail.com>
References: <20250303165246.2175811-11-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458932.14745.2033752798104198399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f9bf822a1642aedb986b1a7dbdfa658de999b7c6
Gitweb:        https://git.kernel.org/tip/f9bf822a1642aedb986b1a7dbdfa658de999b7c6
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:29 +01:00

x86/stackprotector: Move __stack_chk_guard to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-11-brgerst@gmail.com
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb58..cd761b1 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3f45fdd..5809534 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2147,7 +2147,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif

