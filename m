Return-Path: <linux-tip-commits+bounces-2305-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E091497ADC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Sep 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CB8B21534
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Sep 2024 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3615820C;
	Tue, 17 Sep 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+jRwgkl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F0qSN/nz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644947796;
	Tue, 17 Sep 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564547; cv=none; b=Ya7RiP5tpDbX1WecQJi9DnYM78nfgTa5M3hv6afioMrGsPd9aO3Cv+pL9Klj7wYTKMX0GfRlVJ+JhYmvXUgRiCIijcwFy7yI6wqUNtWvQvp/grDSYATyVjbLc3QU8wrdta3XWoYPx0L0xTj5y709+Og8y0znm+BHlEu1kXLAB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564547; c=relaxed/simple;
	bh=jrfU2mcXJ/p6pXq7uVulShFBQ6PP1p3KEbdYm9Bp2xY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iAWKVtK4Z3fVgK93u2y4bfBXwpHk7SxKI8fHQ1YGs6rgqKheJWFJDa6wS68Z0PdlNAfnPkbMWQuy49ld++y4xq4HSiDLBG6sjG3Z60gYv4RUXqSZ6inine9MyMwrx0tQDu6FC/eOkcKVop0Ve8QG5N6HMae45SUzvRB+fhSpQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+jRwgkl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F0qSN/nz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 09:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726564544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J3ITomot24kU/qlt9hTow2+Ex6bVtYOw0rGIuINoSE=;
	b=n+jRwgklMSwMM5obYdtaTOiOxWHFXUVeHf6KC209mtQkpcrdSIlYmUXPx9n3NZlUnDIQ5t
	6OaKVEhb6ZhHVQQoGoS9WJSwTLxINMkvb0M9Vk2mbFDlY+DVai8pqsdWW3VVURRFtGhZda
	4+az5USr3GiUUueFgd14E6zViUD5It4csieAW8e9oOzvRQgCAq2G+NJ4Jdic+zM9NWDIAq
	TXw7YZwv2Pb4Bbkb2FqipK1ODj4fQ3j5hZkOnSiMMwzzaCg/n6+k4/2vthjYimwjTP4Ffq
	HXk3qJElWXuDdGqdJrn9rgliyMpI0OfsgJRMuDupNzw7WI7F/lGKKhlPpJmR1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726564544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J3ITomot24kU/qlt9hTow2+Ex6bVtYOw0rGIuINoSE=;
	b=F0qSN/nzQW5SnDWh0C+KRSQ+q77FNerEyYxH0rg5fhWf4Ls/a5RYzTiyxLUyZXwwnq/cE7
	cn7UyS2cxnueaBDg==
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
Message-ID: <172656454385.2215.14809030473559798489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     d8fccd9ca5f905533dc6c26cfd1f91beb8691c95
Gitweb:        https://git.kernel.org/tip/d8fccd9ca5f905533dc6c26cfd1f91beb8691c95
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 12:59:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Sep 2024 11:06:02 +02:00

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
index ed15b87..7da710b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -100,6 +100,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT

