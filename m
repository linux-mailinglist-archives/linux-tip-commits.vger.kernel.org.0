Return-Path: <linux-tip-commits+bounces-2454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9563899FB7C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E5283E27
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A961B0F3E;
	Tue, 15 Oct 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4FNokBM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5tna3Syc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513B1AB6D4;
	Tue, 15 Oct 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032084; cv=none; b=kOptsLGRwzmdL/KDY64jEVjGYrPq22K+OHDxb1VOZg8nhiCFwePGkKGVAGGZTROHBfkFlBaP9vCoZkknEfJDrUXlKriCeP3zmUrG5s/zqaNbI+Ercx01GvuXo5utoEJJDBTlYMagKsmnDHOOY5QxblJvAGbvadEqKtR0SGnBmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032084; c=relaxed/simple;
	bh=fQ4zfCJwUXkINdlcc6NplUrUAJg/SQr8PSsNbi/aqxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QLXk04ha9Uohodu61M+i0qdVrV7k4A50V98QOZumCAJywzOGM9AH6v+5kUgD8RfSL3irjAhtUY75pG7wv+y6w7IBgM4y0P0bHBBkVYeHPCMOURuPdz8mfcOp3TyO+w/NlDQ47nW9C7eEWEEv9j5gy2/fiNKdiJpqUHJ1aIVQYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4FNokBM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5tna3Syc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kbgTzr1XBbzMkEMuJqs0UjS7nolJFXjN8IPVQya8Zo=;
	b=m4FNokBMjtFQByRsl3ZfvLu3cvr9umvXSZUfvArsL7Cy4i5Dv/t9LDowTlOWknzhVRnfSo
	FEUisxGwk4Qx8ZySkgpCD4Jh7hyQFWP+QYvAIjxWhOzaNSIlUllwneKil0iBQLl+FCJjHz
	ZHOx5CyknHnLoitHd1rpNoggNbFRUUWzFukAK7v6y1Cwz6+m1NmS+GGFjG/GTeceDkl2iI
	waFB7AIWp0fAtiNm0AzPgDuxBedOYgnKKZ9u4NTJeD1iBx6hAFB/pqNALCj6lmg3A9Ap1y
	yKooZq2eQ7rICB6Lx12ICX1xxBVbelUGHkMF+FtM/XNmu2q4H8m/ORWmQM2tNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kbgTzr1XBbzMkEMuJqs0UjS7nolJFXjN8IPVQya8Zo=;
	b=5tna3SycdSBX1MJhggQxzC1HOXx448qAOt1QQdXcqAOv9S/nWhJ7mRa/PprBB/VUID5NCI
	D93D6MYrxC9B+BDg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] media: anysee: Fix and remove outdated comment
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-14-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-14-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903207972.1442.12884449447684800481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d2af954f225db2ccf446a4b174a5281dff171d41
Gitweb:        https://git.kernel.org/tip/d2af954f225db2ccf446a4b174a5281dff171d41
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:48 +02:00

media: anysee: Fix and remove outdated comment

anysee driver was transformed to use usbv2 years ago. The comments in
anysee_ctrl_msg() still are referencing the old interfaces where msleep()
was used. The v2 interfaces also changed over the years and with commit
1162c7b383a6 ("[media] dvb_usb_v2: refactor dvb_usbv2_generic_rw()") the
usage of msleep() was gone anyway.

Remove FIXME comment and update also comment before call to
dvb_usbv2_generic_rw_locked().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-14-dc8b907cb62f@linutronix.de

---
 drivers/media/usb/dvb-usb-v2/anysee.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-usb-v2/anysee.c
index 8699846..bea12cd 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -46,24 +46,15 @@ static int anysee_ctrl_msg(struct dvb_usb_device *d,
 
 	dev_dbg(&d->udev->dev, "%s: >>> %*ph\n", __func__, slen, state->buf);
 
-	/* We need receive one message more after dvb_usb_generic_rw due
-	   to weird transaction flow, which is 1 x send + 2 x receive. */
+	/*
+	 * We need receive one message more after dvb_usbv2_generic_rw_locked()
+	 * due to weird transaction flow, which is 1 x send + 2 x receive.
+	 */
 	ret = dvb_usbv2_generic_rw_locked(d, state->buf, sizeof(state->buf),
 			state->buf, sizeof(state->buf));
 	if (ret)
 		goto error_unlock;
 
-	/* TODO FIXME: dvb_usb_generic_rw() fails rarely with error code -32
-	 * (EPIPE, Broken pipe). Function supports currently msleep() as a
-	 * parameter but I would not like to use it, since according to
-	 * Documentation/timers/timers-howto.rst it should not be used such
-	 * short, under < 20ms, sleeps. Repeating failed message would be
-	 * better choice as not to add unwanted delays...
-	 * Fixing that correctly is one of those or both;
-	 * 1) use repeat if possible
-	 * 2) add suitable delay
-	 */
-
 	/* get answer, retry few times if error returned */
 	for (i = 0; i < 3; i++) {
 		/* receive 2nd answer */

