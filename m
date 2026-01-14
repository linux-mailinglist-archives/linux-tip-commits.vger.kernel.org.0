Return-Path: <linux-tip-commits+bounces-7995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B132D1E27A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3221F3024F73
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F2D395277;
	Wed, 14 Jan 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VeBUmZUE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSmk0adm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1939524B;
	Wed, 14 Jan 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387221; cv=none; b=UkNYtgKI7+h6f3X+GRwnxFGZIUKy70A2FjUbseEPnMgQ1pOxMLrhMJyovYjwaT74kmAy7mp9Pa+XHTx5lF9v1bLvkuawpcPovwq4jI1tDCaBLhNkDpJcaLIbzPCrtdRRyC40B1FCL14GW9zyyjOcvEjU6m9ijS2jjUBg2Wtn3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387221; c=relaxed/simple;
	bh=JyKjIzDghDaO9V1/06vY2aR/dVNHs4AuS4GXdLhPam0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GpTA512m7vEpjtxx5afGi8eV3oDKfMQV3awa2VhEHOqKWiM7la3+UKStAKe1HJjnHM+kD39M6WvXcsts7hIRRNLtkwqUZlvXOy56K6Xe9NUiaTEa2WyRJOUo/p3Ay4aX/4kgz58X9kNHcl/3kW0Lyy2GM1NmCNam9G6xcnrDEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VeBUmZUE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSmk0adm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AK4+WJy4A8nUxSGvPqBJ4Ayddz5XIAxKEY5tqeNqW3A=;
	b=VeBUmZUEvzIl1f108agswrPHqkCkZWDYWQ1HXYptYzX4AQS1a+FnZb+N01Z2ZkUW+71BYj
	ujowlgdbBfDTI0ythk942FFSZUMRWONGn2KGQvO2wMkzGPJt6FXWlWZWL1mZ9Cw1tiXXn2
	6+u/xaIAaeYteod82nrsuQO2Ni9UoZkKtWHB8mAfTN+xGaqaxpAWv5KTD2Z6tp356hkO2/
	7i/OXtezNfqbWobrPZ6jfbuXR5gV15G4vqn6FDA+f2zhrIp/W2/gcb3Cs0Vrs8hj+WSlw4
	4ATyxdijKQWF5Y1+S+SbPVSgrDA/HqaLQdjSr6ODRQBRQPQr+hFroNsUz18Qog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AK4+WJy4A8nUxSGvPqBJ4Ayddz5XIAxKEY5tqeNqW3A=;
	b=iSmk0admrP4NfKGymEoYBuKkSt25XNt6Xjfu9SDVW34AR2VxweSeJBNWtGDFc1OOUzfePo
	Legnm9JnenRcpsBg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] arm/paravirt: Use common code for paravirt_steal_clock()
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-8-jgross@suse.com>
References: <20260105110520.21356-8-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721568.510.3064956888315385878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     15518e633b7c1780d866365a9ee660af5c2ce9a1
Gitweb:        https://git.kernel.org/tip/15518e633b7c1780d866365a9ee660af5c2=
ce9a1
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:06 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 15:57:23 +01:00

arm/paravirt: Use common code for paravirt_steal_clock()

Remove the arch-specific variant of paravirt_steal_clock() and use
the common one instead.

This allows to remove paravirt.c and paravirt.h from arch/arm.

Until all archs supporting Xen have been switched to the common code
of paravirt_steal_clock(), drivers/xen/time.c needs to include
asm/paravirt.h for those archs, while this is not necessary for arm
any longer.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-8-jgross@suse.com
---
 arch/arm/Kconfig                |  1 +
 arch/arm/include/asm/paravirt.h | 18 ------------------
 arch/arm/kernel/Makefile        |  1 -
 arch/arm/kernel/paravirt.c      | 20 --------------------
 drivers/xen/time.c              |  2 ++
 5 files changed, 3 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/include/asm/paravirt.h
 delete mode 100644 arch/arm/kernel/paravirt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fa83c04..fc9b5b7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1320,6 +1320,7 @@ config UACCESS_WITH_MEMCPY
=20
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
deleted file mode 100644
index 69da4bd..0000000
--- a/arch/arm/include/asm/paravirt.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_ARM_PARAVIRT_H
-#define _ASM_ARM_PARAVIRT_H
-
-#ifdef CONFIG_PARAVIRT
-#include <linux/static_call_types.h>
-
-u64 dummy_steal_clock(int cpu);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-#endif
-
-#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index afc9de7..b36cf0c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -83,7 +83,6 @@ AFLAGS_iwmmxt.o			:=3D -Wa,-mcpu=3Diwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  +=3D topology.o
 obj-$(CONFIG_VDSO)		+=3D vdso.o
 obj-$(CONFIG_EFI)		+=3D efi.o
-obj-$(CONFIG_PARAVIRT)	+=3D paravirt.o
=20
 obj-y			+=3D head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+=3D debug.o
diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
deleted file mode 100644
index 3895a55..0000000
--- a/arch/arm/kernel/paravirt.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- * Copyright (C) 2013 Citrix Systems
- *
- * Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
- */
-
-#include <linux/export.h>
-#include <linux/jump_label.h>
-#include <linux/types.h>
-#include <linux/static_call.h>
-#include <asm/paravirt.h>
-
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index d360ded..53b12f5 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -10,7 +10,9 @@
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
=20
+#ifndef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
 #include <asm/paravirt.h>
+#endif
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
=20

