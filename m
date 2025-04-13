Return-Path: <linux-tip-commits+bounces-4928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A6A8733E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B901188FAC5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA21F3D5D;
	Sun, 13 Apr 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="geUHfJD6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="16CTJFo9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9D1F37DA;
	Sun, 13 Apr 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570575; cv=none; b=tWoVprkCmTbHuFG5iJYyME5IbWkxmmsmExpDhcg1pWCg5UClqISQ216HCinnrnpF9Z666wgz5lq86IJeWaAJy4FQ1wnV4v4z1sSfAObTBhcID1KPWGUOozNo/5T/DEocwBSBViee7L4+PaKBE47eudVC8FjfVjFrJlwJ2qcOO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570575; c=relaxed/simple;
	bh=gTmP5s+8BtDfqBwi296aTYqmbSREfmFo21TZTYyOTws=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XLjNmLkadiniSR8eCWSwAHDqTcqepXNcv6aDJRzc4kbGWvLJidmiielzB4JW7kUXq24gQQigp4hONonScVWkOTsNkWQS2lCGqjvJ+Wwms7tP2kvqMMUVVZpn79dvG6nCZu39CLLv/o0phLjzWrG+7TMKib5yGDw6BWcyof824vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=geUHfJD6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=16CTJFo9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kmXOdkThzglvvmkjstpxa20/vrTkya7qZvWzR8mNuSg=;
	b=geUHfJD6hm6mAbjPjeBvASBCmvo7YvrYIQKy/iiN7lb87oEzv17rHCpUrixX8Ul9neLBzJ
	xDkAuEKKqXZtpgqaDxDp9Gfs0h/9d40ICirk93dBl9wOnPS1FdWTF0AMe8HuU3HsUz73/z
	sGr3ePV9LlfMZf/4DxpGxtlyTm8cMprLZnwg/cQ2wcI2r3072ScEX+8iChjrKl/Ot7vJrj
	JWNf1AxkPidQ3hj6n3gO635zVZHjUjzdqwf/tRbyao+itsqfa3xHCZDeWthTOMPg5Jia2T
	eTWcGl3fh/oP5pdEBv5PuW/gL/o9eC+B0HeP0WNgCQJmG46aVl2TvPq2188qWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kmXOdkThzglvvmkjstpxa20/vrTkya7qZvWzR8mNuSg=;
	b=16CTJFo90G/QvGsI98jnM/tZQZhvUMm7FwhPTdz8xUblCK89TBqf8m1PDxj5ATRoGrj2so
	VsyS6W2ukVcgefCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/msr] x86/msr: Rename 'wrmsrl_amd_safe()' to 'wrmsrq_amd_safe()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457057035.31282.14016038025952191948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     604d15d15ebd6148a084ea53d0fa493a74e51b11
Gitweb:        https://git.kernel.org/tip/604d15d15ebd6148a084ea53d0fa493a74e51b11
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:24 +02:00

x86/msr: Rename 'wrmsrl_amd_safe()' to 'wrmsrq_amd_safe()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0aefa41..0bbe798 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -49,7 +49,7 @@ static inline int rdmsrq_amd_safe(unsigned msr, u64 *p)
 	return err;
 }
 
-static inline int wrmsrl_amd_safe(unsigned msr, u64 val)
+static inline int wrmsrq_amd_safe(unsigned msr, u64 val)
 {
 	u32 gprs[8] = { 0 };
 
@@ -638,7 +638,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrq_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
-			wrmsrl_amd_safe(0xc001100d, value);
+			wrmsrq_amd_safe(0xc001100d, value);
 		}
 	}
 

