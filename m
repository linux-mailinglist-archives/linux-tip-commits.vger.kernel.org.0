Return-Path: <linux-tip-commits+bounces-1838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BA9410DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D6B285E3D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F51A08AF;
	Tue, 30 Jul 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HT06jDRy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixByoDIZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32C1A01BD;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339608; cv=none; b=L2oLEaMpImOrIKJix2+XVppJMjECp1xIfF1VqABXNIP+kogMJCxXbDZeuzJYMLi5yvQzexvMPkVZnsBSBcvjs2vDjU7ZdP6e0bSaZU8a/HFG7rv1INwtyEDugjQg5m1+RAYhoaZaCmMEYXpDANxFY//3tqatxlyFqcJ81u8E9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339608; c=relaxed/simple;
	bh=eKeLgpaNKJtK8eElYTDUHO9mUOmJcF/Ezj6ahkNzMHA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oGAe5GS+hCvzMMBeO4eCEl27+xeMUwZ3/yNNC71nXb5kAKZVmQggjufW3TXA/VvqGyQwHILogd4d6oCz77jnXeDZli4Bk+Ud4xhYbCQHvn4/qKAkLlZMPbTxBz1M1LHe5MJru6aOhQRM60pQwGVWsMDouSbeo0glWsVnjMfJbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HT06jDRy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixByoDIZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYgfqiyG1rxoUOLYMHn6U7B1GyDqmdMHy0D+tgUDtKY=;
	b=HT06jDRyz+KNsq+cuLTzA4V0Pm1EZwWlrFwcf0Z6WQOaJSeCgB+RyNC2h0yiPfbqd+2je5
	1ht2Z35cDazQA3CCtf1FoLhNTfIhBpwvsfrqhDpRp2gpHcPtxtxcl1GJKO0qjWp1U3U7dy
	HQN0egV80m4xlhykcI6ffyVw4j2RP06tC4Xm1CGZu7DVEKWpNZpsTSc6t4jryqyGRcWvZ2
	36n+EXEyupiTZvDN+e/fUz1wwm9XHUNyUfNyJV+XhTfXOnU1ZoOQSiWbD4NshjaOisAXx5
	iwdn1pO7XG1olCgmUKV1LzFM8g9gi59SOLXBFvnUF5Ulaj6J4ahec07BWZV07Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYgfqiyG1rxoUOLYMHn6U7B1GyDqmdMHy0D+tgUDtKY=;
	b=ixByoDIZPQ/2XzKfX2cuo96o1TYVKHz0Sfhg7iG53vx/nXKY9WTu+zbxiykvlhNJIBJJ5N
	at87SA6lytbscuDA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Change to SPDX license identifier
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-10-kabel@kernel.org>
References: <20240708151801.11592-10-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960264.2215.17680881873823067331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     045c4bb864489fda99309dfa902346570d576a39
Gitweb:        https://git.kernel.org/tip/045c4bb864489fda99309dfa902346570d5=
76a39
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:18:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Change to SPDX license identifier

Change the license identifier to SPDX style.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/all/20240708151801.11592-10-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index cfd6dc8..3d15d0b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell Armada 370 and Armada XP SoC IRQ handling
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Ben Dooks <ben.dooks@codethink.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
 #include <linux/bits.h>

