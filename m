Return-Path: <linux-tip-commits+bounces-3464-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9106A398C7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51278174C2B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37030238D3B;
	Tue, 18 Feb 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kOdoj+G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q0J394o9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839F2343C0;
	Tue, 18 Feb 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874388; cv=none; b=AktNeysh0sU9XVMVFMZQICw2C4LZduEe9twWfYlUTNoSEM1oxENHJzgyVX6n9ihJtSfoCj7upaHGhKHfehwz6NH8e8FAw6ZA3k4Ugt+6ny2czDdmNeHWiIPIu8ouZvz8ieXCPR+aeqXG2TE5wRv9iKqOtxH/v3KnUgYIDbPdj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874388; c=relaxed/simple;
	bh=4AHe++ik2XJTo41GPK2kMWQ7rsog80eV+DHxBC3alVc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IdW0gnDYeAqk1WnjPiitbAxu/Oulz3t8p7MSPxobk/MEIWzwCssjyk8cp7YicOM9AOSMd+Sif0i6XF1zm+l1ZZftU1bYXft4b+y4pSJIe3A6k4HMQug/Hzzlnp4G6v84dmj4M3IhP2ELhPm8U222I6GnsSYeLFhaTcEctefSa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kOdoj+G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q0J394o9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXW8OgtP03pQgNQAC7VaiRn6UPMNrTohA6CD6fQgaT4=;
	b=4kOdoj+GFyqF5Z88g3z61EuMlBtdw6ssEUvzQFI3lO0eCf3VXBDffsB3rb+xhZ9lQc61aI
	iq7PcIgQ9MXNbXXsG4cXddsRxigf3/pjgttn2/A5jVXJxmwjZ9/qULUv0s/rvYcAJqzLZL
	ApDGtIsMkRRAR8/1iohCViMMEVeo0MvxK23V4jFwJsDoqjNUnLrVk47P/hNRmdL7UDoFJk
	Z50PH2phu40blokZxBVcJZfcwaOZxK3vefzQEaMaf0Zp9NCvmODTLBwpC+KAiislBm0FCj
	ZGbHJcanevtDdq8E5c4q6ewSCMMbEaQu9/3/OqZjqFgUOOoEoOp2C4Wi4otuwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXW8OgtP03pQgNQAC7VaiRn6UPMNrTohA6CD6fQgaT4=;
	b=q0J394o96xiNKZkSVd3qKU0eFoRFDTOYjKbR2CNSpEIECOid22cEh4HBeXwypHRAdUBEZL
	PQjvaf/Fw3T+H2Cg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/xe/oa: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C08238e193b1f63ae7d5d607fa975420735a869a5=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C08238e193b1f63ae7d5d607fa975420735a869a5=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438422.10177.10252847273639578543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     397c07a3c90b18f09caa6ec4e00597f47319fbee
Gitweb:        https://git.kernel.org/tip/397c07a3c90b18f09caa6ec4e00597f47319fbee
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/xe/oa: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/08238e193b1f63ae7d5d607fa975420735a869a5.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/xe/xe_oa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index fa873f3..f03b3a9 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1766,8 +1766,8 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 
 	WRITE_ONCE(u->exclusive_stream, stream);
 
-	hrtimer_init(&stream->poll_check_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	stream->poll_check_timer.function = xe_oa_poll_check_timer_cb;
+	hrtimer_setup(&stream->poll_check_timer, xe_oa_poll_check_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	init_waitqueue_head(&stream->poll_wq);
 
 	spin_lock_init(&stream->oa_buffer.ptr_lock);

