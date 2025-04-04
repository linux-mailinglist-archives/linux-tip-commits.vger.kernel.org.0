Return-Path: <linux-tip-commits+bounces-4674-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC4A7C27A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31103BA8B8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EE21D3E6;
	Fri,  4 Apr 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/BnwmoO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCV9C2b3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9F21CA0D;
	Fri,  4 Apr 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788052; cv=none; b=WI7ZL7AR/GnCgot25eM1GTwr+Nsfe22e89LleCCv2Rus2E2Ea7kMm+rhF4+wZjGHMiuU6EKgj5K+xUqEYohpspao6v5E1qeItHksSlujZTSnu0rtCIv2G3PTmI/q+owYkN9yTvetmW0eWuF6kBGWONculSfGZUG9lk0WcOwS7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788052; c=relaxed/simple;
	bh=uy5GjBGm4bGNkJ3fdfsVrr5QRaH6C8Cot84CpzH3bKQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H3/HhMDfff2HU4kK9z1WCidbuBmHYcF+t2c2BbApMSTfwbZYwrVrbMuQASQMU+qdtEsWc8vjKF1zTpLDA3vWMptQdb1sMezJmppq+ZhWDFWVJ/+pWWKIZ0QSUuTm+kr2qo/wVOBWPhGDemm+92TrhHwcRSJL9ubAaQ6sCFiYoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/BnwmoO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCV9C2b3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNYjRPAL5IqVVoY4xyv1t5HbsoaNDQt4gxGvEn8V2R0=;
	b=a/BnwmoOctNtKPxjCFGRBtgyskhsUmWnhqYZXrhXzaz5vusvPteQeGv/7Hv4SmGWoa11UB
	2RAVdjCwbJpgWDenj9qjfhJgmNoS4Jl+fRzbvat/13dTreJioxhSVsr6/cFDmDz6BGAM2/
	rWIW6Ip7uU3oOiOvbZvfXNoo9+yHWMOSnGnxu7wSWf7YDQoKoZyG7HQsmMKIC2yUDj38ka
	Q83SPWauIerKspkLVMpmTNYLxZFNJ+aYXU+r7PY+bk6AWx1vm8+vJaffzyVYd7AzzKp2oQ
	LSra6MEM8sRJuG/KC6q0bzdZH1aT5GMlDTMSwTFJxf+xYHiLPCfbPcRkVmrz8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNYjRPAL5IqVVoY4xyv1t5HbsoaNDQt4gxGvEn8V2R0=;
	b=hCV9C2b3JPLtDmsj7nhune2yEuVuOY0KeI0WXCsm8+Da2ECuGYLznE+Gj1jfRVtm9ApAY9
	8r3OcMYm1hVOQcAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename debug_init() to debug_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378804882.31282.1476222459402333919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     87d5dc5551d8943920ea126bd85d499d69480972
Gitweb:        https://git.kernel.org/tip/87d5dc5551d8943920ea126bd85d499d69480972
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:44 +02:00

hrtimers: Rename debug_init() to debug_setup()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init() to debug_setup() as well, to keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4b730c1f79648b16a1c5413f928fdc2e138dfc43.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8cb2c85..472c298 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -465,9 +465,7 @@ static inline void debug_hrtimer_activate(struct hrtimer *timer,
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 #endif
 
-static inline void
-debug_init(struct hrtimer *timer, clockid_t clockid,
-	   enum hrtimer_mode mode)
+static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enum hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1648,7 +1646,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 		   clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(timer, clock_id, mode);
+	debug_setup(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);

