Return-Path: <linux-tip-commits+bounces-2862-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF69C86CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BF01F26D4F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBD1F8F06;
	Thu, 14 Nov 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nra8e2ZG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjg28+SR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE991F8186;
	Thu, 14 Nov 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578476; cv=none; b=IUFNh6LFysyxl2mVWodJV3y11ssQ179VXDtG9YPIYmL8v/HM/XqH1I6rZpmLCUpPKWVc2nU5ZT14tNbYUPGxq8/Q1nPntE64Fi0DXMVvWYfd6JlrU7jK5D2rUBkD49gpa4eJFzN2BxHVgwhhH0x0p3gfmE+JwecvRGOfRhtEQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578476; c=relaxed/simple;
	bh=KmPRysFMvhl+JlDBJNOVc1csFSz+gilMtsAHQKZvYJc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m2XfpEMuOzWkPa5UFx13RpXKDzb6f1ijQk+i8g0CaIzQjdOFrT1W9LiH6/5jPtO5jWmna4CDem8F7jVZ3dCR12C/7lg7zA+hZ9XP6rQQLvJkWQ9mUtyuHRzcLpOgPewZhrIL87BedAz5zYf65fLwlnu3uj+b42WZH3/vP8IyhwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nra8e2ZG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjg28+SR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 10:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731578472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A40SpV4SeTrKBfpDcV1HKNuZOAEHFqaKrRt4YOI5JA=;
	b=Nra8e2ZGugInGwywM/6EfQ9Oy32NO/Y+qUZFpOtQRPQT6BUGwXAeZEKkFrSUexhiqfTJ18
	IsEtg2EwLc+szLUwGfpaCqqMu51gC3Q7i6dIUC4Kr3EkMaA4Ffi/H9WOVjjnDWr/RCZxbz
	3Hv35YyUkcUf0qdoLRILL8ko91yRRrVDmhrh2ZD0mzVHJBP6khEhLbqCxpYVzo1Y11GPG3
	OyoV4bqICiEJxTZPwetY5/oXf1ZICvZXoVGmdGwN+7pzC74lwgVjTOI5J8Ba/49hVMjzNq
	AqeGNL1JVWdW2vVgQvAVyhtbCE7+IBUOfzrRKgEsA0vxPBza2P2cc224BxvTMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731578472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A40SpV4SeTrKBfpDcV1HKNuZOAEHFqaKrRt4YOI5JA=;
	b=bjg28+SRmUvrkCYvByyH9Fu30xlnC8/Gon85E4PMjfkK0ojh4Sl/7YJNPBXxKgpZRmJLFL
	DDejK6yiDwa24YCg==
From: "tip-bot2 for Colton Lewis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/arm: Drop unused functions
Cc: Colton Lewis <coltonlewis@google.com>, Ingo Molnar <mingo@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Will Deacon <will@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241113190156.2145593-2-coltonlewis@google.com>
References: <20241113190156.2145593-2-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173157847146.32228.13373322144306386427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e33ed362cf9e35db6082f7a776b7e8d557407e19
Gitweb:        https://git.kernel.org/tip/e33ed362cf9e35db6082f7a776b7e8d557407e19
Author:        Colton Lewis <coltonlewis@google.com>
AuthorDate:    Wed, 13 Nov 2024 19:01:51 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 14 Nov 2024 10:40:00 +01:00

perf/arm: Drop unused functions

For ARM's implementation, perf_instruction_pointer() and
perf_misc_flags() are equivalent to the generic versions in
include/linux/perf_event.h so arch/arm doesn't need to provide its
own versions. Drop them here.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20241113190156.2145593-2-coltonlewis@google.com
---
 arch/arm/include/asm/perf_event.h |  7 -------
 arch/arm/kernel/perf_callchain.c  | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index bdbc1e5..c08f16f 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -8,13 +8,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-#ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
-#endif
-
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->ARM_pc = (__ip); \
 	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1d230ac..a2601b1 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (user_mode(regs))
-		misc |= PERF_RECORD_MISC_USER;
-	else
-		misc |= PERF_RECORD_MISC_KERNEL;
-
-	return misc;
-}

