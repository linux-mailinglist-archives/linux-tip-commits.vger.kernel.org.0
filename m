Return-Path: <linux-tip-commits+bounces-3446-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8137BA3983C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D03D1896BDC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEA23ED7E;
	Tue, 18 Feb 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwAvNWdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N29gjN6E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D932343C7;
	Tue, 18 Feb 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873210; cv=none; b=rHql2PxtYNCh8oEY9aVIb86EEKzimNqYmIXLpzl295LC4mJLrGv/eVMnhOn7b7oyXmSuRDPSYbNfouDyTPq8hOem2Kais6VsGo/TZh1eLM0m1lRQg1Ya1Y4YnQVwxwNaAuLtUdvFRG1Pfqlp9CCiPiMQAaiwm3VLcwFO6i4+4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873210; c=relaxed/simple;
	bh=ORuxWNB45vWPml3ZHY0AUy2n5mzhbd5HzDWgiPgKG5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n40U3ogs1bkfbiKKA6KpjiD53Ez+z1HJm8+mR/YmETGQ6MgBpXJkXuU/Oe3XRFNXKy/2W5OIzOnTWDNX6wOyZfeW3dTWnzQubLSLglrpu0P33BUeKwkVLaZep3+w/LLMrRE0FU9BltFEQE9MQBEeYnipe1qRv9uRdbtyx1jlsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwAvNWdC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N29gjN6E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbUCSGBduw0j7aecyYVIjz7IPKZzgGCwf8gizfPoI54=;
	b=FwAvNWdC5XQgoHlwNs6kvoTNOT3OqbsSCQIckldHpnIujfTtdYY0P20+R26Ttfi5TAsJJ1
	sJaS6Js5Szaj7i1M9rKxbD/4WsnqdpMhRLM5rbmkiosjffLYGIwWmwnC4pChrPjxjgMwvc
	3YXJGJ7DQ7Qldp5V3sXPVuUXFOsPtVbZpvfSel1iLK5A7oEZT4UK3mi2kp762uj568bbF2
	VoAq+0y+PO6xs3B/tG6wBrc+DTr7aPCuPlgAta7KvpqL64fHUhSvtSThplePRVHKUcOIhd
	9Xqjn9FRDjo1MwoSinf+JyEB4A8EXJL+ieec6aFwMQ8jI08mVrByHddU5Ou0vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbUCSGBduw0j7aecyYVIjz7IPKZzgGCwf8gizfPoI54=;
	b=N29gjN6EAGhw/QXQmxfvkelJuiZLQGYJrkBuddUTdcOpfmj+fPN6r/lB9X6tZGVfLV3Etg
	txVtfkrL/Sa4LaAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: mvpp2: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C44e2ebca1a3c1b90213cdb79f7a19ebe0ae70510=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C44e2ebca1a3c1b90213cdb79f7a19ebe0ae70510=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320632.10177.17307872612347186648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4781599491bd62d88c34bb1dd6ac17d5f452fa31
Gitweb:        https://git.kernel.org/tip/4781599491bd62d88c34bb1dd6ac17d5f452fa31
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net: mvpp2: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/44e2ebca1a3c1b90213cdb79f7a19ebe0ae70510.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index dd76c1b..3c7b437 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6985,9 +6985,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		for (thread = 0; thread < priv->nthreads; thread++) {
 			port_pcpu = per_cpu_ptr(port->pcpu, thread);
 
-			hrtimer_init(&port_pcpu->tx_done_timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL_PINNED_SOFT);
-			port_pcpu->tx_done_timer.function = mvpp2_hr_timer_cb;
+			hrtimer_setup(&port_pcpu->tx_done_timer, mvpp2_hr_timer_cb, CLOCK_MONOTONIC,
+				      HRTIMER_MODE_REL_PINNED_SOFT);
 			port_pcpu->timer_scheduled = false;
 			port_pcpu->dev = dev;
 		}

