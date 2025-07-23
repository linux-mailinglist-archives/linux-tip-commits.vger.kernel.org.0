Return-Path: <linux-tip-commits+bounces-6165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C60B0EB9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F4056779F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086022737F5;
	Wed, 23 Jul 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMbrIUil";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUIGaSlH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC8272810;
	Wed, 23 Jul 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255043; cv=none; b=nJvhhDPIFAv/UFeMaW7R50bMkZopSGSGnnJG1FBTfJS94IKW97eRzcMW0VG0tbf4c/MbztDaLQFNeEBS/l5vMb/QApFhemGHW58ilhU0SwiBfxlrggicsmTiIQSbnm7Xy5vVdSO0ciKKSWXhax56z1uojYQ4lJ05kqSXLRqQmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255043; c=relaxed/simple;
	bh=6QHUZ0mPlcqx3rhA1FnNO6LqIoQ0nzryRrR/5O6s3e0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oH77U+WpNnrGdjV2HjbhHlgo+jek1aM6QuaDI+CbZ4mkmgPXzErbsz4w0Wp57QjUrO/2NJmDhtWOAqs9LGJpIfQ2xRlfHKpiPQEnbD9jOVqtFBjNuQcsnf1Sr9Wx24f6a2D262Nc+DPgWoiMUQ2AG6+WkWh/gvzQ3GtlbFUT0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMbrIUil; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUIGaSlH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVCc2bhrcNc+nRJtoK30+7+2YINuWy5sssio2W5cMX8=;
	b=fMbrIUilCINB41oHxFHTFKD4ENv9n6ddk92nvZoTEO7KBqlVzZojOccI9dV6dD3Avb22iY
	vzvW7Z781c+RPb4walPJbPStJKdnnDMDIPRxXhTZ4VYNGE8kMgr5sPYxuLt9B5EFfZY88r
	2/fTINMEttnJDueW5TR7lNGEfcygoxLhNhORYsFTcZwv3Ekx0zr7jmiJ9jRUfIAQCmx6ES
	EmB42R27c9CXMS2onCHaUODyc0yCMPPTnw0XnD4V6xPjFOHrGzaga98UFTJtbOjHS+5dYL
	ksEQIrojFJmRelN8F/uARAtL6ouaMJ2iQDCmyVcVk2X+se5rxEyjGQbsTC/zRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVCc2bhrcNc+nRJtoK30+7+2YINuWy5sssio2W5cMX8=;
	b=DUIGaSlHp9mw7DFLeQHEEqx44pzs/Ln5jO/QlmTZnxUZAYd4Y7k+MmHkMZ44/anxNnoPTR
	kDL9q7w6wBEmMJBA==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/timer-econet-en751221: Convert
 comma to semicolon
Cc: Chen Ni <nichen@iscas.ac.cn>, Caleb James DeLisle <cjd@cjdns.fr>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603060450.1310204-1-nichen@iscas.ac.cn>
References: <20250603060450.1310204-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325503930.1420.13921362121071219878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     85242ccffd57ba4f8dceec7e520da6065d20fd87
Gitweb:        https://git.kernel.org/tip/85242ccffd57ba4f8dceec7e520da6065d2=
0fd87
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Tue, 03 Jun 2025 14:04:50 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:23:38 +02:00

clocksource/timer-econet-en751221: Convert comma to semicolon

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Tested-by: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://lore.kernel.org/r/20250603060450.1310204-1-nichen@iscas.ac.cn
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-econet-en751221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-econet-en751221.c b/drivers/clocksourc=
e/timer-econet-en751221.c
index 3b449fd..4008076 100644
--- a/drivers/clocksource/timer-econet-en751221.c
+++ b/drivers/clocksource/timer-econet-en751221.c
@@ -146,7 +146,7 @@ static int __init cevt_init(struct device_node *np)
 	for_each_possible_cpu(i) {
 		struct clock_event_device *cd =3D &per_cpu(econet_timer_pcpu, i);
=20
-		cd->rating		=3D 310,
+		cd->rating		=3D 310;
 		cd->features		=3D CLOCK_EVT_FEAT_ONESHOT |
 					  CLOCK_EVT_FEAT_C3STOP |
 					  CLOCK_EVT_FEAT_PERCPU;

