Return-Path: <linux-tip-commits+bounces-3499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39CA39944
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDABA3BDB5F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40705269807;
	Tue, 18 Feb 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XBC499TK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2ZLpwhh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A022268688;
	Tue, 18 Feb 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874410; cv=none; b=L+NC6X3InpIQ/KiR2rYBH87oMxIlDvfXCh8NW2gZ/VhKphGeAua/a1L1h+YuGvmnZ7IIhqigNgYFDR0leoK+iFD+dKBgqHZsEVjnKfECJRQqZzfvZ/YMMLKf2/6sy/s4QYxf53CN9koQLTFnZdTiyNNJ0F1/wUINMvouHodL254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874410; c=relaxed/simple;
	bh=gEWoB0hsGCFrQV1/BzLqJgCeyxty4b/OLP7To6VmluY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iP7yZQDzks3CB+6KSr661OLZxhr3N77dwig3FVR9Mirunmbrd85i8oLBacvvwqAMCdo88KvWbJRNBIOYSJdNeF/KAFvG+8o97sg+OXf0ocGliP56bF8Cz7fGJXqWwl/GCcf8akR3rngj9ilaYdhKMnxEHDcI0zFwQ88ScsyDSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XBC499TK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X2ZLpwhh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JL9IU5z+Jczxyv9jNHlpiYoPo6OxcBo+Y+MMma++LU=;
	b=XBC499TKAmUIsVnunP332ULObMDqTEwI3qTiPqTevM+fssQNNgB+CywsEFop/Ru+EioiiR
	uEYDYCYJWStvg9YUgx6FDdLjkN2Ldvzpe88jLOISp78RW5nZgUBtUXc4Pm/Cv4zuQahL57
	L+nLnXKnDMPvCQ0JSjaU4nz67Fmqt6Xp9WmUGkNoub8d4Cz2tUOBjhYGpiepLxg/kO8Kgb
	xfE5+tivkup8DS0utP+Nja42V+O/yS337G/8aMYB3O1tVsOvyJmofPNFkG9YKXWwp9shno
	cA0Mp+aiS5Jmyj6VNPtMATSFaRxE/p26LI5THC4PPwJBEAuhCw5yqm4ggWCfgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JL9IU5z+Jczxyv9jNHlpiYoPo6OxcBo+Y+MMma++LU=;
	b=X2ZLpwhhjFYIS99gQxd5Bexney3p1O9o+GO5q1j9h0uxDfC+2RC0KZT2nXVAbWoNwqEURr
	955UgEi24N131ICw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] usb: fotg210-hcd: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ceeabb788995d7566017ebcff6cc2daa8da35432d=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ceeabb788995d7566017ebcff6cc2daa8da35432d=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440659.10177.220230683460228058.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e0e59e95eb388c16e9fbe796a253fd4b58478d36
Gitweb:        https://git.kernel.org/tip/e0e59e95eb388c16e9fbe796a253fd4b58478d36
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

usb: fotg210-hcd: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/eeabb788995d7566017ebcff6cc2daa8da35432d.1738746904.git.namcao@linutronix.de

---
 drivers/usb/fotg210/fotg210-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 3d404d1..64c4965 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4901,8 +4901,7 @@ static int hcd_fotg210_init(struct usb_hcd *hcd)
 	 */
 	fotg210->need_io_watchdog = 1;
 
-	hrtimer_init(&fotg210->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	fotg210->hrtimer.function = fotg210_hrtimer_func;
+	hrtimer_setup(&fotg210->hrtimer, fotg210_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	fotg210->next_hrtimer_event = FOTG210_HRTIMER_NO_EVENT;
 
 	hcc_params = fotg210_readl(fotg210, &fotg210->caps->hcc_params);

