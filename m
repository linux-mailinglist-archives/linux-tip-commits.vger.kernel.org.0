Return-Path: <linux-tip-commits+bounces-4939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD1A8734C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A5B171BD3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0401FECA5;
	Sun, 13 Apr 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJsMVH1b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DSoZ6fP7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F951FAC50;
	Sun, 13 Apr 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570587; cv=none; b=H3sRkD/AM3kHQDmSjmpig3th5iCnkbWX5mBa3YDs0cTihzQQOG7cINgZWpLtREFtjtUgKBd0xycM9QtW11Ui2lRKAdHX/QQLmjf8tcaGxKqgbSHldwXszZWzNZY75AiQU2adJHBB9hG8paFVVi7FoGwujacXwkfUUWUCh2ua/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570587; c=relaxed/simple;
	bh=u5QSug6JVm0qMpeu/qksRkPaUZpGh3k3koefKoUJjeM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uBtc0KGD0q5lAg0ZDj8JoBMfEofIzbxjixJ50WUtpvxabLbVido0H5ToMJxQMHTeQNtxaRzGvK3Y9EPD1cYSeR32zke7NNElDHUesHr3Up+H01svwKPmOhM78+t0vGJVaFGc9F7ykCGfqsf4s5hZR5eVphaeIhmmtJ1vG4rfNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJsMVH1b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DSoZ6fP7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Y5Cfms84MuLCiL+9oy9FbEUe+PXgeF/LJ6ooUk5trIA=;
	b=iJsMVH1b8HzB9mOQdfbT0ZHq+H2ggDRaF5fpsk2QqwGTQExiERgLrsAXHKdzznjWn2QC4g
	1MSaYW3vPRf7br1TPf+ZSwgl4ZoPqEVlUZ3Vwew9BYAkyek4PsfBipLOq5wlyHN7FvVhJl
	Gd1K6G6Sg5GVRFh6oA8axaWdwh90/LdFs/9fZdQLxCNvmRRzblmgL10v7L91KP+P4Qy9EV
	BcF+xSVjWCdo/j0ZYXcMDUWZ5hig+2HuN1Q28MR5YQZK3M4wzTetJDHEStgn9hgDCKaLBq
	c9V40O1rCkw2RiFr+qh6kmzsg1D6IirBxskTlVUE/zNICunBLwLqMWkNttUBGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Y5Cfms84MuLCiL+9oy9FbEUe+PXgeF/LJ6ooUk5trIA=;
	b=DSoZ6fP76GWNm/HLqKocDSWItZ0kBh1MLc6PK4qC3iouga8fwUpXMxD+Hj+Yn0mSmAinvm
	jpo0IUQ0MknyXXAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/msr] x86/msr: Standardize on 'u32' MSR indices in <asm/msr.h>
Cc: Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457058353.31282.719608557428598206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     d58c04cf1d702fd6e133e89130f11a2ccd9269fa
Gitweb:        https://git.kernel.org/tip/d58c04cf1d702fd6e133e89130f11a2ccd9269fa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:20 +02:00

x86/msr: Standardize on 'u32' MSR indices in <asm/msr.h>

This is the customary type used for hardware ABIs.

