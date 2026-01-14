Return-Path: <linux-tip-commits+bounces-7992-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA2D1E331
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 154C330C40D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11A39525D;
	Wed, 14 Jan 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VxLT5E03";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ctL9M1Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3876394479;
	Wed, 14 Jan 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387219; cv=none; b=LconZnL0niadSHTPryMDyldwCWVlg5XNMQlPWNUlEPGjKZEAYsfTB67JV8RrgNzP1H1+AeEdPQ8yvAMyvmS9GipgtdPV0+E9NNbtK+6IvyKOJoeOfHBnw7vUhV4dRcPExiFg1nr1AP0aWn5X9bhyBjvCp4/7Zq7Z5c9+1KBTybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387219; c=relaxed/simple;
	bh=uq7c/yOPZgjtYAGVdfUgGTiQKZPFnsQ4yolD0HxPI+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IQQ+v2TiDTrS53QXM7VikAM1rwjRuFd1hD0+AD2y+xOT6b+Lvt4z2Yv6dEW0MsLGeSlpN1dpAAOGsqcTUh4xgvRFNryx2dZfFb+jXu0FqbiNqCGud9iZDSvGabPbNayXi6/YQjnxwAwtoOPcWgQ5diQ1NTdwkGXII9xMCaC870g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VxLT5E03; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ctL9M1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igPgN8yrsRa0xkOnyp6ZPitFyo3b5bxLaR28ZrqBufg=;
	b=VxLT5E03aPt2aQoc5BrHRV8zyZ2mDyW8Lu7Oi31NzjX6T7ayaC88K4Gj1h8xw6qtG9ByJb
	e8l5a+bxIvrLhfBR4jZ9nrmx944p/BP/j+wrwBvhTNE7JyfbmUDK2dG8udAxkkSDyoLUfz
	sVYfmiJkQWofGlepxRZ2545nqRH5UngI/AuayW3tg83jVPhvxIp/ZcXKxD51DjaTBJ7neC
	Qz2azoFaOGNuMwEzALYWRnWyPZoasg1CStwOFjnZc9SWjc/qY2mzQN+YVskYE0xzIKOVJf
	ovmMv3K1zOnusJx+ET06CnICsfNZgfy6vSLpEKLrPwf9nLO/0qMquQlCqAJ4YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igPgN8yrsRa0xkOnyp6ZPitFyo3b5bxLaR28ZrqBufg=;
	b=8ctL9M1QtnbZ28CNha3tFw7d6p0KSxrq7eh0nxPKthzK4GQyqoHvGm77TSo7kqb+tvFxE5
	hxwgcrlG07rASeAg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] loongarch/paravirt: Use common code for
 paravirt_steal_clock()
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Bibo Mao <maobibo@loongson.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-10-jgross@suse.com>
References: <20260105110520.21356-10-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721364.510.1260892452221851446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     b8431b901e825222281bbd156ea8ee8dd60b58de
Gitweb:        https://git.kernel.org/tip/b8431b901e825222281bbd156ea8ee8dd60=
b58de
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:08 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 16:47:20 +01:00

loongarch/paravirt: Use common code for paravirt_steal_clock()

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-10-jgross@suse.com
---
 arch/loongarch/Kconfig                |  1 +
 arch/loongarch/include/asm/paravirt.h | 10 ----------
 arch/loongarch/kernel/paravirt.c      |  7 -------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 730f342..19f0808 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -687,6 +687,7 @@ source "kernel/livepatch/Kconfig"
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on AS_HAS_LVZ_EXTENSION
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/a=
sm/paravirt.h
index d219ea0..0111f0a 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -4,16 +4,6 @@
=20
 #ifdef CONFIG_PARAVIRT
=20
-#include <linux/static_call_types.h>
-
-u64 dummy_steal_clock(int cpu);
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-
 int __init pv_ipi_init(void);
 int __init pv_time_init(void);
 int __init pv_spinlock_init(void);
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravir=
t.c
index 8caaa94..c5e5260 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -13,13 +13,6 @@ static int has_steal_clock;
 static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
 DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
=20
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
-
 static bool steal_acc =3D true;
=20
 static int __init parse_no_stealacc(char *arg)

