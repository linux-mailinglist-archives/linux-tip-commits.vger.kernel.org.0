Return-Path: <linux-tip-commits+bounces-2746-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E909B9FBF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C911C2155B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0F1B21AD;
	Sat,  2 Nov 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kEaqQ5Kt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWZM3HCI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8C1B0F20;
	Sat,  2 Nov 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548232; cv=none; b=T+t8u2vm0ecWWOHToR7FCWotEMuKSkpitoJkSLVX6wcZxXpdCstFe5TNXltS/D5zKA1TDZy9Odb3sowxgFDwqelSmnkeQHCrYXIyRZOCdasKCiV32y2N/FH+8VBQfrK4MeTU8o1ZvoJ1WVY893KP4Tj2Cm23k2smzcN27PnE0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548232; c=relaxed/simple;
	bh=J79xrQIc+gdsGAkrYta1A5nsl4Iq7Y+6fqRm7AShNmA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OCIxDfWpCtAbiskm8wszGzOjKYF1qhkwagkymqq7VmdITPWbbAi21uxHJ9SNDtgAW9GWiRC/ez8NVpVjmBTBf75FL+O6SqqDuUYUi7EX/rusQ4UVGSbphouDSxoBcgr0rVorz8LWf0PQQltfY7p9ESFh2JdIoqTNIo/n6REc46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kEaqQ5Kt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWZM3HCI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+CvH9ZK0H2nFM5/fMjQte6IDelIIgL0FRK1+vrwoWU=;
	b=kEaqQ5KteoGrGsAPjnfcFzmWSqqxkhD6WlavDeqNQjcfKFe7JVd42rdHb6v4UHVQDsFsEM
	Ip5dPfzqDSn8B9x//vuyFgRmS27zGUqahcJLO90ukzNeZkIgDNLYfHH1fJRsG/EuknWhkM
	7/vIyGsPQveCKoNEMQBR6plgNVx+aeD/ZD6PZB7HqxMrz6tzmy8qZrrghiW783ggHaEU6o
	Qfw5boxBv2c8MwLFXXaS8xsSzEAGLssKhV3oArvyXhysqZzyn6xoWR8ba+5MHij2+4gMSW
	7L4lfZVrckNoz+ZUJXuLdg3qoyb7970SHU0P8vTow/SQhX/Z+OSNlP6TcijKgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+CvH9ZK0H2nFM5/fMjQte6IDelIIgL0FRK1+vrwoWU=;
	b=kWZM3HCICVieemQgZhmS4+ZU0fGT65rnWslEqbZ/vGbON+qs+OJwf6+bZN7BLmr2+DDMga
	6pUTlvS1J3OwH+Bw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vdso: Drop LBASE_VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-4-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-4-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822892.3137.11201983307893467027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     0973fed6a5e58dd2515a83dd7f83ad674e91cc4f
Gitweb:        https://git.kernel.org/tip/0973fed6a5e58dd2515a83dd7f83ad674e9=
1cc4f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:33 +01:00

arm64: vdso: Drop LBASE_VDSO

This constant is always "0", providing no value and making the logic
harder to understand.
Also prepare for a consolidation of the vdso linkerscript logic by
aligning it with other architectures.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-4-b64f0842d51=
2@linutronix.de

---
 arch/arm64/include/asm/vdso.h       |  9 +--------
 arch/arm64/kernel/vdso/vdso.lds.S   |  2 +-
 arch/arm64/kernel/vdso32/vdso.lds.S |  2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 4305995..3e3c3fd 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -5,13 +5,6 @@
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
=20
-/*
- * Default link address for the vDSO.
- * Since we randomise the VDSO mapping, there's little point in trying
- * to prelink this.
- */
-#define VDSO_LBASE	0x0
-
 #define __VVAR_PAGES    2
=20
 #ifndef __ASSEMBLY__
@@ -20,7 +13,7 @@
=20
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
-	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
+	(void *)(vdso_offset_##name + (unsigned long)(base)); \
 })
=20
 extern char vdso_start[], vdso_end[];
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.=
lds.S
index f204a9d..4ec32e8 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -25,7 +25,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/v=
dso.lds.S
index 8d95d7d..732702a 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -22,7 +22,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE_HIDDEN(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }

