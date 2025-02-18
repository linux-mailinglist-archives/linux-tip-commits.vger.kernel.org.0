Return-Path: <linux-tip-commits+bounces-3496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F7A398F8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEE7A1601
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C092267F40;
	Tue, 18 Feb 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rBAjCmnj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nja8l0EO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FB265CB7;
	Tue, 18 Feb 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874408; cv=none; b=QRsZ1+plAYsGrMi3pMD3j0QCebgMSj0urUSPDxPQBUrsymSX3L8FLrMOCluUboUvDTF2RxFEd/K7hI45dNQTVLtZ56wq6hz/9UP+zqN9PUWERvp3rdC4Ge4jeSpQmvbJcbcReo5xNUAMSPabMfb1qTrUAGSFN+d0CPY9FdUnmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874408; c=relaxed/simple;
	bh=cu6JxsEI6EBhcEx+BGNCsXBrsW3oWINSfBxQZgaO0hc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sarV37Z2EGyrhchI1SnP50O/A33rzisNL/InUlly4KscZv9WUBwTyexenKKRojvdnwHzCh+aWIw3U3xnMEIW14bbnYAri4y4q+d80MQSGjhizes8PvBl0vqERKFzLih7e7xh9Gm/NLtoazSLhuqt9a8Lvlv/NNwK7axD9xivQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rBAjCmnj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nja8l0EO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai3fcYtiESrN6GpSrrZkya0K5nuKKEMZeejiXvgzDOY=;
	b=rBAjCmnj2Vyi8/a/1xyDfqSv29xTBewscScmF2r+8mjbg2KVjLOcZNJzfBNqFYT232kIh/
	oGqK+tfmaRs6S+Ok8W2yR2tAkSiH1jx0g5/Tfm/aB5pdeKCJQphYaku5cUPNj+V0xQWZZJ
	5GpzKVzMBm2JwCtzTudMW32p4IDeYYzzp7nedryrYnaB2wRt+jTVEncEu19m6ZOJmCjMPC
	JDV8BljtBtbOI7hvfkjGWMSrYUGOykupV41n0w5njZY4hl93G6n2j5FXQSgeFPPXgv0odF
	HfPNww7WaE9au1zjYRynVUjlXSWMtzBPtHc7D/dt9ztwwWHe+s/vaNhslBv79g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai3fcYtiESrN6GpSrrZkya0K5nuKKEMZeejiXvgzDOY=;
	b=Nja8l0EOfydluSf/cH05YQhyki7YZyQMmeOOOYMOD1p46EvcPDnXvGWIzD+G5/rT/9F8zD
	CX+oY82xOPIF9/Bw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] usb: musb: cppi41: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C80d59a56c76c76ace982417e4dc8ddd37a5441d7=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C80d59a56c76c76ace982417e4dc8ddd37a5441d7=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440469.10177.14006280430079596452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     8073d9dfe2ef1a8b1959cc3ae7ef1db6239e53e5
Gitweb:        https://git.kernel.org/tip/8073d9dfe2ef1a8b1959cc3ae7ef1db6239e53e5
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

usb: musb: cppi41: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/80d59a56c76c76ace982417e4dc8ddd37a5441d7.1738746904.git.namcao@linutronix.de

---
 drivers/usb/musb/musb_cppi41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 9589243..4cde3ab 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -760,8 +760,8 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
 	if (!controller)
 		goto kzalloc_fail;
 
-	hrtimer_init(&controller->early_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	controller->early_tx.function = cppi41_recheck_tx_req;
+	hrtimer_setup(&controller->early_tx, cppi41_recheck_tx_req, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	INIT_LIST_HEAD(&controller->early_tx_list);
 
 	controller->controller.channel_alloc = cppi41_dma_channel_allocate;

