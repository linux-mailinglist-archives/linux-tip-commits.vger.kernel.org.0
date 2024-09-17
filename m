Return-Path: <linux-tip-commits+bounces-2304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44597ADAA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Sep 2024 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9AF1C2098E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Sep 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402F14BFBF;
	Tue, 17 Sep 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VibbIKrT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P+0Vo387"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AB45008;
	Tue, 17 Sep 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564547; cv=none; b=elJUMvDmdrzo0NyGglwrCNmzBLQk/U/M9Cl3GMbSWrPKYzPmfCUdbhfcnc5pvL4Yn1GYhbieKkXXaUj0XiPLC/dZXo+nx/JSp9xRScs5fOxdEM0vaUFhYftb9zXqsGQ/k9hkwKVSvv0mxGQY2zLW4mOiA74qaTStk9vAvlvCaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564547; c=relaxed/simple;
	bh=HwkqHougsnLDQQ52PPQk6pf7EDKTB8be0iTc4vTHM9s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YedzkniCF+vr/KGLx99Bn+t/x97a+BIZmfclIBySn43R5x8rm8d9jBkxbmBmtY/o3ZgybiFPCxck8lPeuMWPnaoUB27nyAVXrRvcyoULb0RX/+RFPh080h5ivOBseDNyCYB7mQjSx3zHA2VRkAUIS7ItJb8BSwr88nybkL8E1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VibbIKrT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P+0Vo387; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 09:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726564544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0W3YvSdDlPVxXi4jTNDI9AFSvBrwKmg68ln0KhgsjI=;
	b=VibbIKrTg686zzxnb/snIoMRFujkc37XoTAUO89+yLT/ak36638AD5oiTAihryBC68nmBE
	CuEwdcCqf6FmdR5QyNkqKzXN9eTna1O/SOxiMnSyszmOI3KOuawtuKRT2TjrkKnlEsyvdW
	QOaUuq0pZ3FO0dRom0Ixkwl6GtXE4oHwA1Wgpp8OEoBJCk51CgDCqOHudjqqdg20xG3gD4
	iLeJfR+/mYH9ey1dCvkGjcNCsVX6p+31Ya7mIALr+hVicQlI9rDJ6Tvj+FMkIz0eqStVCu
	1YL+fnsltBObiR6e6dR8ZQXBFlsKcV3PGgF0kN2NgMvQ487QxGlbQPOr3q+Xrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726564544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0W3YvSdDlPVxXi4jTNDI9AFSvBrwKmg68ln0KhgsjI=;
	b=P+0Vo387sGWO0cIM5irdE+m/5tkEsRY0sCGZnBEYFeyDamR52BRBWW6MmWkz6QIFz8bDqR
	mZJ++SnmQFtxDEBw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] riscv: Allow to enable PREEMPT_RT.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240906111841.562402-4-bigeasy@linutronix.de>
References: <20240906111841.562402-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172656454280.2215.11568774932481128926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     2638e4e6b18233d7ec54edb953f253ae9515bac2
Gitweb:        https://git.kernel.org/tip/2638e4e6b18233d7ec54edb953f253ae9515bac2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 12:59:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Sep 2024 11:06:08 +02:00

riscv: Allow to enable PREEMPT_RT.

It is really time.

riscv has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on riscv.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de> # Visionfive 2
Link: https://lore.kernel.org/all/20240906111841.562402-4-bigeasy@linutronix.de

---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 86d1f1c..82724bc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,6 +65,7 @@ config RISCV
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST

