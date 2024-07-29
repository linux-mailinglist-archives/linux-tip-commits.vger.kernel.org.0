Return-Path: <linux-tip-commits+bounces-1775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC793F1B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4672B22BBD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854A14659B;
	Mon, 29 Jul 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6iBZ/4N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ced61RW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA314535B;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246592; cv=none; b=Xzcuqr26kZhulCa64EyVioQoF8rbK4Fe9jtfraDPCROOgu1fq7zRkzGZ+OiQ8SagOvKSUIazO9n0HsNCc6O6MwzZdjKnk0dbIg01V/9AphpJEVehScHlsAqK/wyewoC9SKXtYOG3BnC/agU+OcTZAGWIuZYWPYfxckw6TjCoXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246592; c=relaxed/simple;
	bh=dgzpPGoxeOUH4RYFA8zxCbhMHLJ2JuS+hDh1aLqMPrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dWb5dhRu+WBnKBSos7J57v7nVLarUo/mhNwptTgzWnWdP6gwVhnZ+xcASZxNW8byo44vMc0Nj215sss2vdSubCL0uEASFoQpzer/NOcfRtDTi1Uq2R+cZTeOhyEepXXwn7ZIMB3l7fY747W1XwyJDL6v63e5fo2egagJficZsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P6iBZ/4N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ced61RW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvqM4hXfOdGa/uDoV4ZH5yq0LLmNeOATC4EndBsfOYQ=;
	b=P6iBZ/4NVm63HB1TzsxEVZfzzl+VIlQ2ahQueGmlakJFXRoqG2l3uk+2oiqW+GCyrKRFEK
	63h6/jLAP/HC5paY/oTu73CRBmppXFFfdyZF1AUQ5izo6b16AZpj/UN4BnHIa/RRZzCX4r
	0LKyv18zbUThS46MhL6k9PMWgf7Of25NeB+CaBSKhLFoOiuEPyr/t+D7aT89dEfDny2xsc
	8oI9xgMGQvd+cJyJkw7yK7DfkB3PGNWFRjIfCEyUg0MgJ3Uqo3u2p9WzgvSxsQKc/z7A0B
	QPUV2oqU4J6Wk+4JUYiGwOndlxgpz0YSEXjewB15MjJZ7OeqkGAuPAkYjwk8iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvqM4hXfOdGa/uDoV4ZH5yq0LLmNeOATC4EndBsfOYQ=;
	b=1ced61RWcOWBUQuPdzLkut0KuquPV+bXIqfAqTSLl/nn/MwZPkcy8dA+vhMrpjcOvi4Cfd
	M49VDTcq1QloXWDw==
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
Message-ID: <172224658580.2215.3481294553014427086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     07baef5aa275b0957c508376df36acef2d64645c
Gitweb:        https://git.kernel.org/tip/07baef5aa275b0957c508376df36acef2d6=
4645c
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:18:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

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

