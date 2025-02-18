Return-Path: <linux-tip-commits+bounces-3462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E361DA398F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373A33B08E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C6235347;
	Tue, 18 Feb 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQkMrDxO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1u9h2p+C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD352343C2;
	Tue, 18 Feb 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874386; cv=none; b=IL7odimh8tEc+IveWLhOWI61h5UqwAo2TvcV/IxAJp5IlowTREytI3JDNkKTEnjPjQPwvvSbFY0Mi4OzAcuBzXTVdu5EYiCQEu3Ennf00UaAbYOZ04FpP4BCvfVbwssEQ1C/AY/mv37qfhyZynpkiTLrClK3YNT0Qd6zd/ntmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874386; c=relaxed/simple;
	bh=5ngm+THeP8/ZimpS2RiCeKi91X4efR0PfhxsU0hC27E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aTtWFd2mPsjjdK4xiVq4jWVuvbSTwzyv5a6cJ0KRJmyCWNbPZCNLLwZEjtKIjslnLJ32KN68zbSyVmLL5g/B+5fyIQeacPRQ/G6HFK+E5ETrMjg34lrHYIcMK6475cuHQwVi7MQKFMpU80HQu4fAk5dyUoSPOFQ0FrPjJiAc27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQkMrDxO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1u9h2p+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdQ6ILIhlZrzxMgC+lugmFgSDIG7BB1omUwy2zcSCYM=;
	b=iQkMrDxOSboW/5mfQMkseVhwfDj3XXVFeotU3ScGAuXL+dPkQy0F+vbYyHrk0M+/u27C60
	aoWOfCXVU5uaQYIVlFXerOQxwwhi6XAbUHyFJ/jFZp6Q9wNigyYQrAVE+SQor2Ptb+txNY
	qXxYkDz905sgBhO3qhWkBgwoOfvIcDB2oICzdyyjtegAH1HVwQ+BosbpfLcv8vpj6+ZLs0
	2sLLjx5eRfajyC5rWo8TrNieIgW5Bmx2g8jXnJXoJ1kAswZAbZOJ3XJ0IRoiHKVeIwQ0ga
	oHa4HPzcFl/VqAUZjdJl1LMDFluTmqfXx8YV1yxG4vdK/y8Z9fDfv/219HC0sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdQ6ILIhlZrzxMgC+lugmFgSDIG7BB1omUwy2zcSCYM=;
	b=1u9h2p+CupiGVts2o2Dbleo3BVWnJvQn2ozxzOWL703FCPPX6k9bwOF+zKP001YsWNCYXH
	xiWRgrmxcUT2FxBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] virtio: mem: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4a911503d16684592b59a16d8ade97e42df64a54=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4a911503d16684592b59a16d8ade97e42df64a54=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438286.10177.17824292141120175891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7b5edfd278b04bd158c14554dd494ec00aa9e275
Gitweb:        https://git.kernel.org/tip/7b5edfd278b04bd158c14554dd494ec00aa9e275
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:07 +01:00

virtio: mem: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/4a911503d16684592b59a16d8ade97e42df64a54.1738746904.git.namcao@linutronix.de

---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8a294b9..56d0dbe 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2950,8 +2950,8 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	mutex_init(&vm->hotplug_mutex);
 	INIT_LIST_HEAD(&vm->next);
 	spin_lock_init(&vm->removal_lock);
-	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vm->retry_timer.function = virtio_mem_timer_expired;
+	hrtimer_setup(&vm->retry_timer, virtio_mem_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	vm->retry_timer_ms = VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 	vm->in_kdump = is_kdump_kernel();
 

