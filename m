Return-Path: <linux-tip-commits+bounces-3425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA0A397A9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163113B949E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2472417C7;
	Tue, 18 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lH+ETarJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRzrJVCD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B94241136;
	Tue, 18 Feb 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872003; cv=none; b=ITLuG5Npf46f5Jfyb0u9QKn819BEZEomIuJxGsetQR+XQb5wOpyAuXeemn/TnyMWDWVT1lM5AF9/IZE6ESr6wQUXsbky0jkiNoR8SotzRhkpYRl4hHZeKydrlL6N/q05FoUAyG8fJFuB5izS41x2YEU/kl6dII+hPV8sq/w65Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872003; c=relaxed/simple;
	bh=My42XFiT1TyuVVAnou9bT0K07lxSbf6pYeBnD3SpuQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t8tRQ5e/YFGqw+YioWI4HwqM6L5go/V/v2MBPR5H1emBUSkxdwRi3Q76fxsmL2cMzJxjhCSJqgP8QE/0hN+obtBv49tGKwO4IO7rnn0J1v3yqloxuTVRqu/scv5GFjM06Uywr74rapH07C0Y7qv+8iNexQL7YYUNJ4fS911A1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lH+ETarJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BRzrJVCD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWYwqmiZNV/j1fZWOrucDnodEh4gQ9LTVq0AysQIE2s=;
	b=lH+ETarJ3pCKUm1TSv4X6Stp48KQnmoq5sVYa+uUzqc7Brsmcs610FUG+Nl3cpRDEb8Rbm
	yL/Ts3MDDJCYC2tGXjyuDo6ZA6LryP6yq4CmdY3V+CIaKTomeLjtbAn5WPVS7nYQsxQA3K
	zKDklpX3lQPJSRFXSjJSNAB1iTCwlanXioBv+ciughrSSdO+fJXu0f3wuW4KoL1/PJ+e0B
	PMM0257jmups90zK7ad8dWqhb2v4/G5Cs1VkxVrBmjZFFL0kOMy51Eb8zqzu7GmVKR5I8b
	bnCZ91juI3uv4Rul2m5+WUIBqyXIdr9buh/ihIaiInLdqH5SlYDGS+KVmlU86A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWYwqmiZNV/j1fZWOrucDnodEh4gQ9LTVq0AysQIE2s=;
	b=BRzrJVCDB1HgjL9QyaHaCRwiEbeWqdndwTCKMtlEVuaTQ+MrVdKYicXdH9rr6kQ1IAi19R
	WiEsVf94RQrDWVAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] powerpc/watchdog: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C099ebf6d352094a56e22fdfe76582b50f8fd6029=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C099ebf6d352094a56e22fdfe76582b50f8fd6029=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200011.10177.16460203953948877633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     d1f0d81b3604506cdd128578f778b899bd142b94
Gitweb:        https://git.kernel.org/tip/d1f0d81b3604506cdd128578f778b899bd142b94
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

powerpc/watchdog: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/099ebf6d352094a56e22fdfe76582b50f8fd6029.1738746821.git.namcao@linutronix.de

---
 arch/powerpc/kernel/watchdog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 8c464a5..2429cb1 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -495,8 +495,7 @@ static void start_watchdog(void *arg)
 
 	*this_cpu_ptr(&wd_timer_tb) = get_tb();
 
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer->function = watchdog_timer_fn;
+	hrtimer_setup(hrtimer, watchdog_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer_start(hrtimer, ms_to_ktime(wd_timer_period_ms),
 		      HRTIMER_MODE_REL_PINNED);
 }

