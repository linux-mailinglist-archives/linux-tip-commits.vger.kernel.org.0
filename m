Return-Path: <linux-tip-commits+bounces-3417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF2A39791
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B863B1B7C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219D23C8C4;
	Tue, 18 Feb 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0e+wuamV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+6oGGXP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085B23959F;
	Tue, 18 Feb 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871998; cv=none; b=pahS78oovG/VrlWhE0UhVgCGW6Wc5OmuJckzQz4HU592+OowBEwoZNfwcR0Xq7dXqIcdWg9HqP4G8cjD1/oP3xPD3uF2XY2BHb1muFJKMsVCQ46lfE2IGUQ4ZugAicOTBx6R/HilAL9IHyVuk3nwL4rREhqBOcC/uObYsmHeoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871998; c=relaxed/simple;
	bh=E+7+smWrAMEUIuP3kxto+6GekRrJswGbRF40KJE6K+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YzVDxbLW+ofd+sRUnswvCsdc3indcwlBeduSr/oYD8hH2CJCXUWj0LKqq/PqSOMzDV7zAKTGSRvZZ0axioXOsVjRdOfWLojiH0UpBDTAGQ4Q7TG37/BRlDVzYZLQQCZvGQf88CzwibpS4r/6PAPzWSn19p0ZhZOduhUZEnr/6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0e+wuamV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+6oGGXP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkL39S4mGwxkBfobM8WHKV5kzQCkwgixoiPaVEQbvnE=;
	b=0e+wuamVQkGaAuXx21e6Agx/LzX0eDyDX4qXQ0kkelXkPG14pfTOfCZPZuwljLx6BRbaYn
	86yK6ozhJwNU/UxLrnFAumS6P2vYFOfUNMdP/X8y6n9mvRVKmHoNpEM/LPswFLf/u1W8/W
	Tt9Q0A50QBUCBGiyXyu6XBwxi+N1B3rtOjpXc/UG2BqGDSd3lgGejy0jJECa/4y2/tm6nx
	nVA4WjDPIoUTHj9Zp3WKKPAulJ8KPuu4jrDBNUyG4Ows+T6D/nN9IOuYkz+P2+Fn2AZyK6
	zf/Ha+aZBdUav1sYLmy9Tvpfaxx7NNbiT0Kmpm2FrrganPCd1iXx8BIcySblJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkL39S4mGwxkBfobM8WHKV5kzQCkwgixoiPaVEQbvnE=;
	b=0+6oGGXPI9n29YdruhN84DAHyfxwUXvJnNgFKGsJDZQ9gN7VHsqi+4SbHOTU0fMNn0LUXz
	6qOOdbTxq0+DRCCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] timerfd: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2d1f26c2c2f3ad15f1ca1a09ecb9d760cafef4a6=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C2d1f26c2c2f3ad15f1ca1a09ecb9d760cafef4a6=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199405.10177.3452203337520071422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     9eeb54b47541d2ea51315af324e236bb6e6942ea
Gitweb:        https://git.kernel.org/tip/9eeb54b47541d2ea51315af324e236bb6e6942ea
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

timerfd: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/2d1f26c2c2f3ad15f1ca1a09ecb9d760cafef4a6.1738746821.git.namcao@linutronix.de

---
 fs/timerfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 9f7eb45..cee007e 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -205,9 +205,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
 	} else {
-		hrtimer_init(&ctx->t.tmr, clockid, htmode);
+		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, htmode);
 		hrtimer_set_expires(&ctx->t.tmr, texp);
-		ctx->t.tmr.function = timerfd_tmrproc;
 	}
 
 	if (texp != 0) {
@@ -429,7 +428,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
 	else
-		hrtimer_init(&ctx->t.tmr, clockid, HRTIMER_MODE_ABS);
+		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, HRTIMER_MODE_ABS);
 
 	ctx->moffs = ktime_mono_to_real(0);
 

