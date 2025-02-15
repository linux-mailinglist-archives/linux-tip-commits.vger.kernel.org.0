Return-Path: <linux-tip-commits+bounces-3373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B139A36D76
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C151895764
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036C1C862A;
	Sat, 15 Feb 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byJIUmwU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kNUbmbsJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD491AB6DE;
	Sat, 15 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617004; cv=none; b=UxAxk9j4zSwuMEK51vQkEPUnoyX3SR7rosLw2tTJKrmaH6slmKjoc9E3QH4L+AXrBs08sEjwgg2FBZoczVkODQ1vYstX/EGE9JBVfEE3ajo3+t7fogs3sWnmDWL1dvko5RE/zoqdXzIM1je/rie6NTIqIq49L8o/GyIzNC3cTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617004; c=relaxed/simple;
	bh=m0nJ1zjXiIk8UXjBZs2b94PYrYIXPbZ3MDeciyJupPY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PFnJxgpvJboideC6F8L4xbtzSljcYX5NGKb6V+KRf/nPsBDc3j75jmPiCbdbYd4Cqgyqh3JCFOnirABf/gbRNO1Vc2T9nQn0uXhqqt/WZk470tsOygfLn6mvyP8gAZc28LQ1zjFjsAH4Zbj+Llv5tOrDvLFo22+/KrEFfHHddI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byJIUmwU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kNUbmbsJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FU7nz0Rse0amlSg8Tb0t2vH/i189ASouc6/jK6EKrJU=;
	b=byJIUmwUCbFXgmN+8J9DetjMBfsiu90x33LclgaRQPEcuXvw27dGZJGPNHuj/TytFN37QP
	KRTRcBGs15MLSvOozfgTYNL1wNnODr+K4/aIXef1Hy9fCUa/TO9NzlwAut/AFPbmAAZPom
	S+6nRh9471hJczi39FcwNk5ASVQHathaNJObR1f72xIRtboLVjSUv5qjqDByHeALZI2Vxo
	W901qotH0uQiFaYD6WnHavb6RW4O0iPZSPZVseXk8d71MQ07w7806txP54/3v31HIrvt3R
	QNVz10H+nbJALepcjCUzh/U4lDechHxpwrD9TJG2XgNlG4odG7bd1NMo0tO8KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FU7nz0Rse0amlSg8Tb0t2vH/i189ASouc6/jK6EKrJU=;
	b=kNUbmbsJz9atKMJR/COJHCBRtmjBfczh1pOam9td6t1eHahuvEoC4ryXJ4H0HOg2xc9N/y
	DUedCWqtLZ2lwGAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/boot: Mark start_secondary() with __noendbr
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.509520369@infradead.org>
References: <20250207122546.509520369@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699859.10177.17232869578190933667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     93f16a1ab78ca56e3cd997d1ea54c214774781ac
Gitweb:        https://git.kernel.org/tip/93f16a1ab78ca56e3cd997d1ea54c214774781ac
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:05 +01:00

x86/boot: Mark start_secondary() with __noendbr

The handoff between the boot stubs and start_secondary() are before IBT is
enabled and is definitely not subject to kCFI. As such, suppress all that for
this function.

Notably when the ENDBR poison would become fatal (ud1 instead of nop) this will
trigger a tripple fault because we haven't set up the IDT to handle #UD yet.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.509520369@infradead.org
---
 arch/x86/kernel/smpboot.c | 3 ++-
 include/linux/objtool.h   | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850a..4be0083 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -229,7 +229,7 @@ static void ap_calibrate_delay(void)
 /*
  * Activate a secondary processor.
  */
-static void notrace start_secondary(void *unused)
+static void notrace __noendbr start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* except direct CPU state initialization
@@ -314,6 +314,7 @@ static void notrace start_secondary(void *unused)
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
+ANNOTATE_NOENDBR_SYM(start_secondary);
 
 /*
  * The bootstrap kernel entry code has set these up. Save them for
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index c722a92..3ca965a 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -128,7 +128,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
-#define __ASM_ANNOTATE(label, type)
+#define __ASM_ANNOTATE(label, type) ""
 #define ASM_ANNOTATE(type)
 #else
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
@@ -147,6 +147,8 @@
  * these relocations will never be used for indirect calls.
  */
 #define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+#define ANNOTATE_NOENDBR_SYM(sym)	asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOENDBR))
+
 /*
  * This should be used immediately before an indirect jump/call. It tells
  * objtool the subsequent indirect jump/call is vouched safe for retpoline

