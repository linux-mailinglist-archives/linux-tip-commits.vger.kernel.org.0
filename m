Return-Path: <linux-tip-commits+bounces-3438-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B53A3982E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64151888A13
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425B423644A;
	Tue, 18 Feb 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaWAc8YC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1HQM7FWe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B122F140;
	Tue, 18 Feb 2025 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873204; cv=none; b=mf1iUEYtGfg3N0PkKX7hoOsoPrpxB+88iWpVtTcDokbQ0LnJTQYTcO2NgZHC4JiLGo1sVH/iBbBxDepH0v+/MzRNdv/7Kl/sMhNeygNZcGTdwP6MS2muqsrlhe5tfIYyxXqzIw7tWT1qEM0djXrTZdZ5sHLMIcMBc4uy7brTGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873204; c=relaxed/simple;
	bh=yXIqYJretiTNm0GV4bUi4qVybzSfRuCcQkM50NZ78VE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E67E/dgjBz93m+NpqrqgaUXVayvD4yMix+OiK1i9p2J8PCjlgMCAQlFqVLEtMMwFvhMoSdQmuZBTfiRkjZPeZeW9yN4ZnBXP0E/U7okLV4K0TANxYHar75Kek2yymf3NnRX12zZ92ZIR8shcML5P8CLP5S8ZhcwNObBmJHMWHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaWAc8YC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1HQM7FWe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG1ThWSRojCiy+5C4cvJUB5DIJR/Js7oG+bzkEzxjIU=;
	b=OaWAc8YCfCUVSd2g17qxm2m7OlVePbrQEmhqaVJ5lrW6h9ARrnFcqee/YPfy364oG3ZtKj
	4x3FzvnIKfCugiJtA4FAhPpG/bMEJP3qs6yTaY8iUA6iAzp55G39FFQ8H3gGf2eIEp2qVy
	rTpXFSLEdyqjiWZRo75xQSE0NXiublQuCwdsqzpVYXPg4LB3z9xyRD+2T/iIHn3/aK3nK5
	Q8QGLTZRtkYDVzrK2REH2Ts1Mj+DPZjoZbAt3O79HhgpYzdkswwD9QIRqfmXMl5nfPOgIA
	zK58BLy8BQZqmRcur1MKE7h3d39BEwFz2ZkgJolcRaWUAFjpESkkM+H3wZ7pyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG1ThWSRojCiy+5C4cvJUB5DIJR/Js7oG+bzkEzxjIU=;
	b=1HQM7FWeJSRUyQuPXgm4OanzNdAb32GMbJRtSyMSpBSDbZVxpoy/CGzgXc7y336L6kfkOO
	Y+oKOX+Kc8dZFiCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] igc: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbaeaabb84aef1803dfae385f6e9614d6fc547667=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cbaeaabb84aef1803dfae385f6e9614d6fc547667=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320037.10177.17581840589021279328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e26ad10db84bf60b56dfe738ded119a5ae1ca2f2
Gitweb:        https://git.kernel.org/tip/e26ad10db84bf60b56dfe738ded119a5ae1ca2f2
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:47 +01:00

igc: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/baeaabb84aef1803dfae385f6e9614d6fc547667.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 84307bb..733820a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7090,8 +7090,8 @@ static int igc_probe(struct pci_dev *pdev,
 	INIT_WORK(&adapter->reset_task, igc_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
 
-	hrtimer_init(&adapter->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	adapter->hrtimer.function = &igc_qbv_scheduling_timer;
+	hrtimer_setup(&adapter->hrtimer, &igc_qbv_scheduling_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;

