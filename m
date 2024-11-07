Return-Path: <linux-tip-commits+bounces-2810-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522E9BFC18
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D52A1C22110
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B54188010;
	Thu,  7 Nov 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="popPNzpi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="knnM70ir"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7185270;
	Thu,  7 Nov 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944783; cv=none; b=IrguBIzdrukr4iTqTtOQewZvLpb4D2pv5tjppcu4N5Rm6T7FYB54eKA7qxCCbi4rmujGdyYLmuNs5v1VcPHgjjLXHj1rm24gVjXUCBw56Bs97CsXVB3C5qHGPNJdxrushx4yDMCNObBnc51QgErG+lqAzTMc4FrRcU0ZPDXKyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944783; c=relaxed/simple;
	bh=4O2cFqW9dsUc3RED5juBQRkx0d/rfoY1oJJiiAqCX18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oJ992JvOf2crsPNWf4cmvgdFVBOZDeJmoS3YzyqKzJZ0Ec1JcGoCc+n75AgEazVMgZictsakATVqoaYdZ11F1cs0chEDoI2UnsfO2lKEWy+FTuycbsUsdvE/83njcqeXmI7zM5DzIJ6exS2TVNsTZQY/cqx3U++rfcDpGmzvGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=popPNzpi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=knnM70ir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944780;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBkTUmCPvAmUhj02JcXV4TPi5C9GzG4vdiQH6k5Nk+M=;
	b=popPNzpibXbY6iAAfVD+Hos70CqsQbbwd/ogr/R0crh7T88TdyI7udgLP5UDW+UazHvS4P
	ZWYmYCkV61AQU0cvxzSeK5MivGA7J+2hmuYb9bFqupmHQKNaM9YhvMAQsCDSe5YZ5w9PhD
	tsrFXaGlui9nnbUYEzDWjuxbxl45YnIOI93UUa94hpwYPxo9vssag0KQHcN5PZzUOuF5Kc
	d85YZkObgAiL38+BLG6G5o0f2fxLHrNPAP3WLaBAOLyjFiLS/S8kO00B/LSyXcLtnOusgu
	eNcwUPALw+bPvTHXUN7nJdHGfe5lA9YlzLqluAxjybAuYAUDIUuKW29D8nCRLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944780;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBkTUmCPvAmUhj02JcXV4TPi5C9GzG4vdiQH6k5Nk+M=;
	b=knnM70irEcYAgYk8gZfclT1cBBwP3FavfKeSmThlQl7CVQvNjIoaBN2MmeE1hPKqENT883
	RVclUK+FBFGGhcCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] net: pktgen: Switch to use
 hrtimer_setup_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc4b40b8fef250b6a325e1b8bd6057005fb3cb660=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc4b40b8fef250b6a325e1b8bd6057005fb3cb660=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477991.32228.11956079685760237726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     eb688451dcfb7de0fef678a476096d3616228815
Gitweb:        https://git.kernel.org/tip/eb688451dcfb7de0fef678a476096d3616228815
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

net: pktgen: Switch to use hrtimer_setup_sleeper_on_stack()

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage site over to it. The conversion was done with Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/c4b40b8fef250b6a325e1b8bd6057005fb3cb660.1730386209.git.namcao@linutronix.de

---
 net/core/pktgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef..7e23cac 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2285,7 +2285,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
 
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
 
 	remaining = ktime_to_ns(hrtimer_expires_remaining(&t.timer));

