Return-Path: <linux-tip-commits+bounces-1329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC498D7EC8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98512869C9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437886AC4;
	Mon,  3 Jun 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCqbZBQ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xhrtjtNz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80E86136;
	Mon,  3 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407015; cv=none; b=L+hB6+ATpQZ798+bXUhc2bEZ90r1dMwNt+FVpZQi2fUnKSZKydoolnFqjXsrcjSypIjyjKJ9MexzTtjubA/CX02qUWZnWf4xO/NIT/PIUrGDa8n/lOVHnIpGKuEdPulYhiPY023cPvYZ0GgUgrks1gO3xw0ZD9Qj+gKbT1WJYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407015; c=relaxed/simple;
	bh=SKoMz5R+/hmJn9cZuB9xEtg2XPsD2FRebfdc/8aqmow=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gStatPNVtW/3TS1qkEqk4zHAQB9JWHf+4W8dw2V8wSRuaIKI3t4vWELaNjhhxDB9RFlYApSoB42xaPhskHoVepGLZ1XWLg2et5mE9WGCVGBJy5uCxpdTHZBvwk7KSGtf4tcb5dciq756CqAz+Z8F7vZd20IDVU+jLWszNXsi0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kCqbZBQ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xhrtjtNz; arc=none smtp.client-ip=193.142.43.55
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
	bh=ko5I2f4iNxEkVl+BoXWUSSQHY+ebRcRzffk5Ejr9h7Q=;
	b=kCqbZBQ+pbhSXTLnDJt/TfF7ejj2mKTJos0ZjqokjWA2wSkvVCsISFKFK4qgq+ruRlGS1L
	v+8ZqQJk5Z6tWq3iOCE+vXuG+aNGL6qF7KLxSG8DQhRxKs/SfH/4sqEbRy4/eVBQSXEClT
	Y9+qlxxxnKlCZmmz+5hNWLM/Z+r163hFydsQOQNyI6Ri63yZWm5S+vlibqd0eOqR0JFKkR
	RvHJhTTRpX+ZNvaVmH6WSHYpC7rkL3oeXNsSyjSGLGRV6O8jnxg3HUce6aAm1HB3eIxcg7
	5dKj865yFtE4VYEo0s3TedsIFaoq2yZN5MBr6oEIH0lvbqEbNBsmWxP6rZo0ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko5I2f4iNxEkVl+BoXWUSSQHY+ebRcRzffk5Ejr9h7Q=;
	b=xhrtjtNz08loZEHuYIiK0BxaDSv5ZA8iFlQ5H5E/n8eWdzKdEDUNC6aQhDetUcmhyJmHLF
	8R78DTy/IgSooGCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] igc: Remove convert_art_ns_to_tsc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-5-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-5-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700897.10875.5949504634520577280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fcb05911e5832364c5f154b519a471225b34855e
Gitweb:        https://git.kernel.org/tip/fcb05911e5832364c5f154b519a471225b34855e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 May 2024 16:08:05 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

igc: Remove convert_art_ns_to_tsc()

The core code now provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

Replace the direct conversion by filling in the required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-5-lakshmi.sowjanya.d@intel.com

---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 1bb0262..946edba 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -938,7 +938,11 @@ static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
 #if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
-	return convert_art_ns_to_tsc(tstamp);
+	return (struct system_counterval_t) {
+		.cs_id		= CSID_X86_ART,
+		.cycles		= tstamp,
+		.use_nsecs	= true,
+	};
 #else
 	return (struct system_counterval_t) { };
 #endif

