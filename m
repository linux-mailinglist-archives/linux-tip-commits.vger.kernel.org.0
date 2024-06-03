Return-Path: <linux-tip-commits+bounces-1326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFE8D7EC4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F01F27DD7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F485C7B;
	Mon,  3 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5TrLINk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyGllTyQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9668592E;
	Mon,  3 Jun 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407013; cv=none; b=ucYIBAsrJXpe9HSfVRlwx5fmIpAoXwGTogdAjZbHhCiJ/toywKztlXigcPZHYPLyA9Hlez2JBNFa59c0bZSOb5k6ZJmb8UannPUDl+EbPOi7VyAbMOuVw0l2lOKaQ6N2OUy6vxwUI9nnEX0l7kcswC88m6pnldPqND1DcoSF68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407013; c=relaxed/simple;
	bh=+p8BxJD+68L24HPRnqXuSQhmyp/9HF25yN1AjkfExzw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JkSacqEC0xWGfBy3Ayi76JojkRkbnUpEiHb4Qk+l+vPl5a50v88PFCn3zlm3PpqRXPWZRIPhJp5lYaCwlJZhijQtHF/CPEEK/cdNvSaf49l9v0/zCpT/h07uLgxD7O0qmDwfoNndWYyDaRM3un9CYRy2OmbXSiykwpl4cVNT4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5TrLINk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyGllTyQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqcLKvtYJ9TZ1EDrZbzL4x3uPENnbcq726v8T9HD24c=;
	b=Y5TrLINk4ymXQjvlWARXqcNIVVwjVci/+M8NF41AyeRHk1Be4F4N0wXsB3Rtq8NT2pUK40
	cPM6dsPRhYY3vTLrui/U8K2gz46v4/dZKAG3P9K949POZXLY9UFngUJBaTbG/ZoGqKd4JR
	SDuconcIKptjCw/r4PBFJpXIEJL/ypQYsZQO+ejrDZv4jdRbwMn4vCFQwMW/sYCfFdKK2g
	6DdRtquqLHVJq7QSYoQagCyLkotoKlaKGbsZhGFoOCFOOQPQ4zk8wFHRC8Og2evKbgSA4Z
	179tb45ggEr/r6u0urQBTFMntSGs6L+5yTTpqERvjS+bRwtQvRH0LWGV50QRoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqcLKvtYJ9TZ1EDrZbzL4x3uPENnbcq726v8T9HD24c=;
	b=UyGllTyQxSfD+7zVteqYs8IZgmRMZ6OnEEjIcP424h3uDRTUbKsvPp8KhVBzpCZKA0qsT2
	Ja1V1njRrtWvNgBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ALSA: hda: Remove convert_art_to_tsc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-7-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-7-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700865.10875.2013333477065427380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b3266ed85f77047a9674100f0da8058750e5bc62
Gitweb:        https://git.kernel.org/tip/b3266ed85f77047a9674100f0da8058750e5bc62
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 May 2024 16:08:07 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

ALSA: hda: Remove convert_art_to_tsc()

The core code now provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

Replace the direct conversion by filling in the required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-7-lakshmi.sowjanya.d@intel.com

---
 sound/pci/hda/hda_controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 766734d..5d86e5a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -463,7 +463,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }

