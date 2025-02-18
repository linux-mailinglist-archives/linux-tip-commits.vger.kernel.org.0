Return-Path: <linux-tip-commits+bounces-3486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6DEA398E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49D97A288B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB0248189;
	Tue, 18 Feb 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NclQ+BCH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBp5RAI3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246E24634A;
	Tue, 18 Feb 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874402; cv=none; b=p3tFZz3v94IttLRu/40z7DRTRA3v6FliOrMaxQcaG9/BdENTTRP/sT1GOwHz7UzW209wA60mHSME+ZvDZ3QOnwx3Y+xXF7qGjORipDQ7O/a/QOGMpqLXxBHq5Up7jDfx8plXWAXgqQxP3iLkDDCRP7coTpENOw2thjv5bpS9Lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874402; c=relaxed/simple;
	bh=RltkqKCKBXNDQGaCwYwCcJtB1bwZoJhmoizKtuYGUaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LcYksLdAmZ0p1WoAwJedaGqEZmISu+hH8U4HdKnVigEgPSuXroWq7M6zNS/2mYa0vmzWOgccWR/p4W56lA3DnuYIfb/ft4ILSZD+/c3ye2QX8Ixcfh8hObLZxH1fbMjWYWnX6Hr23gcj6toij8lGNqKFW6pf2DSHVwPZVg54BW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NclQ+BCH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBp5RAI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMPPBnYqQuqgpgRDzLikgVXS/r6ctwGD6UYhN+C9+bA=;
	b=NclQ+BCHJnhxRTuYZ2bmZU+/I6F8oQXf4ipcT9p9+r3U9nFM7qXcpbMMuK/7UYS5JwYcq+
	P9u4wteqkrxXIn038BkJG9AEPIREowQd0xdSRF6tQv8mN5h7UTQriiJ3Ja9WSJSiZR8TMK
	ktJCJXI7xjoodEDf3N2i2Um7rehpgbHKkxOOV5HrqCsIqC1fXL8sKPrAz4bR836MWe4WJA
	7pBPZlA2GpFPOzV8yR1EHAjv4vjAWQH6F/qVLMgKTm7GP0XarN6APlFQCixyeRvEqlgr7i
	UiPqxVDWd2vHGokH+MnXUxygU/uuIZu/zPtsZ/m79D4D1xsHtsgDpl/mitVerA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMPPBnYqQuqgpgRDzLikgVXS/r6ctwGD6UYhN+C9+bA=;
	b=GBp5RAI3w9T3o/soV3zbWSwjej2Bv5a3MNR/w/myRmWf4pKCKYJnNn48Ek+m20fhM1iho5
	lZoWlAqTZbjDCjAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] powercap: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cfffc5ecc232069d91817b519dcafd8985120e51c=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cfffc5ecc232069d91817b519dcafd8985120e51c=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439839.10177.3559370386157258803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     d9a67240729dbfb097a1258484d8c8ae100769b1
Gitweb:        https://git.kernel.org/tip/d9a67240729dbfb097a1258484d8c8ae100769b1
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

powercap: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/fffc5ecc232069d91817b519dcafd8985120e51c.1738746904.git.namcao@linutronix.de

---
 drivers/powercap/idle_inject.c       | 3 +--
 drivers/powercap/intel_rapl_common.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 04c2129..5ad7cc4 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -339,8 +339,7 @@ struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
 		return NULL;
 
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
-	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ii_dev->timer.function = idle_inject_timer_fn;
+	hrtimer_setup(&ii_dev->timer, idle_inject_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->latency_us = UINT_MAX;
 	ii_dev->update = update;
 
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 77d75e1..cf3d806 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2064,8 +2064,7 @@ int rapl_package_add_pmu(struct rapl_package *rp)
 	raw_spin_lock_init(&data->lock);
 	INIT_LIST_HEAD(&data->active_list);
 	data->timer_interval = ms_to_ktime(rapl_pmu.timer_ms);
-	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->hrtimer.function = rapl_hrtimer_handle;
+	hrtimer_setup(&data->hrtimer, rapl_hrtimer_handle, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	return rapl_pmu_update(rp);
 }

