Return-Path: <linux-tip-commits+bounces-3521-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F359A3A361
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C98016241E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D526F46F;
	Tue, 18 Feb 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uo8m9ikV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLAufBvu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EB26D5C9;
	Tue, 18 Feb 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897865; cv=none; b=OY5iqonSOu8yPJTqAbQV93QFwhotcUrNT1pMJVA9sQ/8tPwrWjXqhlDSjaTP6lGuMcbPC0akIoafGqFrjIUS4Kg6DKa9C/APnfmdeZPLyJyi37/B7R8680Tf1tFKAiefV7hBolAOzpFHBba1QJlS/uHiTr0gzyyOpziFvwbP6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897865; c=relaxed/simple;
	bh=mtgxC4vv/uPostSGVmC2q3fbbZIeC8MuEF7cg3N/JkU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Io0CeHvi/fvmmRO0IK2hY/NjYvmG3JHM69oktDSXVWaY5ITYwXCtT6P0IVDNXlKnNCA7LZNMjKxlZzBvcAYxGTLgWW5gySP3fH2dz1OPhlhu2MP3UIVBy42wwtQzECdUypJFbci7JmYSV9iHChjIdpRa1PF0l59ALcHENS/Ey5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uo8m9ikV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HLAufBvu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 16:57:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739897861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XWHFTDarrp9hq29SXb9FJuB5lv/DVhlk1bMYuKlVE=;
	b=uo8m9ikV3Ra/EsBlGGoOy9yxuy/gbuKB3R3bSJvG8qKWprVAt6AHYHjG3ZmvRpOAI+mx5a
	48K6tg6415tBE27hkdPWk/de0lMhGOye25TnNvvXmB9LRDIflqBSeTqt2OpCrtBSVrEo/U
	bnoiGfefQdBB77XqawemJAIIpA9Vp/jc4ADdXLowqCyTgydPjbz3a1qItG0XeTd/8ABGDg
	2mVjOtUTgoEf7RK66oJqjr9PgOR4sOX6TDTYz6DgD82OhvB/KjgcFsIt9YfxO+tj2lIvhl
	G0Znk2He2yO10VxINP8XWWgIQQNtJHwqwXTpTXhTfYVlwUFcYuP7yP3gWBxNTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739897861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XWHFTDarrp9hq29SXb9FJuB5lv/DVhlk1bMYuKlVE=;
	b=HLAufBvu2aSG8FR4Ub40RC9oP+3xQB4wHu/Jv+HJ3IzPJBWqjzzCXuRqU0rDE+fCxM2Oot
	hHW5mbpEKTccR/Aw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] wifi: rt2x00: Switch to use hrtimer_update_function()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C82dcc0eae40bb84e6452f242751c0650e79bd87e=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C82dcc0eae40bb84e6452f242751c0650e79bd87e=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173989785856.10177.15234202593281922434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     86a578e780a9fb0e1a1b6f3f3aa847c29b5255b9
Gitweb:        https://git.kernel.org/tip/86a578e780a9fb0e1a1b6f3f3aa847c29b5255b9
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 17:41:35 +01:00

wifi: rt2x00: Switch to use hrtimer_update_function()

The field 'function' of struct hrtimer should not be changed directly, as
the write is lockless and a concurrent timer expiry might end up using the
wrong function pointer.

Switch to use hrtimer_update_function() which also performs runtime checks
that it is safe to modify the callback.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/82dcc0eae40bb84e6452f242751c0650e79bd87e.1738746927.git.namcao@linutronix.de

---
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
index 5323acf..45775ec 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -842,7 +842,7 @@ int rt2800mmio_probe_hw(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Set txstatus timer function.
 	 */
-	rt2x00dev->txstatus_timer.function = rt2800mmio_tx_sta_fifo_timeout;
+	hrtimer_update_function(&rt2x00dev->txstatus_timer, rt2800mmio_tx_sta_fifo_timeout);
 
 	/*
 	 * Overwrite TX done handler
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index 160bef7..b51a233 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -618,7 +618,7 @@ static int rt2800usb_probe_hw(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Set txstatus timer function.
 	 */
-	rt2x00dev->txstatus_timer.function = rt2800usb_tx_sta_fifo_timeout;
+	hrtimer_update_function(&rt2x00dev->txstatus_timer, rt2800usb_tx_sta_fifo_timeout);
 
 	/*
 	 * Overwrite TX done handler

