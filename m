Return-Path: <linux-tip-commits+bounces-1716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C519351B4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D2B2839CB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C6146585;
	Thu, 18 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0uFSxZN8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXTd5bsk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E440145B26;
	Thu, 18 Jul 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327945; cv=none; b=hJ2sTczHeGetuI7/Z0NgQGytWs/c1JgqmuIEv3T3pMGSJ2jTvOXm0Su4hiJFV0M1gw6uj6cOXdE6vOlycNfyf5K0M4bb9/UZgxl+AaDObrWJoXihYcjEUBmcnSLcpVYq9bqCm4VemCq0/RMPEe10sAg59dQGKG6RKJx3VwFivAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327945; c=relaxed/simple;
	bh=EbnQ1tO1SJrdo8r9i216Cc8mpxlCDHu2q4Cja19BUts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e3m0UCt5JvvXy6DSrSy5EHwNPseqvJVAMOgOMwJM8OhWnIpzahKxz5zKLxt6j9Lrxq9F9J81lsYKMmzTSqpdMle4HAJHa3k7UqfOow3b2iIYTP2dLeg6iRTMCGEIX9qrgt8nblbZH+a15TK7ixrpRDK3mwq83ACgTLJn+Kol03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0uFSxZN8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXTd5bsk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bel6rSFehh4Ks3QNmo1K0eThUdN6VLUMSOTpRFtO5Ao=;
	b=0uFSxZN8FHBGc1tF+mDB40AMPm9SOt5ZHXpcAZnBxeNL+dVpBcXEGr63JqpyD/geEPualz
	Kt9zBQrpMDUq6yujmxUhrIICgpimR2Mm+6IP+TsmzT75zzkJfpCMsEAy4f713h/jilR5dv
	2uyO/bGGUe/EXdMDH9Ov4ymbOSR2S0/jITaZBb+qMiq5P5AVUdMuDGByngsVXLxqX0ge2d
	NGYygFq/kb3ngPRLzTDeYlkIPevS6bp4P7bICCHQ1YaNGuG7HLKBaj86oPXMZo18Kdqe4A
	NkRZeSynywF0D3QY7mQWtGASELd33s8LgSlI4fwz5rrB72cb7wzmMndvv1jf1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bel6rSFehh4Ks3QNmo1K0eThUdN6VLUMSOTpRFtO5Ao=;
	b=zXTd5bskWG8OWqNZWLkIA5QB3n6ZrR4kMnkRMtUxUFP8ZNrHF6UTEbaFDWxFRnFIV6J7Ly
	rNNv5v55EgmOp2BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Remove platform_msi_create_device_domain()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.395577449@linutronix.de>
References: <20240623142235.395577449@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794010.2215.1648197144826510747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f6a9886a9e55a1e6bd78c7e505205d05ef50a71e
Gitweb:        https://git.kernel.org/tip/f6a9886a9e55a1e6bd78c7e505205d05ef50a71e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

genirq/msi: Remove platform_msi_create_device_domain()

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.395577449@linutronix.de



---
 include/linux/msi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 04f33e7..4ae036d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -660,8 +660,6 @@ __platform_msi_create_device_domain(struct device *dev,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
 
-#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
-	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
 

