Return-Path: <linux-tip-commits+bounces-3445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C9A3983B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B818969B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5623ED64;
	Tue, 18 Feb 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4OKXZ/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W8p2kEN9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9F23BF96;
	Tue, 18 Feb 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873209; cv=none; b=kqMvif/4cjDXDy3yR+l5gpXX0WebyZmhvk5V94EwMCwBN+3KWcoPeNA+4yHc86z+z8sD4GO4TGPVfSHB3U41coi0e5+vXuLQOpfch1+Ois0gkBSB4qx74sXRb7fe3z6pivUSuz8WC12qcHQ4zmZiQatpckQDC7+oD9R1LLfKqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873209; c=relaxed/simple;
	bh=BTvxXHT6fGyPgfpnq6+oZmzmDoXn90o08INtAgI/TMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uBOeBy9ZbkXUlXeO76KmhFi2+ahs/y99d2E8+/3j40MqrSW97cMxzPsY2SwBqP8uVNaaj02KeHVSvQCnVb/v/g6cw4ZbW8SdCLkvDMI9CNGDhz5y5Dfs+ocG5jkfCEh2PbCWXP1uwJvN4i93KTyLCzMPDo0y6B9SumfvwfCFbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4OKXZ/z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W8p2kEN9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d2vJgwciK4zHMC52UBX+fLOMHrV6E2pL3K5YkYkCEE=;
	b=A4OKXZ/z86TeI/4x8hNzwTV/dvG+GFPHfB2ol7+fMGo/HelIMv/QtMZVWPhB1Bo/ioukPr
	8jixYloKcL0rOni+lhusW5CngX/NqbV7AQkYcv5QBdXqPkva4BEPN2ygzrIFOcmT0Ab/8Q
	D/L2qWhtRnRycF5cICwk0ERhAO4mD0o/iQglKILZEt+c63iMQG0Oa3+qCuOHUdo1cUE5yY
	7EiM0N6hcuSKM4Ok1dBoSOsTF0o2e1r2tu3mB7DN2ZcFGZB/Lvo2WGNpPh1xA/wDzgrOho
	Xuo+XWXRH6G1WLRjG6efQ/FpWk8u33eSbVU6FSM7PCyxMJqVz5YVi5PUniKcnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d2vJgwciK4zHMC52UBX+fLOMHrV6E2pL3K5YkYkCEE=;
	b=W8p2kEN9Viw9xBd41NIBEZ4nyVoPwzsSNXH6MOFuxX2mPQnNTO4oRJqs8lN+6FNMmZ7SVI
	sCnRBs9FcfXs5TBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] net: qualcomm: rmnet: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4312885d95fc99053b2c285f74cc83a852c03f4a=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4312885d95fc99053b2c285f74cc83a852c03f4a=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320564.10177.6369973855907910338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     3c85516612f8861cdfeefc300b7631f0d4797fbd
Gitweb:        https://git.kernel.org/tip/3c85516612f8861cdfeefc300b7631f0d4797fbd
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net: qualcomm: rmnet: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4312885d95fc99053b2c285f74cc83a852c03f4a.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index a5e3d1a..8b4640c 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -686,8 +686,8 @@ void rmnet_map_update_ul_agg_config(struct rmnet_port *port, u32 size,
 
 void rmnet_map_tx_aggregate_init(struct rmnet_port *port)
 {
-	hrtimer_init(&port->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->hrtimer.function = rmnet_map_flush_tx_packet_queue;
+	hrtimer_setup(&port->hrtimer, rmnet_map_flush_tx_packet_queue, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	spin_lock_init(&port->agg_lock);
 	rmnet_map_update_ul_agg_config(port, 4096, 1, 800);
 	INIT_WORK(&port->agg_wq, rmnet_map_flush_tx_packet_work);

