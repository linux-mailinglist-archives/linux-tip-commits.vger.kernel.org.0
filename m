Return-Path: <linux-tip-commits+bounces-6685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4029B8C3D3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3175852B8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8312609D0;
	Sat, 20 Sep 2025 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHyPjceE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WSoEDAvn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1B34BA47;
	Sat, 20 Sep 2025 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356765; cv=none; b=L06o7De02wwMo7d7thkO/49ge3Bth1bEY6K8j+R8ifIESh6V2UTk2W2fdcH9Jqx5fsLZdkZcQOQ+Y/ZI7BRBRdAQkeRet5PC13Skxt4/xvw4HzVtaKyOtKhmx/f0wBcAOLCXr9HOELlbDnB97n/Uusw0okVGdRfmknCPc8ZDGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356765; c=relaxed/simple;
	bh=CA/keu0B6Xs4Dho9ljaDd/ZbXzcfZpa2vQkdHA8KhGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ORcuvMuh9MBHw+3lCduur9IJNSMRxXcaWut5OKDAI8JoJRTr5VfnL7eNYEvGs+Ylv3tx34biaPxU+6NbT8MGma00NbttcD+pcRXtHZp200pc/LylshmkIa/K1j9vHMWetFDxiqCbvf9hK0LhfW5nygYsvgu9a5KeWND4E9MnTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHyPjceE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WSoEDAvn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 08:25:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758356761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGBhNC9g/TDVJ8uY/eGCfLze9Xe+8wZb0RTR8i0mdnA=;
	b=vHyPjceE7QlZScEXw+lmvFIB2lLV+T5sQrCr3LJzBjJkV3mf6qPSweIl0fzu6uWUrRAN5p
	MCUZTrgzfMQ47333RbFi/cOhMxz6jZWjBNRiu+QhGN59gtmoXywT2xx7xTOLX2BBo+jFGj
	fgVSK9fDZFgbw7icbrtCOcl/AxkFgQhfxd4Nu2iR0s9i6jUr/1/Vo+IUNI7sprkrwOIVZO
	RiiAACpfOxoH53p9gchlnzul9dFFjrRmNaR1/liLoIpUP+BzZT3Co7IoKURa+Qp+nBlDZe
	NXMOFbNtO2vUIjHuj2fr1Kv5yCQfGo01/BKDhV/3E6Q1nxY9drGCNy/9KmvmkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758356761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGBhNC9g/TDVJ8uY/eGCfLze9Xe+8wZb0RTR8i0mdnA=;
	b=WSoEDAvni/8yoHErkXvAoNlQ9StNBlJ84yI8tQU764KhqSR6FguxMdf/ADMOCdRgpjX47J
	kGfbiw7+m4/wTxAg==
From: "tip-bot2 for Yao Zi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] LoongArch: Fix bitflag conflict for TIF_FIXADE
Cc: Yao Zi <ziyao@disroot.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wentao Guan <guanwentao@uniontech.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250919125829.37951-1-ziyao@disroot.org>
References: <20250919125829.37951-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175835675734.709179.3475361898232363471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     3ec09344b01a15901ba824e877a0562ed8103e27
Gitweb:        https://git.kernel.org/tip/3ec09344b01a15901ba824e877a0562ed81=
03e27
Author:        Yao Zi <ziyao@disroot.org>
AuthorDate:    Fri, 19 Sep 2025 12:58:29=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 09:55:56 +02:00

LoongArch: Fix bitflag conflict for TIF_FIXADE

After LoongArch was converted to use the generic TIF bits in commit
f9629891d407 ("loongarch: Use generic TIF bits"), its TIF_FIXADE flag
takes the same bit with TIF_RESTORE_SIGMASK in thread_info.flags.

Such conflict causes TIF_FIXADE being considered cleared when
TIF_RESTORE_SIGMASK is cleared during deliver of a signal. And since
TIF_FIXADE determines whether unaligned access emulation works for a
task, userspace making use of unaligned access will receive unexpected
SIGBUS (and likely terminate) after receiving its first signal.

This conflict looks like a simple typo, switch it to the free bit 19.

Fixes: f9629891d407 ("loongarch: Use generic TIF bits")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/includ=
e/asm/thread_info.h
index def7cb1..4d7117f 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -77,7 +77,7 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define TIF_NOHZ		16	/* in adaptive nohz mode */
 #define TIF_USEDFPU		17	/* FPU was used by this task this quantum (SMP) */
 #define TIF_USEDSIMD		18	/* SIMD has been used this quantum */
-#define TIF_FIXADE		10	/* Fix address errors in software */
+#define TIF_FIXADE		19	/* Fix address errors in software */
 #define TIF_LOGADE		20	/* Log address errors to syslog */
 #define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
 #define TIF_32BIT_ADDR		22	/* 32-bit address space */

