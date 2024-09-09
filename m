Return-Path: <linux-tip-commits+bounces-2214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B44972075
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF681C23795
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C18178CF6;
	Mon,  9 Sep 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHUPf8DW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1lyhCiQQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35E16D4EF;
	Mon,  9 Sep 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902864; cv=none; b=lAsZKTO62FJLq1/8vLE4lulPrc57X6fX9C5Qa9AMApRKucnpbnf3oM6Hi2Yn/10P7DPYeQWcREQuj+uA664734x/sDgcax26obi3Zy3/nuGkREKksdBSM8Mn/nz2Akz9fP9Tf9onM4ZJBS+wJyMKYcvp2oDiwK0vz8MvL4PulEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902864; c=relaxed/simple;
	bh=e3SlZ48Ug/qyBlwz4BagnX1S1HA0L7fRwXOmN1MnTMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OMIhaePEU5i3+3OMZvsw+K0ugJzsx+UNfMfyOpNKYgXjSiYGvnvDkfx60K4GYi6NXMg28tQlHZ87hkN6ZiJCjTgzPkgQvBhGUqvijwyhh9pzMs4NC4KAjdl4JRkM/2qTAWB6M3g0qdpYaPalZTi86Hzxky0Q3fLHMtA30UZB4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHUPf8DW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1lyhCiQQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJPv4heQVyXkrdUR08FGZjgq5S7V/gSBJone79Y5OO0=;
	b=bHUPf8DWZvq9bzOw+AGpdaeGpsWSeTMihOuXxj67vjswxo2+5yDU5ilXyHcfXq3AFQJF2s
	vVlZyLbvByl7YQp7J+uEV0Bay0kdsoUK1zFZHS5iLKIOHq6yTOPrlhbFJujIgt9B216AO7
	ctKqNBePU9KqIuNjhWdCK0yd2CbTtjARSO7+jrsB2Org0p+7ntpiNESXCKg8n5DFayUYBZ
	80HeIhWnrrCTcRaetv1wIhfVsIT3OH8iOYVhMRi/tmjq3YWZZylI1V6RbvdtutrDOKDcGR
	51l7xsJ1+umtjY0JuRKV+R2x008CcMkqyBV0uv32uwuwprKeg1sXM0E4K2PzLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJPv4heQVyXkrdUR08FGZjgq5S7V/gSBJone79Y5OO0=;
	b=1lyhCiQQMT6TE40g+4ld4+AnqOYi9P1eMgczpCgWS0+aS/qThkHk3WB7yZkCezpsq7cNWp
	QR7c23ghi3agHpDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] arm64: Allow to enable PREEMPT_RT.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240906111841.562402-3-bigeasy@linutronix.de>
References: <20240906111841.562402-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286080.2215.12021157816973502206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     699fd9104967cc3b0826bb0b64a9f1a496121786
Gitweb:        https://git.kernel.org/tip/699fd9104967cc3b0826bb0b64a9f1a496121786
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 12:59:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Sep 2024 19:24:11 +02:00

arm64: Allow to enable PREEMPT_RT.

It is really time.

arm64 has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on arm64.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20240906111841.562402-3-bigeasy@linutronix.de

---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff3..e68ea64 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,6 +99,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT

