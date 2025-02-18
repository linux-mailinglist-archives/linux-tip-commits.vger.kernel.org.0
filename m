Return-Path: <linux-tip-commits+bounces-3440-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408EA39831
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E654D1883D8C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C7239567;
	Tue, 18 Feb 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="csIKuImK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+YoTmDrK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363A236A6B;
	Tue, 18 Feb 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873205; cv=none; b=OZDvNCfEROC8ZpqjlFVa0iEhlZh4RpfHDcb1/+LEPagNcNunoq8+Kxr7fl29PsiljCDPIO/JGPJ85zxtEXE7BQ1nK+QJhxj6SoecJoUXp8OTqVRVQYhZO+KDSQoUmixpXSUDHN07nEPGUfsf3qaIN6WnVvajImyZA40VfgywtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873205; c=relaxed/simple;
	bh=BVN21/b0UEgC/bRmJbyCJOtt+oZ3ztVV7X5tCcp9DMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n34kxGWtrfkGzr5tmz8gJJFWfM6CAo9PCNNO8czNE/P1MoSd/KoJ5CIvQYj+p4iMFzNj7lyMvKb/oEEupUrS3RjoPnOdUkttuJelyGX/h/z50RHmrEp9VxawzEngpDuSuYsSWqTYjglhfGJnrtJHnj3tc5301MJz9A/IJtSLHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=csIKuImK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+YoTmDrK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7D4xjQu+cR8mjks4tzvRZlASjVir2UfWSPwC03W8lI=;
	b=csIKuImKZtRJm/8Ph2kRcrtO96FQZfna+787pXg6vM06LYnvzsXNuXkMJcke+8iXORcQBO
	Y8wS64ontxbvHtoZW8CG1dL5IKPvJWbFziVa1eia2wNKFD/1a9rM/X3VEl1h4ULsyr6TBm
	AsBeMp6g2NEJbZWb4uIW/S/zhmqwFafWRnBg1KKDt7MgudO4tCi89EF52lxuiPjZe4Ykpn
	cozZ/i+qhusOgMIPXaEmgAjJwIcLZoftxNPTYmPtD1B2IQB5Rs5/0va+MdGAB0/Qs4cDLd
	RwZjyHBHL/pRjVsO0KHzk0+RaetnUrfKQWOoz3Tn+LJpJLtPpQJXgk+co4Ss2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7D4xjQu+cR8mjks4tzvRZlASjVir2UfWSPwC03W8lI=;
	b=+YoTmDrKv/fsJ3eVl7SeA7R0K9ANRONNGEgMAr7mA/KKVfDP2N+pK18X0/nSs7uQ9+i8jP
	0/YCHkMZ0jmPDDDw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] wifi: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C71fbc442aee9a9e892e475f3bbf8f368c6692a55=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C71fbc442aee9a9e892e475f3bbf8f368c6692a55=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320189.10177.2760002109666907888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     cbe2691bee4e54024b9985ef78e740d9655d92f3
Gitweb:        https://git.kernel.org/tip/cbe2691bee4e54024b9985ef78e740d9655d92f3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:47 +01:00

wifi: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/71fbc442aee9a9e892e475f3bbf8f368c6692a55.1738746872.git.namcao@linutronix.de

---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 4 ++--
 drivers/net/wireless/virtual/mac80211_hwsim.c         | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 0e1ede9..4840d0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -264,8 +264,8 @@ void mt76x02u_init_beacon_config(struct mt76x02_dev *dev)
 	};
 	dev->beacon_ops = &beacon_ops;
 
-	hrtimer_init(&dev->pre_tbtt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dev->pre_tbtt_timer.function = mt76x02u_pre_tbtt_interrupt;
+	hrtimer_setup(&dev->pre_tbtt_timer, mt76x02u_pre_tbtt_interrupt, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	INIT_WORK(&dev->pre_tbtt_work, mt76x02u_pre_tbtt_work);
 
 	mt76x02_init_beacon_config(dev);
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331..fb187a9 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5548,10 +5548,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
-		hrtimer_init(&data->link_data[i].beacon_timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_ABS_SOFT);
-		data->link_data[i].beacon_timer.function =
-			mac80211_hwsim_beacon;
+		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
 		data->link_data[i].link_id = i;
 	}
 