Suggested-by: Xin Li <xin@zytor.com>
Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/msr.h | 29 ++++++++++++++---------------
 arch/x86/lib/msr.c         |  4 ++--
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index ec5c873..2f5a661 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -63,12 +63,12 @@ struct saved_msrs {
 DECLARE_TRACEPOINT(read_msr);
 DECLARE_TRACEPOINT(write_msr);
 DECLARE_TRACEPOINT(rdpmc);
-extern void do_trace_write_msr(unsigned int msr, u64 val, int failed);
-extern void do_trace_read_msr(unsigned int msr, u64 val, int failed);
+extern void do_trace_write_msr(u32 msr, u64 val, int failed);
+extern void do_trace_read_msr(u32 msr, u64 val, int failed);
 extern void do_trace_rdpmc(u32 msr, u64 val, int failed);
 #else
-static inline void do_trace_write_msr(unsigned int msr, u64 val, int failed) {}
-static inline void do_trace_read_msr(unsigned int msr, u64 val, int failed) {}
+static inline void do_trace_write_msr(u32 msr, u64 val, int failed) {}
+static inline void do_trace_read_msr(u32 msr, u64 val, int failed) {}
 static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
 #endif
 
@@ -79,7 +79,7 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
  * think of extending them - you will be slapped with a stinking trout or a frozen
  * shark will reach you, wherever you are! You've been warned.
  */
-static __always_inline u64 __rdmsr(unsigned int msr)
+static __always_inline u64 __rdmsr(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -91,7 +91,7 @@ static __always_inline u64 __rdmsr(unsigned int msr)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
+static __always_inline void __wrmsr(u32 msr, u32 low, u32 high)
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
@@ -113,7 +113,7 @@ do {							\
 	__wrmsr((msr), (u32)((u64)(val)),		\
 		       (u32)((u64)(val) >> 32))
 
-static inline u64 native_read_msr(unsigned int msr)
+static inline u64 native_read_msr(u32 msr)
 {
 	u64 val;
 
@@ -125,8 +125,7 @@ static inline u64 native_read_msr(unsigned int msr)
 	return val;
 }
 
-static inline u64 native_read_msr_safe(unsigned int msr,
-						      int *err)
+static inline u64 native_read_msr_safe(u32 msr, int *err)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -142,7 +141,7 @@ static inline u64 native_read_msr_safe(unsigned int msr,
 
 /* Can be uninlined because referenced by paravirt */
 static inline void notrace
-native_write_msr(unsigned int msr, u32 low, u32 high)
+native_write_msr(u32 msr, u32 low, u32 high)
 {
 	__wrmsr(msr, low, high);
 
@@ -152,7 +151,7 @@ native_write_msr(unsigned int msr, u32 low, u32 high)
 
 /* Can be uninlined because referenced by paravirt */
 static inline int notrace
-native_write_msr_safe(unsigned int msr, u32 low, u32 high)
+native_write_msr_safe(u32 msr, u32 low, u32 high)
 {
 	int err;
 
@@ -251,7 +250,7 @@ do {								\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
-static inline void wrmsr(unsigned int msr, u32 low, u32 high)
+static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
 	native_write_msr(msr, low, high);
 }
@@ -259,13 +258,13 @@ static inline void wrmsr(unsigned int msr, u32 low, u32 high)
 #define rdmsrl(msr, val)			\
 	((val) = native_read_msr((msr)))
 
-static inline void wrmsrl(unsigned int msr, u64 val)
+static inline void wrmsrl(u32 msr, u64 val)
 {
 	native_write_msr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
 }
 
 /* wrmsr with exception handling */
-static inline int wrmsr_safe(unsigned int msr, u32 low, u32 high)
+static inline int wrmsr_safe(u32 msr, u32 low, u32 high)
 {
 	return native_write_msr_safe(msr, low, high);
 }
@@ -280,7 +279,7 @@ static inline int wrmsr_safe(unsigned int msr, u32 low, u32 high)
 	__err;							\
 })
 
-static inline int rdmsrl_safe(unsigned int msr, u64 *p)
+static inline int rdmsrl_safe(u32 msr, u64 *p)
 {
 	int err;
 
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 20f5c36..7b90f54 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -122,14 +122,14 @@ int msr_clear_bit(u32 msr, u8 bit)
 EXPORT_SYMBOL_GPL(msr_clear_bit);
 
 #ifdef CONFIG_TRACEPOINTS
-void do_trace_write_msr(unsigned int msr, u64 val, int failed)
+void do_trace_write_msr(u32 msr, u64 val, int failed)
 {
 	trace_write_msr(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_write_msr);
 EXPORT_TRACEPOINT_SYMBOL(write_msr);
 
-void do_trace_read_msr(unsigned int msr, u64 val, int failed)
+void do_trace_read_msr(u32 msr, u64 val, int failed)
 {
 	trace_read_msr(msr, val, failed);
 }

