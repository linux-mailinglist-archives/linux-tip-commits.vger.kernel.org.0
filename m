Return-Path: <linux-tip-commits+bounces-6533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2AB4AABD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D66E1888745
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD631CA7F;
	Tue,  9 Sep 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T67DxZk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FXIoK4xD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DF31C573;
	Tue,  9 Sep 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413869; cv=none; b=lR2xNebaH/tHFTLgOX2o+7EuBr9PcONiSFLUp+Pne2KBvNvMoBi1e3D78imQhtF9XAgpCiOlb2o9l/9SQhpY7iDo/cCgc9+9XOsfD00KIvaIdU8b4WFG851bs8tjMyFU+PXP/n3IMYCuvjto8pFsV8+wQEAFIjtoD6EIAZb9T18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413869; c=relaxed/simple;
	bh=jPFMPkuhd+aESxm9o+xhmUUBR5vu/KnjF6Nth6zg8TA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dz2FbwxeJ6wyvkYBigHdDD/mkKQFAfpLU/6j+/nd3aWeNWZBtJTkppdUM4f/cUTGSRos9rqHnk0yH6bVOu2o29PYqMYucscjmK/4wvbhLtxvdb1KDXoBETr8x4HYOQJFmeTCSJU0+HHdCIVMCR8SQcDAxJ1V/5RdK9EanHCp3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T67DxZk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FXIoK4xD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAN7gwuu6pDkHWfgfB5Gzolr1lKHzXu6s0CPF8E2USw=;
	b=T67DxZk2NT0iEThOpqVIefTXPKB3bDJ454aIIP1qJ2eswTWIxFSm6lzKbU7nBugLM8gafp
	iPab7HfPEpbjipBWBKj0S/z9zF+vN9DGc0XwID9GVljHwFf0yeq/94ZEX8s9YXRtaGrCz8
	4SK+v5hdnd+trS1IwZA1E/tmwBYPVA2aFMgp+zftPlqE3Us35AIFxxcDkQCsYEfrqUg4n4
	VVSvkiopuKRGn5rpD7wPMNcbfw5W3bHReM1WNjtwwPHPJfGNJl4KWmq6UfJexpjKqstdIj
	WxMJseXU252rGIPrtlUqDxfGS46BYgtn/YaS3Q/mUc+hYMZJLq9V7/RqZQ4L5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAN7gwuu6pDkHWfgfB5Gzolr1lKHzXu6s0CPF8E2USw=;
	b=FXIoK4xD8QIK0/M4bMbFCe5xoKOW6d3X5sUH4kgOpFmYXQpPpmAinCNxGFPmxkIvqaQtg6
	W8uV4n7D32DX5yBw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib: test_objpool: Avoid direct access to hrtimer
 clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-4-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-4-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386429.1920.3302705539719217395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e8875795160b484f691938ce07a381e77821f947
Gitweb:        https://git.kernel.org/tip/e8875795160b484f691938ce07a381e7782=
1f947
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

lib: test_objpool: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-4-3ae8=
22e5bfbd@linutronix.de

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

