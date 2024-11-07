Return-Path: <linux-tip-commits+bounces-2817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B59BFC27
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A1F1F22F94
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E6194C8B;
	Thu,  7 Nov 2024 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjCJZSu8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HT40Mrna"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A60193436;
	Thu,  7 Nov 2024 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944788; cv=none; b=UdKWNh/PeD7oDFTlO6eJyYOWT3Na3I/Ng+1GTUJj5lYlOJ6imx+DLvn5nBpCVxRSAdtdiqfnxw3lzgOtNGmn7jteprENolW0m7dzAN0oNJF+pm7UfxfOvGER63YZAc+TNsmurctd/BEFy7x7VyDjJJCk0M/klGFIv9SSZY0A3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944788; c=relaxed/simple;
	bh=gz4Grdy2CEsEzfDId62Yt+zkh4J/5d/0c6qwaHumBBQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZTnFpUuLTKjytOmvihYkxPfuLX3HwqRCWZBoadoQugG+gg5ZlW6PMwP7KEhvuZQ7X+zDgyLUA/8v13yURUYT78gvNTPZG54/6gi4R9kbot6L7n96is+CpenaKsOBYQdBpspWvkXkUCBDuxMFTkvqp1pP6A4Os9Tf/vlEDUI44mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SjCJZSu8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HT40Mrna; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU40/MRjX4NTzH+AnGzfbsnpX7uQvVdxSeluXucA5Wo=;
	b=SjCJZSu80jaYaT+bncgZevxPRCfLmWE8vtDgHbVnKb+1cem5yYwtoM+c4KkktXTJ9DTZ5H
	sihOU94XZjkin6w1OM08V8QeZTTchaRwMwV53XYm+ZsayphzOrggDRAEHL1gUKpKeIZ3d/
	Lys6Cj87R4KEVuPa7ahwUGUtZ7bUGx/e49LZ1x+OYrLfwrFtkZeKvn69Qr9xVzHvsT9TpW
	MeJXAkMXyeIXhW04Q0ijSglMtk3O/t2w+SdPZKyvtlg1lvbW9DRI/J/ZVI3brroCsNm3jr
	cUxRPfBxKCB7sL+vYr2QfXq9PChrhlq1+KI/5wmAgcqVFDekkUm0z8/QHwQakA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU40/MRjX4NTzH+AnGzfbsnpX7uQvVdxSeluXucA5Wo=;
	b=HT40MrnayML0SwIgO0R4EP4bCEC+tQ+ahXvfvFlOCA+3L7Qovnfk4aoSrAXUSph/zFgqut
	Vwa9al38U5cCZ2Dw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] io_uring: Remove redundant hrtimer's callback
 function setup
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	":"@tip-bot2.tec.linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C07b28dfd5691478a2d250f379c8b90dd37f9bb9a=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C07b28dfd5691478a2d250f379c8b90dd37f9bb9a=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478488.32228.3520314238506969137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c95d36585b9f8c43a4c5d5a9fe22477a138b63f4
Gitweb:        https://git.kernel.org/tip/c95d36585b9f8c43a4c5d5a9fe22477a138b63f4
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

io_uring: Remove redundant hrtimer's callback function setup

The IORING_OP_TIMEOUT command uses hrtimer underneath. The timer's callback
function is setup in io_timeout(), and then the callback function is setup
again when the timer is rearmed.

Since the callback function is the same for both cases, the latter setup is
redundant, therefore remove it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jens Axboe <axboe@kernel.dk:
Link: https://lore.kernel.org/all/07b28dfd5691478a2d250f379c8b90dd37f9bb9a.1730386209.git.namcao@linutronix.de

---
 io_uring/timeout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9973876..2ffe5e1 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -76,7 +76,6 @@ static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
 			list_add(&timeout->list, ctx->timeout_list.prev);
-			data->timer.function = io_timeout_fn;
 			hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 			spin_unlock_irq(&ctx->timeout_lock);
 			return;

