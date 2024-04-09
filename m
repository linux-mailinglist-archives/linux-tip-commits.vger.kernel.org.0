Return-Path: <linux-tip-commits+bounces-984-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDB89D71F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Apr 2024 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8A51F23C32
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Apr 2024 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA918287F;
	Tue,  9 Apr 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cWNZsluN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/AAafD2E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165180BFC;
	Tue,  9 Apr 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659165; cv=none; b=nqq0W81H143HEoTTqXhtn+2ma8BkwrLMyE460fpWpDQYvjmxQmI3PWMTV3Ijz0KINPV/SeTxRkTC707KottS0mvkrDXu3RcI4+K8k+Q2j8HMYAB2aWzB9jCoU6H36rixyK+si60+nzYX3Cw5wD0Y98awcsimXyAPA89VYjfhTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659165; c=relaxed/simple;
	bh=oWUms48iRpTcDjY65dniJSBp/h2h6e7psB5H9E/kH1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m3iea7ZNacz5D5vHaGoaYswOztvs6bz0oaDL5/ha1BKIEaPHT2Y/jhoGTelU6xP6rKSW47K9aSc58HDrFB6vgW/X/9hQxteC2au9vYRtwZnDDU1R9nODwfLrXdsdJ/004/96q6zHyz4rwHE7xn2WaEBKAzlxqIw8FGS2MVHvv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cWNZsluN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/AAafD2E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 10:39:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712659162;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clwi8IrO6Il7fl8uan2j18C9A+SXakAKvz9lbcjWPjo=;
	b=cWNZsluN9ySCgECOfAP2hkdewtoa/86aHgFwVCxw2G44gVXg8eTXTlB8Zk7b2YZYpRQKx5
	EOJFlVqRh7/JEURVDA8OFL8DCdrcYp8ibiWC51ylhv3/xi39rJTbuilOYHJDofCSC71Td7
	Hx3EhomtykpnqXvTOvsS89JE6E8Nk/fjB7V/4ujgKLLbx2b3zKH2XSpGG/deazX/R7Vzfr
	J8utXKww5XA6M/0jhio8lorJhzMyukeMT6qNV8Tcw1u+cKDj0C/wG8yIGSykcKkg6sKut3
	2xvUI1TGLejT2gY63JUPyFpgpr+rnPMITz3I1wykqlh6+x9vIYR0/hQBzQd5HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712659162;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clwi8IrO6Il7fl8uan2j18C9A+SXakAKvz9lbcjWPjo=;
	b=/AAafD2EpZjOrJH9GyeH/9BRZ14CD45Kng0i8nUw8+4fRBYkbnEn52kMDARQlgl5Q1Qgx0
	CERfJGP2Qh4ifTBg==
From: "tip-bot2 for Li Zhijian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Convert s[n]printf() to sysfs_emit()
Cc: Li Zhijian <lizhijian@fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240314100402.1326582-2-lizhijian@fujitsu.com>
References: <20240314100402.1326582-2-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265916135.10875.2299933674711064349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     98fe0fcb326a923740cb8900aa7ed7fe538c984a
Gitweb:        https://git.kernel.org/tip/98fe0fcb326a923740cb8900aa7ed7fe538c984a
Author:        Li Zhijian <lizhijian@fujitsu.com>
AuthorDate:    Thu, 14 Mar 2024 18:04:02 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 12:32:37 +02:00

clockevents: Convert s[n]printf() to sysfs_emit()

Per filesystems/sysfs.rst, show() should only use sysfs_emit() or
sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240314100402.1326582-2-lizhijian@fujitsu.com
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index a7ca458..60a6484 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -677,7 +677,7 @@ static ssize_t current_device_show(struct device *dev,
 	raw_spin_lock_irq(&clockevents_lock);
 	td = tick_get_tick_dev(dev);
 	if (td && td->evtdev)
-		count = snprintf(buf, PAGE_SIZE, "%s\n", td->evtdev->name);
+		count = sysfs_emit(buf, "%s\n", td->evtdev->name);
 	raw_spin_unlock_irq(&clockevents_lock);
 	return count;
 }

