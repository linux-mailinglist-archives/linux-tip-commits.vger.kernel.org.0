Return-Path: <linux-tip-commits+bounces-2185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B5F96F6D9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B100E1C242CA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C71D174A;
	Fri,  6 Sep 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1b8DaDX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AAE/XDIN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663641D0494;
	Fri,  6 Sep 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633114; cv=none; b=GZW/CSYSQCjwIh2metTdXyanCSzYLwmQ2YLHWPElKsqq0D+jf8HI8ywbNcFJtcKoULTZPOeQ0Ah7kPhUVZYWbkJ6L0y3BrTiE49YEBqcgdCmQnZ/4r1w/mAhCAAwHO+l7X9fHclnrZ1EWWj5HDBNKHQ4yuhPDhouNQbPhXFf2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633114; c=relaxed/simple;
	bh=4krHYtHBVodpVvdRF4m+U26SVZ6nkeQa2m4gqJmw1Ww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IyrYr5kMnyc67izJoVV7IYQUeZhsUDkIk9DuJ/P7Zd/rBys6+YI0IrqkBpAF26/0EbR35q5NPFAtGoNiZkMoDLqIadF+ljNyNDpSLyGbI5xvxdaHmS63tj80ncyV1bFkk8nKIJkeXGOKi/CA4mi6Make2chlQlOOSv7BcpVuFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S1b8DaDX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AAE/XDIN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 14:31:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725633111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AebdZDqMYlZpapALDlSdI64hNVLjUd86FtGVirem/A=;
	b=S1b8DaDXkDfsjrIrir6SsKfspyLcLI+hFmkFnIL8sX8v2tnRIwbn35hEgoFnTdzN82HsUO
	M+2GOnA20NwPN++Q/4qhMU5Rln6EOxjX10ntapawu3L1uQzQauqdcnRoy9SYKEe5pr6pTZ
	im4Jj5+unzt4MbfLzaianlQ4oigKwTdI0FNsaJrA2OFCHlQP+CXw94ErY38x31LKM+c9/E
	QRtXPDKhrhk62jBFbkVfjZNA8er7QkuUVfN/BKYosS+oeuIMeCkLpLSFOLtI4pTxtvrcWz
	vD65OmoGrqPfgXPN6hlV1VA65ecyBh8GarvQxGjPuEY7i6lxYvcWnLbF4Ss2Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725633111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AebdZDqMYlZpapALDlSdI64hNVLjUd86FtGVirem/A=;
	b=AAE/XDINNj3ffVuZ80nxG4KpNIXCfB4ftej9fP4TUoocFnlTsq2DK2E3ZzvbKlEq8sy6D5
	Xy9q/CG2MlRwbQCQ==
From: "tip-bot2 for Costa Shulyupin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/cpuhotplug: Use cpumask_intersects()
Cc: Costa Shulyupin <costa.shul@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240904134823.777623-2-costa.shul@redhat.com>
References: <20240904134823.777623-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172563311092.2215.12674498600378438582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     87b5a153b862b7d937fc1dd499368297a1feae87
Gitweb:        https://git.kernel.org/tip/87b5a153b862b7d937fc1dd499368297a1feae87
Author:        Costa Shulyupin <costa.shul@redhat.com>
AuthorDate:    Wed, 04 Sep 2024 16:48:23 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Sep 2024 16:28:39 +02:00

genirq/cpuhotplug: Use cpumask_intersects()

Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
with the more readable `!cpumask_intersects(a, b)`.

[ tglx: Massaged change log ]

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/all/20240904134823.777623-2-costa.shul@redhat.com
---
 kernel/irq/cpuhotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index eb86283..15a7654 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -37,7 +37,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
 	 * has been removed from the online mask already.
 	 */
 	if (cpumask_any_but(m, cpu) < nr_cpu_ids &&
-	    cpumask_any_and(m, cpu_online_mask) >= nr_cpu_ids) {
+	    !cpumask_intersects(m, cpu_online_mask)) {
 		/*
 		 * If this happens then there was a missed IRQ fixup at some
 		 * point. Warn about it and enforce fixup.
@@ -110,7 +110,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (maskchip && chip->irq_mask)
 		chip->irq_mask(d);
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(affinity, cpu_online_mask)) {
 		/*
 		 * If the interrupt is managed, then shut it down and leave
 		 * the affinity untouched.

