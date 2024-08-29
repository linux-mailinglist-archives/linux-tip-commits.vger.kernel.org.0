Return-Path: <linux-tip-commits+bounces-2139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594059648E7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E32CB227B9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EFA1B140A;
	Thu, 29 Aug 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARUUC73p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+X4epw3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D45198E75;
	Thu, 29 Aug 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942781; cv=none; b=tJ/sSPfY2tjWhAQSdYr58Z9acOSUrAPuv4HDzPMMCT2CEi/RYUu5SvGRW5ee0m7Mmw1IpmAgmmMPhfQJqJGIdX2OeRTM73bw1NSmbnLcvJFKOssgUzSWZWkL41LTK4kaTpIrSUj7JCjlkr5vyFSLlKsEpYbdCv7XbC85L2lPOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942781; c=relaxed/simple;
	bh=oP+p6JZR8EbBKZK6lwOP5kLoP21gSz25hhgrYq3Auo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T7H86durBb75SPANKQg7+hsXfADQMfYZey0y9Kv9WXJaQK3teLkbbzIwHO/4oFunRJU2vOWt13NJ0F011u/UH+alUP1KryrOhh/V4q4fqKMY4IT12aoxsP8HfB3gPdMFNT11NwocK87kRc2ObjUZQwcCeCxLPBYp29OdT2Vp/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ARUUC73p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+X4epw3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Aug 2024 14:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724942778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tyV+mhaIm+00Q4hFtmJ0z4Gs2+nlp2ELnf4AwA5B2I=;
	b=ARUUC73pKVYL4V4u0aRFseZzAyOGIs23DBda5PJr7Jg6C4I6vmohsEa+RuHWVPhpo713+1
	MqyEG936bmfEKZUJqSRoTknZyM+x2pMPW1rLXLhcJMonPvZO3L2R+R/Gq14QBCeLn2lSGb
	DVQ4uAlMn+V13ZP9SxntFUcwYoLTYrNqbxFq+azBtLr75YNdUixfCSnizNjVYQz+RsGdpL
	DMF8QH3i1RQ02XgzzbZ2xlIiArFsySBg2M/gPE+v1HCNVFfNLbusWhr5qTzFkpUPH6/RIn
	DwMTgBOZ+BJH17k/m6EMdoGo6xMcCz/hzUrgiTWHKPriGXPbDdqgmuA5e4QZmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724942778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tyV+mhaIm+00Q4hFtmJ0z4Gs2+nlp2ELnf4AwA5B2I=;
	b=y+X4epw3lTTWe1BR7OEumo85Fw4TwOwvdt8NNUDzf8CcM9zFJxKGWnW5XQrB1I2hL7ZcBk
	dD7pfi1QZ4wVdcCg==
From: "tip-bot2 for Jeff Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/proc: Change the return value for set affinity
 permission error
Cc: Jeff Xie <jeff.xie@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240826145805.5938-1-jeff.xie@linux.dev>
References: <20240826145805.5938-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172494277829.2215.4612784053370186889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     eb29369fa543e7d5557c19ebecf072244bb14815
Gitweb:        https://git.kernel.org/tip/eb29369fa543e7d5557c19ebecf072244bb14815
Author:        Jeff Xie <jeff.xie@linux.dev>
AuthorDate:    Mon, 26 Aug 2024 22:58:05 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2024 16:42:06 +02:00

genirq/proc: Change the return value for set affinity permission error

Currently, when the affinity of an irq cannot be set due to lack of
permission, the write_irq_affinity() returns the error code -EIO.

Change the return value to -EPERM as that reflects the cause of error
correctly.

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240826145805.5938-1-jeff.xie@linux.dev
---
 kernel/irq/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index d98fb9c..9081ada 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -140,7 +140,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	int err;
 
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
-		return -EIO;
+		return -EPERM;
 
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;

