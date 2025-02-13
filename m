Return-Path: <linux-tip-commits+bounces-3361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF94A33F14
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Feb 2025 13:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26483A2CA0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Feb 2025 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B7221570;
	Thu, 13 Feb 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03wE78lF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="46pwfePF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566722154D;
	Thu, 13 Feb 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449560; cv=none; b=bAAZFdi1616zi0VbZVABvdj46ClwD5yoVFzcDN7LY+h+Sh8BQa0B0XrzLPx7QYhnJNr16NcmE8BFuSZ+WsYOkoniuN9ijiFLpa+gj5Fv45rmd3Vpi6gZFHBwiWlWOY4fbfWOIqJa0qNO6gXJQ9jqZqRklXI7y04TmPpPbgqQrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449560; c=relaxed/simple;
	bh=FyuIqyRwY5pDKpb7ccdF0fQ5vbPAdd5lkH6XBrhkYQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j7ObYLZfLSl59Y4i/WYiJiuV6yykDTfM09FXbWj3D+qBuWAtPAenq7kdlAgW/fPeb6TZV1vNmde1tGIr6ryqLuniQxWf+OGrTmDp8LNIsV19x+9HzzspAJMbeaeAYu67VK5bWvJnZg4OmTXU17bo0XBNOfTUVK0OL+XUIUO9xzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03wE78lF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=46pwfePF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Feb 2025 12:25:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739449556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPfERE/UbKRR3WrPrpYUc66xEFupz7II8bdHYN9nBvA=;
	b=03wE78lFIaOm3LbkD8reZ/VITLra6NjdaPYGCIShJlAOlLSJhUdZyU9Z+bcDKWfCa20S8F
	j/Os0oQ9corM+SQRiSvozUyv9O7j2kC1JaVfRkV+KaRfj35uxQwh47SAca+IPhd2CaFbM5
	13UD2SPWz3HuQHtDIQsOBzcQuudJw+/0wLGhNpq4+6I1PA5FH8BmA5aFxI99FTEOjH3gLM
	ayY38c3CVUE9LIDHdFceQ2sLrqFVY/hXb6UTurfdSkNZQ5LVTHWke8QUetkDXhodfZpw9c
	jNvZWZvhF/Y35yHoYYtocGjncaRlxBfd9tXC/rXs8v96hBgIkBfzazAZFO52zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739449556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPfERE/UbKRR3WrPrpYUc66xEFupz7II8bdHYN9nBvA=;
	b=46pwfePFhpMxVHBwp1NsiDTIe8q5JkGFZpf5+c0lP0aO/A9O9mBNQ/gzKSoDMOFTqgrkKd
	15A3JrFbWwEIe6Bg==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] genirq: Remove unused CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250209041655.331470-7-apatel@ventanamicro.com>
References: <20250209041655.331470-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173944955351.10177.11768052833964210440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4cf7d58620bfc2ebe934e3dfa97208f13f14ab8b
Gitweb:        https://git.kernel.org/tip/4cf7d58620bfc2ebe934e3dfa97208f13f14ab8b
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Sun, 09 Feb 2025 09:46:50 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Feb 2025 13:18:54 +01:00

genirq: Remove unused CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS

CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS is not used anymore, hence remove it.

Fixes: f94a18249b7f ("genirq: Remove IRQ_MOVE_PCNTXT and related code")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250209041655.331470-7-apatel@ventanamicro.com
---
 kernel/irq/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5432418..875f25e 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -31,10 +31,6 @@ config GENERIC_IRQ_EFFECTIVE_AFF_MASK
 config GENERIC_PENDING_IRQ
 	bool
 
-# Deduce delayed migration from top-level interrupt chip flags
-config GENERIC_PENDING_IRQ_CHIPFLAGS
-	bool
-
 # Support for generic irq migrating off cpu before the cpu is offline.
 config GENERIC_IRQ_MIGRATION
 	bool

