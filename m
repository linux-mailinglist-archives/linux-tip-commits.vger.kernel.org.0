Return-Path: <linux-tip-commits+bounces-6519-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BA8B4A672
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19EF7BA8CE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29628506B;
	Tue,  9 Sep 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWzhggOo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QCzcYf2V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFC276050;
	Tue,  9 Sep 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408566; cv=none; b=d6Q4dNZp99dBWPl0kTiTs8roED1aluHhx7gEYcVnhsI/vnh2c5tYd2xYeVwLOkK8v+X/YmIN3aIaZRfwh8PK6kImJTFinHaH6uCT3yUaDr1heBGozeGi6N6/08P8/EaVr7g+v23gGeqv/pt0p16iKue7oSFWkZCyQobaIwyP5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408566; c=relaxed/simple;
	bh=8GTvYOMui+wYCNSTdgCBCK/1X2KaB5V1Rb3KFy7NRs0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EDYyPJ+PJDv2Heq793ceKBXTNGbfS42qGw5Pz6JLyzzeQGnj6BwvHbBprLfR0wmqCio608owvhvUM/mxajVp7TpsCo6RlxNK2VeL9GvuWr1+lJOy1jMISymwQcKNYye3ukKwqiAd3taRPUfzD0VtSRH2CsI4FM//j05ShbhBxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWzhggOo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCzcYf2V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prll3dfJvDuM4aZZn51/P6sNN4UNGqiXVNfd41hyosc=;
	b=jWzhggOoMtlIJiEPOPMmKSAHyTXytP7LXtCStaqGWwoo+Jy7evdqnf/eufHEH93IiPwFXq
	ldR6KJ9Uvbx+5VvireOSTq7jfmtmQvAYxpTbj2CcLKmxC6SW9Qp3+leuGifdnYMg2aqRrj
	bLFQv89j4quS9skDtgr5umN1+RcVOsZyn5yIKHBINB3DtTl4ckWCgEYxeowgLtjRa66IiL
	P2OTWiNtXvgUDF8hdyehqoXeA0ZKjdx8RTpuiizctW+fi+f508Ks/m4uILot5jD43iorgC
	BCcGwJjKkovf48rKp+la7eJb5nzdl8arli2iibF0nhI7lvAc7wgETuM6uJXz8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prll3dfJvDuM4aZZn51/P6sNN4UNGqiXVNfd41hyosc=;
	b=QCzcYf2VJiGwtC8ocbZLCWSGRRnx2Qz0fSDIbvdRhVj7V4THsv6c/Oe6uXtuRK/leSbCZd
	KqupR4LzLbFZogBg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: Fix -Wunitialized in powerpc
 VDSO_CALL() wrapper
Cc: kernel test robot <lkp@intel.com>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-1-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-1-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740856148.1920.8183913180811982509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9f15e0f9ef514b8e1a80707931f6d07362e8ebc4
Gitweb:        https://git.kernel.org/tip/9f15e0f9ef514b8e1a80707931f6d07362e=
8ebc4
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:38 +02:00

selftests: vDSO: Fix -Wunitialized in powerpc VDSO_CALL() wrapper

The _rval register variable is meant to be an output operand of the asm
statement but is instead used as input operand.
clang 20.1 notices this and triggers -Wuninitialized warnings:

tools/testing/selftests/timers/auxclock.c:154:10: error: variable '_rval' is =
uninitialized when used here [-Werror,-Wuninitialized]
  154 |                 return VDSO_CALL(self->vdso_clock_gettime64, 2, clock=
id, ts);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
tools/testing/selftests/timers/../vDSO/vdso_call.h:59:10: note: expanded from=
 macro 'VDSO_CALL'
   59 |                 : "r" (_rval)                                        =
   \
      |                        ^~~~~
tools/testing/selftests/timers/auxclock.c:154:10: note: variable '_rval' is d=
eclared here
tools/testing/selftests/timers/../vDSO/vdso_call.h:47:2: note: expanded from =
macro 'VDSO_CALL'
   47 |         register long _rval asm ("r3");                              =
   \
      |         ^

It seems the list of input and output operands have been switched around.
However as the argument registers are not always initialized they can not
be marked as pure inputs as that would trigger -Wuninitialized warnings.
Adding _rval as another input and output operand does also not work as it
would collide with the existing _r3 variable.

Instead reuse _r3 for both the argument and the return value.

Fixes: 6eda706a535c ("selftests: vDSO: fix the way vDSO functions are called =
for powerpc")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-1-90f499dd35f8=
@linutronix.de
Closes: https://lore.kernel.org/oe-kbuild-all/202506180223.BOOk5jDK-lkp@intel=
.com/

---
 tools/testing/selftests/vDSO/vdso_call.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftes=
ts/vDSO/vdso_call.h
index bb237d7..e720558 100644
--- a/tools/testing/selftests/vDSO/vdso_call.h
+++ b/tools/testing/selftests/vDSO/vdso_call.h
@@ -44,7 +44,6 @@
 	register long _r6 asm ("r6");					\
 	register long _r7 asm ("r7");					\
 	register long _r8 asm ("r8");					\
-	register long _rval asm ("r3");					\
 									\
 	LOADARGS_##nr(fn, args);					\
 									\
@@ -54,13 +53,13 @@
 		"	bns+	1f\n"					\
 		"	neg	3, 3\n"					\
 		"1:"							\
-		: "+r" (_r0), "=3Dr" (_r3), "+r" (_r4), "+r" (_r5),	\
+		: "+r" (_r0), "+r" (_r3), "+r" (_r4), "+r" (_r5),	\
 		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
-		: "r" (_rval)						\
+		:							\
 		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
 		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
 	);								\
-	_rval;								\
+	_r3;								\
 })
=20
 #else

