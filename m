Return-Path: <linux-tip-commits+bounces-2213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCBD972074
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D395E1C21C5C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839EE178CE4;
	Mon,  9 Sep 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pL/s+csx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jB6uvl6s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFF168BD;
	Mon,  9 Sep 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902864; cv=none; b=YaFARzd0GWzwCmWohhIoCKHTL6li3loxJLNP9QfxNAalvkS+8zheoo2+D3VtmxahP87Sot/kcSAvn4MMOKKY89GT4fEcrjAI3qGQ58KHpgMnF5TFpPSHTS054zBgGsWNAn8hmhypjPxjoeQpi0MjxcSxXXUaOy01GTC4ywPJv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902864; c=relaxed/simple;
	bh=Mc0Fi6BEhn6lYUuvvkv2CviMPN6dQ5nAbI9Xgfd2hG8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c0i3WKqWF0+vpYEAww6gFMdUcnPZpzZhRbtVsIn2vUNsRnhSNKdJ6bVOpXqUs6wTcuL6/xfgkFtsKlnveUFYsCNrQh3TogP4eIpjYuERscCH+IHxKMw7Yn/heFQaxdq7birbFOmM7A9ynno1C3cc0vCLPRc5kXqkgmjzhtIzmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pL/s+csx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jB6uvl6s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbuXNKMB1EHzpSzJsrf3bt7z679PpcOxytpSgkDFrPc=;
	b=pL/s+csxnC+TaNTxayetMAAhAa5tuwOcoJ4735/0FgD6cItrQHk3em+ciRSDdQl+fi5CGj
	8gTZY9i1kb0L2eLCPlUh4jX1GblUSnB/C3MZq6HbOazF3t1OB+8uXy79ifu/2JUBp5OD1B
	LNQZxLA/QIbYKKUPG/byqU+MUA6WAPHpEVvtxSnAKAcB6jHQ8UIgevvBLCp50bwGJbfChE
	IrKt2GqAr3CVpDfmkHIiMX393L/dVrq1xb5ahROmFwks3Jz100SQ3RiD4NWMOqM54Ud741
	BcCPemtBp0EvUrktuRqENlNgkwSOmyh7aN9O6d/gNcwcFXkjqT89+/8rzEKWJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbuXNKMB1EHzpSzJsrf3bt7z679PpcOxytpSgkDFrPc=;
	b=jB6uvl6sD7V/iBCG8Kcn8ekadCyuLeSo1tBtjervwiMtdBvPdzLulux8hGAhyKXkefR3dE
	ccKv4DVSu7ViPtDQ==
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
Message-ID: <172590286013.2215.4253522884856320667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     41639286fd0b2538de8cfe3e99db18ed0df520cd
Gitweb:        https://git.kernel.org/tip/41639286fd0b2538de8cfe3e99db18ed0df520cd
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 12:59:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Sep 2024 19:24:11 +02:00

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
index 0f3cd7c..b03f6d2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -64,6 +64,7 @@ config RISCV
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST

