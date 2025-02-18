Return-Path: <linux-tip-commits+bounces-3421-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC490A3979D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85E73B7187
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087E2405EB;
	Tue, 18 Feb 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dV91M+/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4G1p5/we"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF823F27A;
	Tue, 18 Feb 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872000; cv=none; b=tHnlM/92PQhPaRwFMob6O1fEFk4TVWrk4PBrCAwvqxX4RVh1ehTMCqIzKVp3pOUmKR0CoHBSXCCqh9OkhsPp5np6shDnIaulnar9JGFZQzcv7rJfUPGw4dpA4K3ZoJFKe7aO6YXY4C8c9RD3Q0MPDL3ODQ3SRvzaGrWMzWEyXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872000; c=relaxed/simple;
	bh=gnpMduEdPDhtS0DUH0Rlu98W5IKCbZmDKVoV6OROKMg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HNGGlsXUB5UXS1cOwIufVpSRR1XMz5FZVheHckXeFhOBo7KUT3Tw1gj3mQTqD9OsLmTBH/HHcprIg1l5fwpk/mONg755rgblBCtRROgr7iM9x5tjKlwvBzQYhzs8+CsWxH2OWL3lZKCWOPN/OHFmCGCfnEh0PZQc09kR882yQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dV91M+/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4G1p5/we; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDyIDi/MXaU1NKzA2NH431Zz5wGboN42OSIhwdzS6ak=;
	b=dV91M+/Np4vn+VN88BoopRu7A59KfXPY4X8bwVwI6cdYRAhuBL6bESmwpYyXhsaF0KfLUK
	f5xKoUqHafbG4pX8NOLEsPxCdCmF4lHj5BnE9sX5v4ph99noQSKFFT80cPI6G5ylW6Rtq/
	PV4PPo6x5EGB6c+cd1ORtjemrGLpRlTjvuOvNJsrW/XlteMH7h4BOegZPWfvOckOA5fbMX
	hEkp1ieW89DbHQjYBFErHvlZLghDdZ3IP9xt8A5S/+Gpixf7xq/v7NiyC6yOdd48vW8REz
	lJuif3aBoWGj/zrg7DyQJeE5SWwEhGFXWgC7I8LfgXuXZRm5Yzt9pyuIHz8hxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDyIDi/MXaU1NKzA2NH431Zz5wGboN42OSIhwdzS6ak=;
	b=4G1p5/weS/2SeS/1J/kZ0wSnTEPnYWBFvNfpYPxoz2yulgM0QTNZIjSecMP1fwT+nIC5jT
	UaTlJPPLIdqsvbAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] lib: test_objpool: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cedc46fbf290b280ebe67bb0d21599c4c30716b68=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cedc46fbf290b280ebe67bb0d21599c4c30716b68=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199692.10177.15963036312991897581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     b09dffdeb3691483fc8fbe58ff7787c964b56d5c
Gitweb:        https://git.kernel.org/tip/b09dffdeb3691483fc8fbe58ff7787c964b56d5c
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

lib: test_objpool: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/edc46fbf290b280ebe67bb0d21599c4c30716b68.1738746821.git.namcao@linutronix.de

---
 lib/test_objpool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 896c013..8f68818 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -190,8 +190,7 @@ static int ot_init_hrtimer(struct ot_item *item, unsigned long hrtimer)
 		return -ENOENT;
 
 	item->hrtcycle = ktime_set(0, hrtimer * 1000000UL);
-	hrtimer_init(hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrt->function = ot_hrtimer_handler;
+	hrtimer_setup(hrt, ot_hrtimer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	return 0;
 }
 

