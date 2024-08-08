Return-Path: <linux-tip-commits+bounces-2019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D694C1E8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039681F219DA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B018FDC1;
	Thu,  8 Aug 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttoMxmHo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JoYelczR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8A18FC86;
	Thu,  8 Aug 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132157; cv=none; b=ncb8FxfiNbKBQaQLHzWP6VFiMOJsGKPHf4C/YGjVtgzy6zcg0PdGn+CifV55tAFCZwm+Bvuva1goA3eEDx3Iur8yYMs87zOdVNT8VDEBP9CPlrJzpjNOl4QTCJoEb9GrN3kiDUQEPIMHtGLuGzMtsfCTGXz7Etd0Z5+289RT+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132157; c=relaxed/simple;
	bh=pDXHpiIZSHT2GeHSGB76DDJ5I/qjtZLZ1YQoN3xvYHM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NAkOa0yaVpxKDTH1jUzidy/0WsgbIcD0ACbBZ6iMoNRNyMOqKSUffwnbvCiv66BP0/3C49RgzHz/Z6+k/uWodA9TKIkeGweYZK+MySiiKDqNZi6z3+3WngYpkTMjUuCdKmXR5O61yMfMg1nc2oh/T8WRWxFwtP//KSb71znMhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttoMxmHo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JoYelczR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:49:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723132154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46fjkmDd5kPFCZ0Yl2XBMT1VOdhgqgZ2YsfCzdfd4qw=;
	b=ttoMxmHokc49R7goTRRU7cMDrwygnV39vMgWu/4q9BU9k6xSDd17osW09TB2yNRJRDH7u+
	+vdnQSl9oKBS8Q5mKskFzpSIZogF2K3KzmyFtWXGVFr0tPsqofKVl98Ljh+EQtZa/sn3xi
	wXw5Cboiumn+wd5rVEnvmFU3fqK/Sv600fVlTpqP5QwgNVf8nVkNDMkZqoD9aNqfy6k/9t
	WpCGFVxVuMG9Lb2CJmHWXUI5ZRlZ2Pz6+gBZZ5tJ4iBjwiaRMebc5DqSlct9CPAvwqBzpv
	UudvyTdTG3jZdeAvpeLzTFCHqxL5O3X/2Tb1fAmcU4KXmM0eQd4LzZ1a0Lsq2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723132154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46fjkmDd5kPFCZ0Yl2XBMT1VOdhgqgZ2YsfCzdfd4qw=;
	b=JoYelczRqU3xT7JNo88nv28zNww5lRpYxq1I/1rh4hfBpVZTRSzAlHD8Rx5tttn1TJD1JI
	KfRb5x5H6FCKv6Aw==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86: Ignore stack unwinding in KCOV
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
References:
 <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313215346.2215.17061867082349895480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     ae94b263f5f69c180347e795fbefa051b65aacc3
Gitweb:        https://git.kernel.org/tip/ae94b263f5f69c180347e795fbefa051b65aacc3
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Tue, 11 Jun 2024 09:50:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:36:35 +02:00

x86: Ignore stack unwinding in KCOV

Stack unwinding produces large amounts of uninteresting coverage.
It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
It's not particularly useful and is not a function of system call args.
Ignore that code.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com

---
 arch/x86/kernel/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a847180..f791898 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -35,6 +35,14 @@ KMSAN_SANITIZE_nmi.o					:= n
 # If instrumentation of the following files is enabled, boot hangs during
 # first second.
 KCOV_INSTRUMENT_head$(BITS).o				:= n
+# These are called from save_stack_trace() on debug paths,
+# and produce large amounts of uninteresting coverage.
+KCOV_INSTRUMENT_stacktrace.o				:= n
+KCOV_INSTRUMENT_dumpstack.o				:= n
+KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
+KCOV_INSTRUMENT_unwind_orc.o				:= n
+KCOV_INSTRUMENT_unwind_frame.o				:= n
+KCOV_INSTRUMENT_unwind_guess.o				:= n
 
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 

