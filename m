Return-Path: <linux-tip-commits+bounces-6508-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D6B4A62A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529EC7B9467
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B4279DAE;
	Tue,  9 Sep 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SARl7aLf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swH2Vh2v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6A2773E4;
	Tue,  9 Sep 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408209; cv=none; b=MIbx9EJjbQ1gHRItrvN9KNZZp+OOmNVDcuBTkC88UMbaSS+gAa4zTY8BNdAITvrItPBA69WGN7p/BYk+hAD6KuQ4w8nQSjcCL5/5v3lZ3c0tSWlaNoYYCK/XPVrD67vpx9qbulsmrDJl0xqtFpSMFe76WHF1Bo/300bo5YLSgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408209; c=relaxed/simple;
	bh=MTW14w+T/zJLgsT8B09vqIpiawzZTWV2cBZi/DkX1yQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WCok75NmRCvqpLsyMer8Y5dbRZWn7UNUesZVZqnn+j6hEd6HnIs/pmezQAlq4g/mOT6yDfvFbETGxNvgRZggyKFzK4zI1bYh40JnyrwCENtP6cqDhgZx/vS3jHHbHyRzi9kWuArTuyb2DIOlAlYxW4GpUM28VQp0Fn+QTm+rHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SARl7aLf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swH2Vh2v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaljhOIY5QlxBCOOgLJkFVaTOHjBhxFiNyVtI2H9zw4=;
	b=SARl7aLfYG2InoN/rW6UkYu78blcdhUge1YtHanJOQ9k4j+NyWdLh9fn4Slti+oh+WwWHQ
	Q6hZpiW1eaQbBAO44uBo9MANY7jbocK2EfKJNvJG5XCsPESqZUbSutNXjyOwom3Ag4J0uh
	jkuJoZJlFxs1K1uyChSp9zQEBUaENl/jX/l61TrU3saunXgzvz+ofm5a3Le6+UqPqG9f9O
	SEoMsT0eqC6w7kDe7PgF0jebOzEsmfA4qoowkJYn/xq/3WJne3LX2GtGSgOUqt1bzVszm7
	UAtlzwOeLrM03Yn6TIRHAKuVOVpwV1RK7TK8+Ijw2kjJR6Tw1vR+RZ+RKSxUrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaljhOIY5QlxBCOOgLJkFVaTOHjBhxFiNyVtI2H9zw4=;
	b=swH2Vh2vzp8IPLi2spt8HpH3xnBhjbnjaFwTpdUBgKtmyA9Mk7VvKFlU25gBCT1f1HJgqW
	CmLCiOAt1DQDX2DA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib: test_objpool: Avoid direct access to hrtimer
 clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-4-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-4-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820471.1920.11741044703321103209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     18422ad1d8c6c7aa6563ea157fccd34041dade19
Gitweb:        https://git.kernel.org/tip/18422ad1d8c6c7aa6563ea157fccd34041d=
ade19
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:18 +02:00

lib: test_objpool: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-4-b962=
cd9d9385@linutronix.de

---
 lib/test_objpool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 8f68818..6a34a75 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -164,7 +164,7 @@ static enum hrtimer_restart ot_hrtimer_handler(struct hrt=
imer *hrt)
 	/* do bulk-testings for objects pop/push */
 	item->worker(item, 1);
=20
-	hrtimer_forward(hrt, hrt->base->get_time(), item->hrtcycle);
+	hrtimer_forward_now(hrt, item->hrtcycle);
 	return HRTIMER_RESTART;
 }
=20

