Return-Path: <linux-tip-commits+bounces-4946-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D341A8735B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C845B1894C08
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED982080C4;
	Sun, 13 Apr 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8A8hTMT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k20cOr1V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891D207669;
	Sun, 13 Apr 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570594; cv=none; b=FAoLjQ6NGorQ/eNNeEC/btY/7EmpA5L2E02Uz6BndCrh96wgAGI3AIulpxJNvPeneZ+VJujv3fQTKVApQxuSo2Gc8C6YF4Chh9VxMZ06fPYYamjA1wmAVFUvUFmgjl/hecC/8DzjLgZjGvKv6BGhK5Pu1dHt7/ntSwRDo10GstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570594; c=relaxed/simple;
	bh=LkrokbLsFx+fsI5OpW05kXhKANxEGG3WN/yzIQY1tkQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=llN832swLVXrLPVU9WOUQK1WiA4OW7SmBcD+i4+xf/U7c/J5w6DQbfebTomHk/K85rAEzPrkXJOQibddyVDK0mq9NxENCezmild+Dg/TGC/cdQuRBfig1ZEtTrOyc0xBvXy3+qaBZQ1ip93yXQXbILFArVBDoha4/YDRLgfOHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q8A8hTMT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k20cOr1V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Ij/nHf2YbZGLGnneW9awWUyHdsUu99hRR1MDQw9BGpI=;
	b=q8A8hTMT2DQ0cja1hI4qPGPr+aFFGKObDsbOoyIP4XfD2Y5YkCMb9RbsQEGkQTMtGVPjui
	W+EBxkR41I6Q5XPHkf5sXNtkhXPbUNBOSWsfpPuw3khNmoq4YrRDQVP6gg4z80JpSDdTnR
	X/g6qtZtrIHOx0ConkauPG3Lljqu2TU01DGIdIPikHTbI6cO4TnjqAqpx0nZiNMP/gLWGp
	JZTqlAO70xPFdK45KT6At/y22PSyw9p3nQNw0hAqYsFCbjj4YJODm2V5KA0oGZ3caea+cE
	59t5BaohkNo2ZqYUjKw0w4mwcED+dSjVm1AapBEt+dKoevtg4mAJR1XuhUVVCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Ij/nHf2YbZGLGnneW9awWUyHdsUu99hRR1MDQw9BGpI=;
	b=k20cOr1VbhPSJD8yoTngO2Zl7IbJMTkFnh/x6Uab6ZtEpXZgydDlCalW+nfBiftNUxr+VQ
	Wo0kAGMfJ5je5UCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Standardize on u64 in <asm/msr.h>
Cc: Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@intel.com>, Xin Li <xin@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457058811.31282.17354571412795347500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     dfe2574ce87e031c0c37d49b9bee7e1f3c95bff9
Gitweb:        https://git.kernel.org/tip/dfe2574ce87e031c0c37d49b9bee7e1f3c95bff9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:57:40 +02:00

x86/msr: Standardize on u64 in <asm/msr.h>

There's 9 uses of 'unsigned long long' in <asm/msr.h>, which is
really the same as 'u64', which is used 34 times.

Standardize on u64.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/msr.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 9397a31..8ee6fc6 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -48,7 +48,7 @@ struct saved_msrs {
 #define EAX_EDX_VAL(val, low, high)	((low) | (high) << 32)
 #define EAX_EDX_RET(val, low, high)	"=a" (low), "=d" (high)
 #else
-#define DECLARE_ARGS(val, low, high)	unsigned long long val
+#define DECLARE_ARGS(val, low, high)	u64 val
 #define EAX_EDX_VAL(val, low, high)	(val)
 #define EAX_EDX_RET(val, low, high)	"=A" (val)
 #endif
@@ -79,7 +79,7 @@ static inline void do_trace_rdpmc(unsigned int msr, u64 val, int failed) {}
  * think of extending them - you will be slapped with a stinking trout or a frozen
  * shark will reach you, wherever you are! You've been warned.
  */
-static __always_inline unsigned long long __rdmsr(unsigned int msr)
+static __always_inline u64 __rdmsr(unsigned int msr)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -113,9 +113,9 @@ do {							\
 	__wrmsr((msr), (u32)((u64)(val)),		\
 		       (u32)((u64)(val) >> 32))
 
-static inline unsigned long long native_read_msr(unsigned int msr)
+static inline u64 native_read_msr(unsigned int msr)
 {
-	unsigned long long val;
+	u64 val;
 
 	val = __rdmsr(msr);
 
@@ -125,7 +125,7 @@ static inline unsigned long long native_read_msr(unsigned int msr)
 	return val;
 }
 
-static inline unsigned long long native_read_msr_safe(unsigned int msr,
+static inline u64 native_read_msr_safe(unsigned int msr,
 						      int *err)
 {
 	DECLARE_ARGS(val, low, high);
@@ -179,7 +179,7 @@ extern int wrmsr_safe_regs(u32 regs[8]);
  * CPU can and will speculatively execute that RDTSC, though, so the
  * results can be non-monotonic if compared on different CPUs.
  */
-static __always_inline unsigned long long rdtsc(void)
+static __always_inline u64 rdtsc(void)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -196,7 +196,7 @@ static __always_inline unsigned long long rdtsc(void)
  * be impossible to observe non-monotonic rdtsc_unordered() behavior
  * across multiple CPUs as long as the TSC is synced.
  */
-static __always_inline unsigned long long rdtsc_ordered(void)
+static __always_inline u64 rdtsc_ordered(void)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -224,7 +224,7 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static inline unsigned long long native_read_pmc(int counter)
+static inline u64 native_read_pmc(int counter)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -280,7 +280,7 @@ static inline int wrmsr_safe(unsigned int msr, u32 low, u32 high)
 	__err;							\
 })
 
-static inline int rdmsrl_safe(unsigned int msr, unsigned long long *p)
+static inline int rdmsrl_safe(unsigned int msr, u64 *p)
 {
 	int err;
 

