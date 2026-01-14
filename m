Return-Path: <linux-tip-commits+bounces-7993-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A1D1E271
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB20A3018809
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60E395267;
	Wed, 14 Jan 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5CdcnQX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E28Kqq0t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9139446A;
	Wed, 14 Jan 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387220; cv=none; b=InncVu2B+5AxG6x7iGKt2P5H6oXwSDJT2ze66ZGdNJI3y5G8RNNsMSxXTs9bHme1BgR99mPmds/Gicy+gQnHAz8XlofA62eK7obi6hRYfuo5lPHwxqcmObyIfr8iRnnkRYsDcmy2yxeBkKBMnClXrXvcRMmBInbfgJ94jLADDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387220; c=relaxed/simple;
	bh=y1tPhA+KZgxc4vsCATD7lypUgh1yRxyhHNbOSZfSS4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SygvAlIUCql6FgzAXOrZsvBcid9ojpFUs5a9Q6oFqGU5Zy+yFewQx0pAltdV5oNzyc3cORHhl6w82GU/JqxlIcGrcwUMNB0/Tm6jePekmvlaO9XSo60dVap3nJDaT1cgs579DJnQ10ZCTCXf3ZdvuoezaUbYfDwkKYRavV7ai2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5CdcnQX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E28Kqq0t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtQKwL24mm/BKZg9Ln3TgFXbc/P9eO4KPauF3TIl/vI=;
	b=f5CdcnQXRb2u4jwYvd1qNXTnTJs/s1PsiXHWDOXAe8YhUcmEtDrHXqSDp35JPdF08xTI30
	DGe5lRWPNuaMYoLURvr2+qCwyvY5z3YP4+1HJvzEDiZ9auneZhEhkEwgDmDL0kLEfdGdr6
	7qOeIcXqua+UUmChpXWNnW8iE9W3L9Y+kMviT63jBU7FCJIycmTnu/CDK3nFHZWdDv9BKU
	INBudoZuGT52ayXmhIGepvO5hb8pI30+SOimiHtAOHrTflsZpRblk4VzWmBpJ60WHswK10
	nCwj8eZrgV9bnzZ5wtz9HV1oUGv8yir6VefanuHkcnYwMyemW6KhvECA2qX3tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtQKwL24mm/BKZg9Ln3TgFXbc/P9eO4KPauF3TIl/vI=;
	b=E28Kqq0t6GCAizQle6lrqMeKpIqIn0mFSrOulffkgCjwRcRMTsgOXijprzpuGgRRnT68bT
	PxLtNJ0jMWrdHjAQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] riscv/paravirt: Use common code for
 paravirt_steal_clock()
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Jones <ajones@ventanamicro.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-11-jgross@suse.com>
References: <20260105110520.21356-11-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721264.510.14462035318531303780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     ee9ffcf99f0758b612d48ee3ff03340da4d173f3
Gitweb:        https://git.kernel.org/tip/ee9ffcf99f0758b612d48ee3ff03340da4d=
173f3
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:09 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 16:47:33 +01:00

riscv/paravirt: Use common code for paravirt_steal_clock()

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-11-jgross@suse.com
---
 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/paravirt.h | 10 ----------
 arch/riscv/kernel/paravirt.c      |  7 -------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b39f37..80a4cd5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1111,6 +1111,7 @@ config COMPAT
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on RISCV_SBI
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/riscv/include/asm/paravirt.h b/arch/riscv/include/asm/parav=
irt.h
index 17e5e39..c49c55b 100644
--- a/arch/riscv/include/asm/paravirt.h
+++ b/arch/riscv/include/asm/paravirt.h
@@ -3,16 +3,6 @@
 #define _ASM_RISCV_PARAVIRT_H
=20
 #ifdef CONFIG_PARAVIRT
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
=20
 int __init pv_time_init(void);
=20
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index d3c334f..5f56be7 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -23,13 +23,6 @@
 #include <asm/paravirt.h>
 #include <asm/sbi.h>
=20
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
-
 static bool steal_acc =3D true;
 static int __init parse_no_stealacc(char *arg)
 {

