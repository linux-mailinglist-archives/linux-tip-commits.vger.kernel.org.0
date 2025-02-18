Return-Path: <linux-tip-commits+bounces-3420-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857EA39778
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819B4174EC0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131482405EC;
	Tue, 18 Feb 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8tNn0Wr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oeEQ0e7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43A23CF1F;
	Tue, 18 Feb 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872000; cv=none; b=dwmWf1asbAu93i3EV7ggNLWSf0raiftCjc+SPj2aStfp/NHzGfVZmRd1/vr4kkXFImtwt3bjMV6QDgs4yd2tDLG6nQLg5Z+kBmBvtUpFbA/esHDrD3lQhmfMzDOCQ3FuHma8HxmH10nLZRv+zzJ5sJEvssYhdwp9j+z18oX5ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872000; c=relaxed/simple;
	bh=LXeAewe0m+2aXSriPjXhI4iG9/byN2DuxTBGj6bhIEM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L9SYJQEH3htThvN+orsHqc6QF33P2Mz0j+YrKMcDDP3QS0dJJxZ8vpqPt7Nn0Sm/Fc9w2VxTXJD+KIhw+rXU8sEjayYzzMuqnK++MCWHPo2zj3UvLYIvNAC4KLfcxLAEUPb86CBxdrDbT4hUY6Yw4iqfNkTrAianKNzp9W6O0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8tNn0Wr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oeEQ0e7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8PTcBT8zl5Xrd6OscILGCu58Dx+Ap9dmp8JYgt2Qoc=;
	b=i8tNn0WrzZr4pU3GMAcB8+yBYn5lXqA0tIm2lrDBT9OxLlSvthdWSPsq1VUil3S6VLyL+6
	LAcbhXZ7fS8RELWEQBaIQTWq6bHkXCOmSqqdxiT1ISuTlASQu/9MIhy3lZ+KA64A2B5152
	fDH5np5PxammkYsAYVuoxBi3wuY2B4lW58FzSvzEiWYi7vtr2DxUuXT17KIlKnRPkblNRW
	LTnMgvFmCondpw/pAkGGSocihjHZnXMSk8X5bzMUjx4as4cGi2qVPEtqkVoUOsXFaG+sff
	JZWfsW119pLmQEftfkXxtknHUfUWTgT1AkNN29gPAipySoLztBfnwXKE6VNzUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8PTcBT8zl5Xrd6OscILGCu58Dx+Ap9dmp8JYgt2Qoc=;
	b=0oeEQ0e7R4OdkEYxj5bYq7R6a0omqP2tfdjrd7CJNlMFWv+MZMJ/4CmAPknzoPZrJ4tbF/
	mPSqd6lcm8I/ZQBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] io_uring/timeout: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C80ca8d959f2cc67c75f6d61008e3bebfe7fbc30a=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C80ca8d959f2cc67c75f6d61008e3bebfe7fbc30a=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199633.10177.1912670689008459666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4248fd6f37c1995fbc62cd563ab451094dadb412
Gitweb:        https://git.kernel.org/tip/4248fd6f37c1995fbc62cd563ab451094dadb412
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

io_uring/timeout: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/80ca8d959f2cc67c75f6d61008e3bebfe7fbc30a.1738746821.git.namcao@linutronix.de

---
 io_uring/timeout.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 48fc8cf..c5fb817 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -407,8 +407,7 @@ static int io_linked_timeout_update(struct io_ring_ctx *ctx, __u64 user_data,
 	io = req->async_data;
 	if (hrtimer_try_to_cancel(&io->timer) == -1)
 		return -EALREADY;
-	hrtimer_init(&io->timer, io_timeout_get_clock(io), mode);
-	io->timer.function = io_link_timeout_fn;
+	hrtimer_setup(&io->timer, io_link_timeout_fn, io_timeout_get_clock(io), mode);
 	hrtimer_start(&io->timer, timespec64_to_ktime(*ts), mode);
 	return 0;
 }
@@ -430,8 +429,7 @@ static int io_timeout_update(struct io_ring_ctx *ctx, __u64 user_data,
 	data->ts = *ts;
 
 	list_add_tail(&timeout->list, &ctx->timeout_list);
-	hrtimer_init(&data->timer, io_timeout_get_clock(data), mode);
-	data->timer.function = io_timeout_fn;
+	hrtimer_setup(&data->timer, io_timeout_fn, io_timeout_get_clock(data), mode);
 	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), mode);
 	return 0;
 }
@@ -557,7 +555,6 @@ static int __io_timeout_prep(struct io_kiocb *req,
 		return -EINVAL;
 
 	data->mode = io_translate_timeout_mode(flags);
-	hrtimer_init(&data->timer, io_timeout_get_clock(data), data->mode);
 
 	if (is_timeout_link) {
 		struct io_submit_link *link = &req->ctx->submit_state.link;
@@ -568,6 +565,10 @@ static int __io_timeout_prep(struct io_kiocb *req,
 			return -EINVAL;
 		timeout->head = link->last;
 		link->last->flags |= REQ_F_ARM_LTIMEOUT;
+		hrtimer_setup(&data->timer, io_link_timeout_fn, io_timeout_get_clock(data),
+			      data->mode);
+	} else {
+		hrtimer_setup(&data->timer, io_timeout_fn, io_timeout_get_clock(data), data->mode);
 	}
 	return 0;
 }
@@ -627,7 +628,6 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 	}
 add:
 	list_add(&timeout->list, entry);
-	data->timer.function = io_timeout_fn;
 	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 	raw_spin_unlock_irq(&ctx->timeout_lock);
 	return IOU_ISSUE_SKIP_COMPLETE;
@@ -646,7 +646,6 @@ void io_queue_linked_timeout(struct io_kiocb *req)
 	if (timeout->head) {
 		struct io_timeout_data *data = req->async_data;
 
-		data->timer.function = io_link_timeout_fn;
 		hrtimer_start(&data->timer, timespec64_to_ktime(data->ts),
 				data->mode);
 		list_add_tail(&timeout->list, &ctx->ltimeout_list);

