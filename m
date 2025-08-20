Return-Path: <linux-tip-commits+bounces-6288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23AB2D908
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ECA5E1265
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F92EA734;
	Wed, 20 Aug 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cEXYRpW8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iv2z63vi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F82DE6F8;
	Wed, 20 Aug 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682753; cv=none; b=ZFHJIKtf7Je/8YCfON8/blG1onoK2eIeq4L+EUvUEUN1vVPfFiSyokI3FQAoVyUCvjDahkwV2H+bvt0nBCgu79ef0LSf2sF2X1NqulH7pvwW9f8U4TFJAjxWOXXCAa/scaj93PgfbrOkocGPdieDH5/f/p4tD4uep2GecCdXyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682753; c=relaxed/simple;
	bh=Ny4Kj+fkkTCigIVSBV6NIe+E1ggIXHWNCt70vYCzoYQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LdQrbWxfOLb52rsLQ8FH64u3MJhlJmJG8BypQxMZHjQUM2wG3VZGrF/t1sE9uHh0KAPFQmMPvpFl7CSNnBiymhC7zLqi6wUJtbkrJGbiXgxktc95u5adCSUO8aWYywomMhUNWrdfgmfrp4CtAAiVa9qlh5PYfv7E3ZmI06PXUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cEXYRpW8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iv2z63vi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Tf5MZvDOqM6bmx8VRP1S8Ng4CkPIeBQ/8UVpGsgPcY=;
	b=cEXYRpW8F7W3XVcxT++yK5rMHyy9sSKXObZ45oh9Ecm0Pe95EzK6Gz48g+RTPqgFVzsyTL
	ojwxO1n2DAoY/7Wyz3tX+cfN37ZgOJIQJwN23ujBDk3Hd4kelTudl/UdGslre0ft/+1V5T
	JZQpKsb2b8beR92S3zw4goy9Sxk8onJJk4JOhSlNCh/tn9hTqhdA0O2mFPnhmPkw2lL2Uv
	MjRC0OpcdtICGhwzf6N4hYXGukGqbKWrzk8Rg5gYrKXf7s+qAifKsp7CGBlY7MTDdigHwD
	6YlHuXzhINUGR3FXFuwkgj5GZd0KbJevlSDuFFZ8zbKrxde3f8FmV1wErdrSnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Tf5MZvDOqM6bmx8VRP1S8Ng4CkPIeBQ/8UVpGsgPcY=;
	b=iv2z63vi/vrP+9Tm7smMKnzrFGJUEvZlYITC7TwMWoJjeu+OD+cSoUENlq95cspGZtj3OW
	YwsxZ+S4yn+3glBg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/fred: Install system vector handlers even if FRED
 isn't fully enabled
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103441.121251108@infradead.org>
References: <20250714103441.121251108@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568274822.1420.17443481376586492371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2d1435b742156f6d4adc8b9ab0f24b35d879266e
Gitweb:        https://git.kernel.org/tip/2d1435b742156f6d4adc8b9ab0f24b35d87=
9266e
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 02 May 2025 07:24:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:08 +02:00

x86/fred: Install system vector handlers even if FRED isn't fully enabled

Install the system vector IRQ handlers for FRED even if FRED isn't fully
enabled in hardware.  This will allow KVM to use the FRED IRQ path even
on non-FRED hardware, which in turn will eliminate a non-CFI indirect CALL
(KVM currently invokes the IRQ handler via an IDT lookup on the vector).

[sean: extract from diff, drop stub, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250714103441.121251108@infradead.org
---
 arch/x86/include/asm/idtentry.h |  9 ++-------
 arch/x86/kernel/irqinit.c       |  6 ++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a4ec27c..abd637e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -460,17 +460,12 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #endif
=20
 void idt_install_sysvec(unsigned int n, const void *function);
-
-#ifdef CONFIG_X86_FRED
 void fred_install_sysvec(unsigned int vector, const idtentry_t function);
-#else
-static inline void fred_install_sysvec(unsigned int vector, const idtentry_t=
 function) { }
-#endif
=20
 #define sysvec_install(vector, function) {				\
-	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
+	if (IS_ENABLED(CONFIG_X86_FRED))				\
 		fred_install_sysvec(vector, function);			\
-	else								\
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))			\
 		idt_install_sysvec(vector, asm_##function);		\
 }
=20
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index f79c5ed..6ab9eac 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -97,9 +97,11 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
=20
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	/* FRED's IRQ path may be used even if FRED isn't fully enabled. */
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_complete_exception_setup();
-	else
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_setup_apic_and_irq_gates();
=20
 	lapic_assign_system_vectors();

