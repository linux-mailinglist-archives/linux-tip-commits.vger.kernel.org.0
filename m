Return-Path: <linux-tip-commits+bounces-6530-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC690B4AAB8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C3D1C61F9C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB431B83C;
	Tue,  9 Sep 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2blWUm0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmCylEfW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446A31770E;
	Tue,  9 Sep 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413866; cv=none; b=m0+vd4wqZO3c0ncgk4J2eirRkPTddTUfvj86gUdbPSI0APqibxm1FtRJcNK56jSt9vIR6u7aR0e92k6URiyE31FDlyBGd/092teh8DJJJvERajNGoJroWBPjeTVYqnKgW8U6pDKCLAXhvzcsCH/gmci4D3I0MANuck4kTkjAHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413866; c=relaxed/simple;
	bh=t1yx5TzhlLyaiAvsQuF1pJMRjehw4UAV30YQ1DURObM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DMS4SPV/8+wP7xvggC/IyHFWgd093BkAefnee3XBbjJpnzkojnjw8203prafKtVpHKAL8WLhPsTyC/F10QaAEjPX9yuTVpL9TqEd5yBWZdAsouIVUi7eqOFN1LJ6/Tpbngv3EJab9KJPNurpZSsLjG3aCLAtaol54hX+4ooaMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2blWUm0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmCylEfW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpOhYEYwxVXvxPXEALMXhULXh3aLbibx5Qg6SaucrTs=;
	b=b2blWUm0HTkPT3H0XBDb5G13HGVytx0nphtsdHiwsEUgDpW6tqH0zZ8JGrh9IhXdaSOWlh
	xOposhUhL0CvynsnfnvePnNfzcAeheBtfQTQ3+Ec+r054L7lOSCDaNnmBuNtL7APQ/An7n
	evS4aFwQzHHlLdFL8crVCcrEomhQj2Bgl0iqrGBZTNQF+9jCJMHumcRz7rEw7W8f3atxhl
	L8Di2ZzWflCom6B7P0YHVXtNzThBb1DExS0wECL9v1+A5Ayhq7ZSDJ2hH/OJ+XX4uMvMEZ
	e75xMABPSAiYt5L7fgJKqhNhWNORWSpMEET5fLMyshFQ8L3vWNprhA0XWigNcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpOhYEYwxVXvxPXEALMXhULXh3aLbibx5Qg6SaucrTs=;
	b=pmCylEfWsPgUebMeCDQFwnHpzlK6TJXm2tpg2PhsPqAsKpscDhEgPTVyLNNK0jKSSPly2K
	lA9P5cnPWEzWzFCg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] media: pwm-ir-tx: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Sean Young <sean@mess.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-6-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-6-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386218.1920.14189869885705182211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     44d7fb8acdf833a97669afeeed40cf27eb1dfc24
Gitweb:        https://git.kernel.org/tip/44d7fb8acdf833a97669afeeed40cf27eb1=
dfc24
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

media: pwm-ir-tx: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to an equivalent higher-level helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Young <sean@mess.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-6-3ae8=
22e5bfbd@linutronix.de

---
 drivers/media/rc/pwm-ir-tx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 84533fd..047472d 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -117,7 +117,6 @@ static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned =
int *txbuf,
 static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
 {
 	struct pwm_ir *pwm_ir =3D container_of(timer, struct pwm_ir, timer);
-	ktime_t now;
=20
 	/*
 	 * If we happen to hit an odd latency spike, loop through the
@@ -139,9 +138,7 @@ static enum hrtimer_restart pwm_ir_timer(struct hrtimer *=
timer)
 		hrtimer_add_expires_ns(timer, ns);
=20
 		pwm_ir->txbuf_index++;
-
-		now =3D timer->base->get_time();
-	} while (hrtimer_get_expires_tv64(timer) < now);
+	} while (hrtimer_expires_remaining(timer) > 0);
=20
 	return HRTIMER_RESTART;
 }

