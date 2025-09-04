Return-Path: <linux-tip-commits+bounces-6443-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E17B4372F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6021C2766B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CE52F83CC;
	Thu,  4 Sep 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M70ZHk53";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAjMciLR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4E2EFD99;
	Thu,  4 Sep 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978339; cv=none; b=HofCthMV8wt0YupRGojCjbzNCWSW+KTdcIQgth4sX+xzGeK+PzIGVg0CvuuhSBxWyqUjjtxenU2fHp3fkMeOAR9byub249hnf+78w7oLcfdEr2Biu+TDhJswCvi3uibHSqJdqEnuadYaFoe4CyidG2cJaLuhNx9USQzRo4pW2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978339; c=relaxed/simple;
	bh=2e6Eoky7fM7U7xCCD87TVWOdgmENNqUZo2C2Wzb571g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AKx38qLy01/7PkpimNyupgwea1gblxYRoYfu++OHnqmdEtQ3P20qdLV5AUNol/HqIHQQMItoejVp20RVc44YKwREv/8aIVmlcVlVQmkVPZIOg9NbK0+shx1gwjXam7tCxSh8AOucrH+XEGlpsc4bEcEgqqCPcjHdkKiTqwAzk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M70ZHk53; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAjMciLR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978336;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+ea/36jeVAkfTXk8+6smTLI14f40a7Dvk0NeKTYTJM=;
	b=M70ZHk53YsINC9wOOJZQMxKAaCpZtymzc89lvnExnR5MY21/tgurrnC688GJOxcWUHqn9X
	I1vUCWjfWvBKiiJCO+eZIIrDFAHUt7u1hNX3mg4hXXnNJxU09gcjkoD55LrCgwdfMXGA9k
	0fdFt3W92EmX0x9LShpvBOpkmUmfkf/leBA3uCZn8q1aRJFt2JZlU1384v1JbYz0fF+GRG
	M0sz9BmPPp/DNCTrj8GiK++b9LJVNI9fMnInnz3K2mnRs4oBdhqhlkld7sFvkV7VNzw6ji
	/qQvMM+K2ZwaTj8V4qO7m6sJEg2tPRwFdj5VfgyMaJwPr2R5Ex7nmk05H0BvhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978336;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+ea/36jeVAkfTXk8+6smTLI14f40a7Dvk0NeKTYTJM=;
	b=uAjMciLRgjZ4q7qGLHTRX5dxL5SxKAwPwp0hUu+rkoEJ/3V46+27WytrbqNxiIPsSkUM7+
	DVwSF5Bui4uZZFAw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Drop Kconfig GENERIC_VDSO_TIME_NS
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-10-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-10-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697833458.1920.7264544067265920731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bad53ae2dc4296acb8cbcee385e0238cea484100
Gitweb:        https://git.kernel.org/tip/bad53ae2dc4296acb8cbcee385e0238cea4=
84100
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:50 +02:00

vdso: Drop Kconfig GENERIC_VDSO_TIME_NS

All architectures implementing time-related functionality in the vDSO are
using the generic vDSO library which handles time namespaces properly.

Remove the now unnecessary Kconfig symbol.

Enables the use of time namespaces on architectures, which use the
generic vDSO but did not enable GENERIC_VDSO_TIME_NS, namely MIPS and arm.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-10-d9b65750e49f@l=
inutronix.de


---
 arch/arm64/Kconfig                   | 1 -
 arch/loongarch/Kconfig               | 1 -
 arch/powerpc/Kconfig                 | 1 -
 arch/riscv/Kconfig                   | 1 -
 arch/s390/Kconfig                    | 1 -
 arch/x86/Kconfig                     | 1 -
 init/Kconfig                         | 2 +-
 lib/vdso/Kconfig                     | 6 ------
 tools/testing/selftests/pidfd/config | 1 -
 9 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b0f007b..e19b006 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,7 +162,6 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
 	select HAVE_MOVE_PMD
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d15b201..754626b 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,7 +108,6 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 78c82af..d715e3d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -207,7 +207,6 @@ config PPC
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f6cf918..6e5efbe 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -121,7 +121,6 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_TIME_NS if GENERIC_GETTIMEOFDAY
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 696d224..e06ebbd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -167,7 +167,6 @@ config S390
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1e74b2a..d196181 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -181,7 +181,6 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
diff --git a/init/Kconfig b/init/Kconfig
index d811cad..497bd32 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1347,7 +1347,7 @@ config UTS_NS
=20
 config TIME_NS
 	bool "TIME namespace"
-	depends on GENERIC_VDSO_TIME_NS
+	depends on GENERIC_GETTIMEOFDAY
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 48ffb0f..3d2c2b9 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -12,12 +12,6 @@ config GENERIC_GETTIMEOFDAY
 	  Each architecture that enables this feature has to
 	  provide the fallback implementation.
=20
-config GENERIC_VDSO_TIME_NS
-	bool
-	help
-	  Selected by architectures which support time namespaces in the
-	  VDSO
-
 config GENERIC_VDSO_OVERFLOW_PROTECT
 	bool
 	help
diff --git a/tools/testing/selftests/pidfd/config b/tools/testing/selftests/p=
idfd/config
index 6133524..cf7cc0c 100644
--- a/tools/testing/selftests/pidfd/config
+++ b/tools/testing/selftests/pidfd/config
@@ -4,6 +4,5 @@ CONFIG_USER_NS=3Dy
 CONFIG_PID_NS=3Dy
 CONFIG_NET_NS=3Dy
 CONFIG_TIME_NS=3Dy
-CONFIG_GENERIC_VDSO_TIME_NS=3Dy
 CONFIG_CGROUPS=3Dy
 CONFIG_CHECKPOINT_RESTORE=3Dy

