Return-Path: <linux-tip-commits+bounces-5900-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B72AE8968
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D1A161543
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C72C17B3;
	Wed, 25 Jun 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L8VKAdOb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ar41yW1n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F02BF01C;
	Wed, 25 Jun 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868160; cv=none; b=MeSimbGFCop+NVS8a2pVcSW40n0VqUmy4Kq9pYLNCeSRHTUOjmDFU0raRHm6CiRTKiIdq8kd3VqQRYbLXuWMDMugDT8bRx61zd7BMuOSiYzXHzk6DsOYZOJNIWNCW1o3JIo0KWi/8UXCVwDwgGdNkE5+Z7dAECMPLrFpT+8D5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868160; c=relaxed/simple;
	bh=7uxwHEfbbUihzSLB+PaXNWkNiYSbKgbJxQOJSWeWIjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H3kYFJd0x/jq3ixYqlfLlDLN2bYE6IpfSuXFxMipZqPmEsvn8s3B3PXdlPtsYGR+eWVQXnLfWcW8VywxKTu7MXe6ysf64PoEtbP/7ODKNv9C6urx9fzUdsQ9eiFNpDYNyqtVpMVR4Q6sQd8K6NlqgIyy61Iik5IzAOQCZ/4cNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L8VKAdOb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ar41yW1n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:15:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY7YTo8FvaSdaGVXfsVnon1HJe/6EgNNVm+fL44JT3o=;
	b=L8VKAdObc3YDpZYf4ADzszinX39u/cKXjUvOXF1whx9MmuHBnGMURyxn8i61nXUXRNmPTE
	EA8J64B/2oKOmg4sFMV8asn9ezl9rUn9YAgfKOsYalwuZ54IGj0y02L1oFpuwxkRRrLS4L
	MyibIk8OnCqNrOW3K6OxjlDvxkW7nkJRjXWn3f/h313kfqUr6HjHlNJDcKEdUqzph5L4qr
	IMaUQvTpG5paw3NzN4OyKNTQsVd5cDWNC/qVEKmFBFCRP22NgCOOnrjVdoWiW5wzzhKY4e
	jEZfVmQqOeH13BvnJzHfifzTan0YrB6pWNHm+wRC5q0wB2jLEHVqF2r3t8M1eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY7YTo8FvaSdaGVXfsVnon1HJe/6EgNNVm+fL44JT3o=;
	b=ar41yW1nL2GengF4/8anxYdlyP0QHPtD5tn8PSq0vQWmg1uqrPZwpj4QIQJIJNkOJxGMFU
	+nQZjj70mbbwlpCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] ntp: Use ktime_get_ntp_seconds()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.472512636@linutronix.de>
References: <20250519083026.472512636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086815615.406.2923173556935595786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     c85f5ab60820bde1510110e403d17456fbb8c266
Gitweb:        https://git.kernel.org/tip/c85f5ab60820bde1510110e403d17456fbb8c266
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:24 +02:00

ntp: Use ktime_get_ntp_seconds()

Use ktime_get_ntp_seconds() to prepare for auxiliary clocks so that
the readout becomes per timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250519083026.472512636@linutronix.de


---
 kernel/time/ntp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 9aba1bc..97fa99b 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -303,7 +303,7 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	real_secs = __ktime_get_real_seconds();
+	real_secs = ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 	secs = (long)(real_secs - ntpdata->time_reftime);
 	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
@@ -710,7 +710,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 	 * reference time to current time.
 	 */
 	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
-		ntpdata->time_reftime = __ktime_get_real_seconds();
+		ntpdata->time_reftime = ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 
 	/* only set allowed bits */
 	ntpdata->time_status &= STA_RONLY;

