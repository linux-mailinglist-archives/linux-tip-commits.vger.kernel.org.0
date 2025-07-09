Return-Path: <linux-tip-commits+bounces-6044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913CAFE4C0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B429A18924A6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427428B7FF;
	Wed,  9 Jul 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4IMmT/r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQ4d8ETR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D53280330;
	Wed,  9 Jul 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055064; cv=none; b=gLRUkWBcnskzwerqf6jnpIwuNsOP7kHcGCQTUDeqxFLCdepUKwDqgajHiuwYimwI7Wnw5FQeX8YThodAUkS2jGqirKLJaZe6d6yjL82eunilHiYrPKX3KBVn9xCOoX4OeR82MdziLwNSrGyJwGZWgMtFcbk+ckmpZRy5tmCeMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055064; c=relaxed/simple;
	bh=wj04VWGKZJpXkaa24ZBUfyM2hHHKtf3K3GALBCdG2q8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gMeShRCI/yEp36LIolwLh4JljKmfmrROe9sI2/6jq3DHqu5DOp9+EZ42Pa6D6WI0xqAuSmpJ+oEPul9Hy4SNilBxplpA2spXQnatNQbEN+etI6jsgGqlZXwvSSpckhvtDYa1KewAVeD8AaPks+wbKTPgCr9lrGSSfrC+uxTySdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4IMmT/r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQ4d8ETR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90K6qr53UUZ/98UibKXAqz/db5bhvfAqfoYip5alB3A=;
	b=C4IMmT/rylGz80SxntsbUDz0qNIN8nB4TlR6gE7EgKeBj6pIw7Kr3rETFRNMG+yCQfCsaT
	6B8u2a92dsj37380tCoUAxtj9EcSWSu7MQNjVwCJFw7rTWdKBpNbzQyNHKmiSi0bHDyeVD
	xpuFT1+0As1aSd5JU3r6u+Z2MTJcTofTp2Qoa2MOcWXCbA8UDe2mqlP7guAkaExQaqsbOE
	WDh90QlESpMsDPAJ94tLOL635jQXh1zo4pJf9HilnX7Nl3JcSUtn92XuOwZqDxUsNzruSc
	gfntb7HiG+5tIO1hawSIS+4AMab00m3goj/+cDskC5tXF+a+FVGS1/QCdRqTxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90K6qr53UUZ/98UibKXAqz/db5bhvfAqfoYip5alB3A=;
	b=tQ4d8ETRsncPkXXnQCpi7SSuBm93Zk0T22rBtgO2tMi1r+ejXF4/OY1t7Ieqac7WxuYxL/
	yEdg5/NqWNk1yvCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/vsyscall: Split up __arch_update_vsyscall()
 into __arch_update_vdso_clock()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-3-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-3-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175205505997.406.6910151317712177281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     76164ca0d113e6a9f3033f948c739586fc606ed1
Gitweb:        https://git.kernel.org/tip/76164ca0d113e6a9f3033f948c739586fc6=
06ed1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:34 +02:00

vdso/vsyscall: Split up __arch_update_vsyscall() into __arch_update_vdso_cloc=
k()

The upcoming auxiliary clocks need this hook, too.
To separate the architecture hooks from the timekeeper internals, refactor
the hook to only operate on a single vDSO clock.

While at it, use a more robust #define for the hook override.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-3-df7d9f87b9b8@li=
nutronix.de

---
 arch/arm64/include/asm/vdso/vsyscall.h | 7 +++----
 include/asm-generic/vdso/vsyscall.h    | 6 +++---
 kernel/time/vsyscall.c                 | 3 ++-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index de58951..417aae5 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -13,12 +13,11 @@
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
-void __arm64_update_vsyscall(struct vdso_time_data *vdata)
+void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
-	vdata->clock_data[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
-	vdata->clock_data[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
+	vc->mask	=3D VDSO_PRECISION_MASK;
 }
-#define __arch_update_vsyscall __arm64_update_vsyscall
+#define __arch_update_vdso_clock __arch_update_vdso_clock
=20
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index b550afa..7fc0b56 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -22,11 +22,11 @@ static __always_inline const struct vdso_rng_data *__arch=
_get_vdso_u_rng_data(vo
=20
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
-#ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_time_data *vd=
ata)
+#ifndef __arch_update_vdso_clock
+static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
 }
-#endif /* __arch_update_vsyscall */
+#endif /* __arch_update_vdso_clock */
=20
 #ifndef __arch_sync_vdso_time_data
 static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data=
 *vdata)
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index d655df2..df6bada 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -118,7 +118,8 @@ void update_vsyscall(struct timekeeper *tk)
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE)
 		update_vdso_time_data(vdata, tk);
=20
-	__arch_update_vsyscall(vdata);
+	__arch_update_vdso_clock(&vc[CS_HRES_COARSE]);
+	__arch_update_vdso_clock(&vc[CS_RAW]);
=20
 	vdso_write_end(vdata);
=20

