Return-Path: <linux-tip-commits+bounces-1251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2F8C22D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9538B282835
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BB16DED7;
	Fri, 10 May 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZx3lrzR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gF/OPs3T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304416D4F5;
	Fri, 10 May 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339459; cv=none; b=rcEmzsxoBDkvwH5U/5+wg8rbVZyNFt+Pi35dHdElQBGizBcAU4iUE1vvGWuqwVWGI3RObhmzCCQvGPcvr+Nl+VnHHiuIudwgpKBlB8ptU63N9BOSRCmkvQHBT2uU514RCWsulcfCq1qZOz9woHKJOYp5fAkSHspLPYwNkwmKpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339459; c=relaxed/simple;
	bh=s/BduAsQtkna1v/t8B1LVDTCSTElUhIJsDQIIta5sJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ltLaPBv3OuFdZo0zwqeghOYP0a85KHfcOhoRiZ7FudacHtB4T6S6VTRVu07/ARnYerwkarGakaePnRn3UkT/WED27A07QN1fLyJxX/UvjTlv9pb0T48lQq/LfyXzeuvcOvhWSNk3g359H5JFeMxGUYy4Oq2HSTdqZ6qSkwX5GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZx3lrzR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gF/OPs3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 11:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+akgnEKG1a/0tjKyIimdQIX5N3Cj7a+mickcDAywlw=;
	b=JZx3lrzRh49AHujCECV/2wWepPROBHeEymBsrMmLbopaLfzYHpzy3r/saDnyR55DWqEg8k
	xRPNaVyobgjd+3aM3fUCj2TrDd8roULKMKedU2jjew7qKlqc3FKSVT8+9tEcSrC8xRxM7v
	2qEErMwcg6PfC5xPsA73jYv5o5wuAOIQ6JIps+bT/ySPHhcZKRtVtU1D+xwq5w7ITWxv08
	FCN5Eq17ahirmF6xTaEQO9M/8MZkKQGoT4z5XvMOkWJJyTOefY3+4XcwV25n4P+DdvFjXV
	GdhpECkCUUSabZiAeAVbbXuDp27q3rrFkhW1HthfpxefsSI4t/QxGiLKcQAySQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+akgnEKG1a/0tjKyIimdQIX5N3Cj7a+mickcDAywlw=;
	b=gF/OPs3T2vto3nhaeM7Rfnd57LYCjcrgyFprsdrVkkEetNjoqxRFfvSkrE54utU5M7nO4q
	VlMTUAYZzX/5T2AA==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas-ostm: Allow OSTM
 driver to reprobe for RZ/V2H(P) SoC
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240322151219.885832-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322151219.885832-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171533945606.10875.1795103966213328108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0f63c95aebf11d87b166a5dfd389957c67fef9c0
Gitweb:        https://git.kernel.org/tip/0f63c95aebf11d87b166a5dfd389957c67fef9c0
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Fri, 22 Mar 2024 15:12:19 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 May 2024 10:41:52 +02:00

clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe for RZ/V2H(P) SoC

The RZ/V2H(P) (R9A09G057) SoC is equipped with the Generic Timer Module,
also known as OSTM. Similar to the RZ/G2L SoC, the OSTM on the RZ/V2H(P)
SoC requires the reset line to be deasserted before accessing any
registers.

Early call to ostm_init() happens through TIMER_OF_DECLARE() which always
fails with -EPROBE_DEFER, as resets are not available that early in the
boot process.  To address this issue on the RZ/V2H(P) SoC, enable the OSTM
driver to be reprobed through the platform driver probe mechanism.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240322151219.885832-3-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 drivers/clocksource/renesas-ostm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 8da972d..39487d0 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -224,7 +224,7 @@ err_free:
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#ifdef CONFIG_ARCH_RZG2L
+#if defined(CONFIG_ARCH_RZG2L) || defined(CONFIG_ARCH_R9A09G057)
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;

