Return-Path: <linux-tip-commits+bounces-3787-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47980A4BCBF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988B3170893
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179DC1F63C3;
	Mon,  3 Mar 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BkRPYsL1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JIr1a/AW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E41F4CA7;
	Mon,  3 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998591; cv=none; b=IX/+nGk0c0OU7/weezw4NBvip4XMeCTaIqReSrox0bkLHQnKMrAlpQ1822sWXtguynMf4mNXSYlZ6BLAka0u2SgKASzZrYbSc6som2otxJUpeJfTiN6p+ldHfhXZXM4DapFfCM7MnCnLF0gxuDSifgwwn855c959aY6qJ/K/Pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998591; c=relaxed/simple;
	bh=vGXIi9Y1M5BR/jqHQI5HutoM/ul0nzafntiR+0cO9CU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qcHyjoHMEVMR9QqCFGaLoPnAuahPa0RzypY3Mr1AAVNac9jhedcDuliLWyAwvt2ioi+5qSre0v3z2KPraHcykoxwJPhm6qBZjJSXjCL0YAxBe3Xin5YpM/LrC6hOeNFWowO1jSw89WVA+nxJD+TPMKIJJMdQpBhR/nsKzxtvkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BkRPYsL1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JIr1a/AW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lHnivRtpvfRr9kQErQF72IIxIJQmn9NTvN+hCzDYqdw=;
	b=BkRPYsL1KB0Ofw1Q5l+h+B6Ar5bPI2BuYoRXmKAOAfqZDThTCZPKq26Hu5pKJIBR5tkX9Y
	zCdf7TeoyL5NClQ+4tX3pf2I16tsa++o+ZXR66xw6KzC2hZV4S/mdm/sZIqwksRoSbhbW1
	jD4XcoQ9Hn1hSut8cFpBbnH6jNEn136ObZ1A1dNmksBj6aBlK07aNqsTxUD503sqiclgVt
	EyuuWPq59EewIS9B0DQaI6V6w5IKfD3yDZoTT5FTN+LwkPwC+tjj6qgv88LdMOP301ProD
	a5+TGxzr0UDQvNPzXyNIpzkp5KTpOLPIO6nrcL9Abf8N/EjUavdwZqmr7sS1zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lHnivRtpvfRr9kQErQF72IIxIJQmn9NTvN+hCzDYqdw=;
	b=JIr1a/AW5yphXUU6CIqyY6xahakJ0SnWe+7mxlNqegfoRIAPEHESkOO4h/Of2uqbLQXxHh
	/+hnncS/0xsSL0AQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: Make asm/cache.h compatible with vDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858664.10177.11126704925653903904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4b6708a4a15dc73ac487f65ba0c6bb13dd6e42ff
Gitweb:        https://git.kernel.org/tip/4b6708a4a15dc73ac487f65ba0c6bb13dd6=
e42ff
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:33 +01:00

arm64: Make asm/cache.h compatible with vDSO

asm/cache.h can be used during the vDSO build through vdso/cache.h.
Not all definitions in it are compatible with the vDSO, especially the
compat vDSO.

Hide the more complex definitions from the vDSO build.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm64/include/asm/cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 06a4670..99cd654 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -35,7 +35,7 @@
 #define ARCH_DMA_MINALIGN	(128)
 #define ARCH_KMALLOC_MINALIGN	(8)
=20
-#ifndef __ASSEMBLY__
+#if !defined(__ASSEMBLY__) && !defined(BUILD_VDSO)
=20
 #include <linux/bitops.h>
 #include <linux/kasan-enabled.h>
@@ -118,6 +118,6 @@ static inline u32 __attribute_const__ read_cpuid_effectiv=
e_cachetype(void)
 	return ctr;
 }
=20
-#endif	/* __ASSEMBLY__ */
+#endif /* !defined(__ASSEMBLY__) && !defined(BUILD_VDSO) */
=20
 #endif

