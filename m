Return-Path: <linux-tip-commits+bounces-5069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91039A934DC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C1B8A7D44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181518C0E;
	Fri, 18 Apr 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZT46yAr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pmp51lon"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD726B953;
	Fri, 18 Apr 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965988; cv=none; b=q2SMonbeNipzjwlsKGvRF4ZAe2fp919Y+r7nDRW7kR0tcA97HOfullxibcFn+duRoa9YdLgdhGlhlMDzt5aLc67kQf2v4QWWS8B6odi25UbXS4YTupw1GBzLer24KYUkUB6//EZxsRiI1U6tPSrEMPo/9QMcSF6fB5xYOD/fs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965988; c=relaxed/simple;
	bh=+Cc25vvKy+5mvNPyRyTVbOhsN/ihcuZDTwoJBOaM+4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jUmp57YiJ0j09LZYBXJVJbKtlqPpbYr+jBeExUdbxT7VdTG4RSi3Pc9wOdB/fcJRKdkWsiFitcryBlBtfMYSJncc3m5Oxka+Lgrwq84qhyDXzBRrUlmwkag9oSeHQKeCl3LMcuhDKjPc3f0nvct5j8LD69RnuQpioU+pUwO6llQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZT46yAr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pmp51lon; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:46:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965984;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dO084SNAiu318Zmp1NSoQBV6HFjNGRBAP7yjcnBm9E=;
	b=eZT46yArxyGCALFERkZQWZa+brY90986N+TKK244p9gcnkKQYVv4xPKLYftkdJaE+vN7Aq
	es0xcFm3NXr+WuSQCBnjony5o4fXIEai9cPV1a6hGhKIwUIi1FbNeGcmXYAHlOwcrYPaDp
	XT70ZBUWhjgGZ9tdnLVA4Hus35JCBnTawJuHRsf7+rRqQStiIGt//K10UkogElzs0zFQXO
	y+gDRfPlNGoYnGGbmng77hxtWYW9ddzuJG2qV2cwb1OG8QDqZwa9Y43W7MbE2hGo5ZfMm7
	07R/e5QQdCmHH8+4t9ffXOhsqaxa3Kn9ZTNXRApWAoI6DZJ7ZJYihHvAd2O7TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965984;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dO084SNAiu318Zmp1NSoQBV6HFjNGRBAP7yjcnBm9E=;
	b=Pmp51lonOg7EFK1Jy318Jc3dnckDkwPay9Cr7IV+7/awmwko+oQL4bmp6uJZlU732UYONZ
	eqEmo0sw5lOjhSDg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Rename rep_nop() to native_pause()
Cc: David Laight <david.laight.linux@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418080805.83679-1-ubizjak@gmail.com>
References: <20250418080805.83679-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496598375.31282.2315987383086713800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3ce4b1f1f24bbd9f1c349ecb6641dfa038bd0b5a
Gitweb:        https://git.kernel.org/tip/3ce4b1f1f24bbd9f1c349ecb6641dfa038bd0b5a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 18 Apr 2025 10:07:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:19:26 +02:00

x86/asm: Rename rep_nop() to native_pause()

Rename rep_nop() function to what it really does.

No functional change intended.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250418080805.83679-1-ubizjak@gmail.com
---
 arch/x86/include/asm/vdso/processor.h | 4 ++--
 arch/x86/kernel/apic/io_apic.c        | 2 +-
 arch/x86/lib/delay.c                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index 240d761..7000aeb 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -8,14 +8,14 @@
 #ifndef __ASSEMBLER__
 
 /* PAUSE is a good thing to insert into busy-wait loops. */
-static __always_inline void rep_nop(void)
+static __always_inline void native_pause(void)
 {
 	asm volatile("pause" ::: "memory");
 }
 
 static __always_inline void cpu_relax(void)
 {
-	rep_nop();
+	native_pause();
 }
 
 struct getcpu_cache;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index eebc360..ba5a4cc 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1486,7 +1486,7 @@ static void __init delay_with_tsc(void)
 	 * 1 GHz == 40 jiffies
 	 */
 	do {
-		rep_nop();
+		native_pause();
 		now = rdtsc();
 	} while ((now - start) < 40000000000ULL / HZ &&	time_before_eq(jiffies, end));
 }
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index e86eda2..eb2d2e1 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -75,7 +75,7 @@ static void delay_tsc(u64 cycles)
 
 		/* Allow RT tasks to run */
 		preempt_enable();
-		rep_nop();
+		native_pause();
 		preempt_disable();
 
 		/*

