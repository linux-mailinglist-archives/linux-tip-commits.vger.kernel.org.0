Return-Path: <linux-tip-commits+bounces-1324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA608D7EBD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2FC1C20DC0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE18594A;
	Mon,  3 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UvRWJcm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVoY6OvJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A685931;
	Mon,  3 Jun 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407012; cv=none; b=N87HdHQi0yegynx/GvaBCYBih/DccC6afCcMYFAG6NR7xMWxKsBbEPtTT8wc6fg/FLeVRF3SK+BiOSQg7xbDCUP0kvsGJW34sfjJKF8ZiD+tb/E6T8ouzw659C+1KKiMYnn/Atln3WE3O3gGuyMzgGFxtX0h7GEWH9ryRu1PwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407012; c=relaxed/simple;
	bh=EbfRhRvX0YmpSQ4H+AuNCb37TXew4OReq8NHOoVoJmk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EqAQeij0EIET5Y9Fclm1QRcZPksGlxXfYgF44euEnCqEyGxTo7TQRgSq5tixaFe2IN0IJ357K7nF23mDVKGBPKdAmsFxYe4h55UnD0lCVHNeFHRBQEag0eOeGPBm1wAxHqPmERmoCDUzN1poSAQKSSesU+XTmLgNTl9vjE8JXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UvRWJcm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVoY6OvJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBS3t7i8rvf6F3dT/f4V89nXZNkKn7+4PUbYJd50L5c=;
	b=0UvRWJcmD4G6eBatfVZQCqPg6EyKHh3KZop/zILIGyrJ94c1TMOM/kTbzh0GP6CdNcvA7G
	ZnONrsWJbdCI8Mb1VYOa1VHmHjSEH1/X1mEUxs2nwdz4KdcMOLB+q1JPfAIMzHCiw9wvwp
	DROCPVnmAp/nGcdNPtbkNrZSECSuf2D/uB8Gav1tu1+JtZ6dloaauyqxgMzOedYYO1fz75
	s0eIyoDgkCD6/LwY7ckTRMWWK2ymF6JvZZNcIjUwnlZXBPLOAzghJA9xwfhCfTUr82U14O
	hrII8O89EHtUMHi+bU8/C8gf2npqySJIyxUgM/mZuGjp/dvDKd+7f20/sQCtvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBS3t7i8rvf6F3dT/f4V89nXZNkKn7+4PUbYJd50L5c=;
	b=gVoY6OvJfRlcYOLbV8bBpneY2NrGPQNS6kKBY3YaMLJT11lz1l53P/fuKgP3s1oVHQ0hsk
	QbsmH5o9+oliqaCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] stmmac: intel: Remove convert_art_to_tsc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-6-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-6-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700881.10875.7399681112741840932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f5e1d0db3f02b11a0d1ef433da1fa2c869176c82
Gitweb:        https://git.kernel.org/tip/f5e1d0db3f02b11a0d1ef433da1fa2c869176c82
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 May 2024 16:08:06 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

stmmac: intel: Remove convert_art_to_tsc()

The core code now provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

Replace the direct conversion by filling in the required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-6-lakshmi.sowjanya.d@intel.com

---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 6028354..e73fa34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -390,10 +390,11 @@ static int intel_crosststamp(ktime_t *device,
 		*device = ns_to_ktime(ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		get_arttime(priv->mii, intel_priv->mdio_adhoc_addr, &art_time);
-		*system = convert_art_to_tsc(art_time);
+		system->cycles = art_time;
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
+	system->cs_id = CSID_X86_ART;
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;

