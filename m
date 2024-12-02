Return-Path: <linux-tip-commits+bounces-2905-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187B9E0066
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846F7B29B2A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F01FF5FF;
	Mon,  2 Dec 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPBV4BG5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAM3yZaJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067821FECAD;
	Mon,  2 Dec 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138058; cv=none; b=AQOm7MR7tnk7g9rqCtMnB4kx1TitODanuDYcs9VxYA9KriFsyjBCA/xIHZGCcEa3DkIWlJZmCr+7VmSZdqPf4ImduiHjq5fyNdS10GifN1vcb4a2+mRzKAp6ClblV1OO5tdj9r/nBGSEKo2D/69k9z4bflzIAEM3v86zU+u2RxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138058; c=relaxed/simple;
	bh=xcvadBoG0e+OULmKQbYdi6rbjaeAWPwOxJZUGKnQ29Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CWIWgPNoxt8N708KyM7473Sl686Q/A3TaY0TpKMlFy7KW3n5jzSm+/8ueYvIMdzOrsUQna+/niHdG7ESv22th3Sb0v8WB/coYBqJT3aLa0XzSezrG66/D+SKivlr/YH/tsp2IZYsPlt65XcmwU42iioVxyeGhQC9dBEVTBHH2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PPBV4BG5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAM3yZaJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIeqbfI4NjOUCh2F7cKk47SFriapkQt9vWXFdJxVtZ4=;
	b=PPBV4BG5NUZ6f0e/OILStQ2a98DY6eoSw/6NhA9cNxYU4I2t+1H8FtT+hMKlDk1z2Wu8l4
	npNu0fySESRtwcSIgDNvm0GBJ4QRBvpMR9Ad1w17hT7Dy1NPPH8uzB+FvZsbdSml97/nyv
	yWSAdhD4WQiW7F5pY0sQegW5umcJveOVDE+gppyPvYv53GtnczWASdfL64mSB3kxoITZmQ
	BB2ELefhx+YNfVytpEq04QApI26P0wpC30dUd8rrO+CSdv1yKI2O2wDtlDiqfmE+A/t7SP
	ueianXvnk4IUKv11gK0M7V9o3eFoyDhjbxqXqg0OwtBkuQ7R0OqytJSIJQWWwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIeqbfI4NjOUCh2F7cKk47SFriapkQt9vWXFdJxVtZ4=;
	b=sAM3yZaJLSxU+C/hAU6u/Mu4/PepWDID0ZaQOboG9ouxJ8lWqgaUAYtc8fv0xegsgznCnx
	A4FivL7ybL3erNAQ==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Remove the global variable rapl_msrs
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-9-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-9-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805444.412.14474756773372469878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bdc57ec7054842e5cb3b0a2da87b0e73075a96e6
Gitweb:        https://git.kernel.org/tip/bdc57ec7054842e5cb3b0a2da87b0e73075a96e6
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:08:04 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:36 +01:00

perf/x86/rapl: Remove the global variable rapl_msrs

Prepare for the addition of RAPL core energy counter support.

After making the rapl_model struct global, the rapl_msrs global
variable isn't needed, so remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-9-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8cdc578..aef2d0e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -150,7 +150,6 @@ static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
 static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
 
 /*
@@ -382,7 +381,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
+	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -811,9 +810,7 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_pkg_msrs;
-
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();

