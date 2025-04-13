Return-Path: <linux-tip-commits+bounces-4940-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C901A8734E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C216665D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900E1F3BA8;
	Sun, 13 Apr 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzq3UNzt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRVcrZe1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA81FDE1E;
	Sun, 13 Apr 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570589; cv=none; b=uhuXYkZBvbVIQoQVVUP77IBAmM7a/LfWOVlgtbVPD/8ebsqcV4j1qYBye5iCGoE/H1TgdKhT0MNZnOpD/nxJ/Btm+BNrCUCzeln4is2wDPOWJjnFGFR0zbK2Izqh3zZ+WFU/A3X/kK2bokyfAMW06CMjsdUHxq0gxx3s4ssli7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570589; c=relaxed/simple;
	bh=1Npikk48GFIN6nPyO/iMNNdMrJyFFpZvV1KWVD2c/Po=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=D5anLQj0k/Yc+gZsgy1Vccu2lbs9fAiZ11bt06NhRqrjLcoKrU9VvAuHrcr4tQsYzuUi23r5eKy/dABaz637LjKmfE/cH/QNJfkMqY8m022mPTyeUkHtvMWuAFcaM8RdsSnhk+llKucO1RlQ22GRK0D+GhPh7TC1W/6AR/QguHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzq3UNzt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRVcrZe1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FaTZ8S4TEm84CVLKfXatnvuJvdEmJxZ66T93WRZTmuQ=;
	b=jzq3UNztSes4nrRtkjkkUSG3QVTDNJzdh9/Hquaap2GNBK6rQ9U+pH0cAkD4YFLwyKpDwl
	Xg70vgyStOL7SeCdgVR9IEC5Ymoq7cdGRLFUP2Mb05A4BZrAIh7pvXHJXF6IwApXxxMs5S
	ZiJKpIL1eghU91WmAly+3/1v/+FYKrBgAH0fJ8WNr4EXvbUk5Cm8YrdOFyfQUtBmJBFlWu
	YUtbKam72iFu6j2TM2COqooORsTrfHjyKHzm1xzTY4vbYXkOINLY91HFAzLBbtc1nR9A0o
	n2RFnS5knlmLx4Ws+peqVYIigcl3Vrxb6PzIG7J9DnpQSN3Q1UhNOyjJ8YjpEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FaTZ8S4TEm84CVLKfXatnvuJvdEmJxZ66T93WRZTmuQ=;
	b=wRVcrZe1ZXHpzP+gRWO/hqgCyerJO6S5wulp+a10F95w+tT1ojECs9mrOKTBUO0QjPGtJG
	qYpaKqS67L6RPIBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Harmonize the prototype and definition of
 do_trace_rdpmc()
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
Message-ID: <174457058440.31282.15397149748386600908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     d8f8aad698b85f197c877ec51f8585e2b2abb195
Gitweb:        https://git.kernel.org/tip/d8f8aad698b85f197c877ec51f8585e2b2abb195
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:13 +02:00

x86/msr: Harmonize the prototype and definition of do_trace_rdpmc()

In <asm/msr.h> the first parameter of do_trace_rdpmc() is named 'msr':

   extern void do_trace_rdpmc(unsigned int msr, u64 val, int failed);

But in the definition it's 'counter':

   void do_trace_rdpmc(unsigned counter, u64 val, int failed)

Use 'msr' in both cases, and change the type to u32.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/msr.h | 4 ++--
 arch/x86/lib/msr.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 8ee6fc6..ec5c873 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -65,11 +65,11 @@ DECLARE_TRACEPOINT(write_msr);
 DECLARE_TRACEPOINT(rdpmc);
 extern void do_trace_write_msr(unsigned int msr, u64 val, int failed);
 extern void do_trace_read_msr(unsigned int msr, u64 val, int failed);
-extern void do_trace_rdpmc(unsigned int msr, u64 val, int failed);
+extern void do_trace_rdpmc(u32 msr, u64 val, int failed);
 #else
 static inline void do_trace_write_msr(unsigned int msr, u64 val, int failed) {}
 static inline void do_trace_read_msr(unsigned int msr, u64 val, int failed) {}
-static inline void do_trace_rdpmc(unsigned int msr, u64 val, int failed) {}
+static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
 #endif
 
 /*
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 5a18ecc..20f5c36 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -136,9 +136,9 @@ void do_trace_read_msr(unsigned int msr, u64 val, int failed)
 EXPORT_SYMBOL(do_trace_read_msr);
 EXPORT_TRACEPOINT_SYMBOL(read_msr);
 
-void do_trace_rdpmc(unsigned counter, u64 val, int failed)
+void do_trace_rdpmc(u32 msr, u64 val, int failed)
 {
-	trace_rdpmc(counter, val, failed);
+	trace_rdpmc(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_rdpmc);
 EXPORT_TRACEPOINT_SYMBOL(rdpmc);

