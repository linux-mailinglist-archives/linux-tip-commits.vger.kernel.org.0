Return-Path: <linux-tip-commits+bounces-1250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6018C22D6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336BB281EDB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719F16DEA4;
	Fri, 10 May 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQ7KJgC9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBc+iRIQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13C16D4D6;
	Fri, 10 May 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339459; cv=none; b=cOLtXj5P3HyQKmBzN6bAIpuMqESOQH14DHK6WoxJv9OzBDGXoehiBxNbpQkKElZ8V3KThYlkPr8rrQftN/Plh3KGmEHmqrqbgdF0X8zHfO4KsCOt/srSjkQ/YRJGQzDIX7FyQeJJ8/B16xUPcGix0M82PoK+WCd/CQl01xNN2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339459; c=relaxed/simple;
	bh=aoy+HxgThksvO6F9G/p9TwVTMPK+wmn3HEFu4fEuQ0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yz9hes9vyQ5Q4m/mRvB5QxDYdNR/9b/HMRyBjj46H2OSMfan6Yq5bSajJ+nSUIe3uBTye9Ha+Mv+T7Bsaaw2hhh3gPw3CseVmvqsSWf0dcoJqScx2A3InZfzHXyLquDLBp4C8zdjBL7Y5vw2BGGMmSvMa3ZdKBJMnN1HpBLfbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQ7KJgC9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBc+iRIQ; arc=none smtp.client-ip=193.142.43.55
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
	bh=eKILAj63o3uR+a09F1XYTJoiNiBurLJFCJcOv+t7JBg=;
	b=SQ7KJgC9zominL1N2rWowt/LP9apTaSKkirmJ+ldtQTmqAHcltzDGZnJC14FXf2OlQ7oD0
	fFrFVWvf+TwXCs415ZCwdNCXWlL8e7U7Junct2LsvQyKuloK7yaymRDiA2LTg1MoQ1E9hd
	7LL7xA7EtQCT2cmmBgV/Qd0jPQdWqyX0GW6JhwKEEA/vrL8WEn/kFs6YvPOUC59ibyLjA6
	dN518UNxaui8hfBLMMtUWc87oO2WHiezNLpOOSO+UsO+XQyDvQMwEGisfsCjS4x9rE4NQj
	1PmPQ0VSI/tTr9noUO1G4Vvt+C3fK83E/eFes6TcBGZYZXSl3foNVGxI9bna4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKILAj63o3uR+a09F1XYTJoiNiBurLJFCJcOv+t7JBg=;
	b=GBc+iRIQ7imnAw4McIg5NMR3OQa1QNu/Fw1ifsJM7ygtVuyI/ngcl1980BsKDv72BHMUqw
	Cl0EtXLU+8jSyhCg==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas-ostm: Avoid reprobe
 after successful early probe
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbd027379713cbaafa21ffe9e848ebb7f475ca0e7=2E17109?=
 =?utf-8?q?30542=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cbd027379713cbaafa21ffe9e848ebb7f475ca0e7=2E171093?=
 =?utf-8?q?0542=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171533945568.10875.107116071251658868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     37385c0772a4fc6b89605b9701fa934fa2beb2cc
Gitweb:        https://git.kernel.org/tip/37385c0772a4fc6b89605b9701fa934fa2beb2cc
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 20 Mar 2024 11:30:07 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 May 2024 10:41:52 +02:00

clocksource/drivers/renesas-ostm: Avoid reprobe after successful early probe

The Renesas OS Timer (OSTM) driver contains two probe points, of which
only one should complete:
  1. Early probe, using TIMER_OF_DECLARE(), to provide the sole
     clocksource on (arm32) RZ/A1 and RZ/A2 SoCs,
  2. Normal probe, using a platform driver, to provide additional timers
     on (arm64 + riscv) RZ/G2L and similar SoCs.

The latter is needed because using OSTM on RZ/G2L requires manipulation
of its reset signal, which is not yet available at the time of early
probe, causing early probe to fail with -EPROBE_DEFER.  It is only
enabled when building a kernel with support for the RZ/G2L family, so it
does not impact RZ/A1 and RZ/A2.  Hence only one probe method can
complete on all affected systems.

As relying on the order of initialization of subsystems inside the
kernel is fragile, set the DT node's OF_POPULATED flag after a succesful
early probe.  This makes sure the platform driver's probe is never
called after a successful early probe.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviwed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/bd027379713cbaafa21ffe9e848ebb7f475ca0e7.1710930542.git.geert+renesas@glider.be
---
 drivers/clocksource/renesas-ostm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 39487d0..3fcbd02 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -210,6 +210,7 @@ static int __init ostm_init(struct device_node *np)
 		pr_info("%pOF: used for clock events\n", np);
 	}
 
+	of_node_set_flag(np, OF_POPULATED);
 	return 0;
 
 err_cleanup:

