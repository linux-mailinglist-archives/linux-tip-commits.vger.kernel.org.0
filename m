Return-Path: <linux-tip-commits+bounces-7998-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741AD1E292
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4B79302B8FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6C396B75;
	Wed, 14 Jan 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ip/5SLiO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3gUNrU/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C8395D85;
	Wed, 14 Jan 2026 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387225; cv=none; b=joOowg2WOMlSjUsQ0GAeoXBhiCXVEbGXVgD0J2HzqjRS5XsQF/tG9tQGPYdcDA5NiUeFXs0EjdXj7ak2lBRypgi5UHUadYNPxMcvyqzFUGJ7ORkr+KTYiG3rvQyL694/azeuSxmujM62EIpDBc2+bwSQbLKMU99AVaYmu8V4mF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387225; c=relaxed/simple;
	bh=4vQe4av1JrrGvDNa4mf/IO/aRLf+I1LtkuYkP5cemoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kGCPSLtFROHNg/eAMp/FJNOHzGqvMU72PkMWf4MBFQNaJPilMVAg6RQExAAZHcrSpx+8h0g4gC6SRYNXvqwFRwKLKkGc1/nDD1EK/uV9WLOFlWK4JWFUepiOqjJUehBgGHu0Ivf6JP1bSiVHL6wct4+v6p4DaoOoTdyKjqAsEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ip/5SLiO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3gUNrU/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgQiiCwEVZS9E6GnUJOtaQ1JE4a5blcv8iQJOf5JLOM=;
	b=ip/5SLiORZ5dQExmrxHv14zBUERxbsnoOv6CELyJyRVX3/dkoGD8NGAZSWuD5D/CY/pzwE
	UW84vafFecRGLnCpxVjWpWg9mOCc8KoxVR3Lp6thbIv7Bb7vFlcJikmLQNq7Z1YjfDfXEz
	UsnP1Svh6Bw/Z9RUeT3fwb0TlLL0vZIHQL099OdZC5qLJCdRuQihcgJ+oGC08oPSESHmAV
	JeQT8X2H85fekHzLqp7AB4QxEgkqDQwfKuIqwnxCy9l8tG+ZiF/UJ8w2af42uFPUtQcx2H
	IrAGRQ259RcCfubSO7aoKvBbbB0jiHtiDj2hyCDkvzcaRiUyRJfMmH/T31va7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgQiiCwEVZS9E6GnUJOtaQ1JE4a5blcv8iQJOf5JLOM=;
	b=b3gUNrU/z0Z8c2jgc9dC7aU0QY1v8xs1Vde96zDsWrmr4Y6aO1srwTiTe+/RQkVYWCv1O4
	cnF9NE7wbP94P8Cw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Remove PARAVIRT_DEBUG config option
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-4-jgross@suse.com>
References: <20260105110520.21356-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721984.510.14253055739112654024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     d73298f015341530da84b96d8310854af90dc425
Gitweb:        https://git.kernel.org/tip/d73298f015341530da84b96d8310854af90=
dc425
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:02 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 15:20:06 +01:00

x86/paravirt: Remove PARAVIRT_DEBUG config option

The only effect of CONFIG_PARAVIRT_DEBUG set is that instead of doing a call
using a NULL pointer a BUG() is being raised.

While the BUG() will be a little bit easier to analyse, the call of NULL isn't
really that difficult to find the reason for.

Remove the config option to make paravirt coding a little bit less annoying.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-4-jgross@suse.com
---
 arch/x86/Kconfig                      | 7 -------
 arch/x86/include/asm/paravirt.h       | 1 -
 arch/x86/include/asm/paravirt_types.h | 8 --------
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8052729..1f30358 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -809,13 +809,6 @@ config PARAVIRT_XXL
 	bool
 	depends on X86_64
=20
-config PARAVIRT_DEBUG
-	bool "paravirt-ops debugging"
-	depends on PARAVIRT && DEBUG_KERNEL
-	help
-	  Enable to debug paravirt_ops internals.  Specifically, BUG if
-	  a paravirt_op is missing when it is called.
-
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 612b3df..fd98263 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -12,7 +12,6 @@
 #include <asm/nospec-branch.h>
=20
 #ifndef __ASSEMBLER__
-#include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/static_call_types.h>
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index 09ec8dc..bd83528 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -354,12 +354,6 @@ extern struct paravirt_patch_template pv_ops;
 #define VEXTRA_CLOBBERS	 , "rax", "r8", "r9", "r10", "r11"
 #endif	/* CONFIG_X86_32 */
=20
-#ifdef CONFIG_PARAVIRT_DEBUG
-#define PVOP_TEST_NULL(op)	BUG_ON(pv_ops.op =3D=3D NULL)
-#else
-#define PVOP_TEST_NULL(op)	((void)pv_ops.op)
-#endif
-
 #define PVOP_RETVAL(rettype)						\
 	({	unsigned long __mask =3D ~0UL;				\
 		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
@@ -388,7 +382,6 @@ extern struct paravirt_patch_template pv_ops;
 #define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
-		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
 				ALT_CALL_ALWAYS)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
@@ -402,7 +395,6 @@ extern struct paravirt_patch_template pv_ops;
 			  extra_clbr, ...)				\
 	({								\
 		PVOP_CALL_ARGS;						\
-		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
 				 alt, cond)				\

