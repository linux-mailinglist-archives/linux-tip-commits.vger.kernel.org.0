Return-Path: <linux-tip-commits+bounces-2452-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54B99FB67
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB70B21C7C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37151D63CE;
	Tue, 15 Oct 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xHPqAV8s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37c/4Mt3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26D1CACDB;
	Tue, 15 Oct 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030993; cv=none; b=edizZifwEZyY4KRiE1hexAt1TJtLVHXxAH22dTLAyYXbmjAqz6jMWnnMmGEvsaui3USutVXoL9y5o4cln2ddltv6fBfzMs5Uxgi4pIbB3gTviwwSEtB6Z5NZJKWc7/SfU0e96PSfphzBztfti4zKiEhFpge+PPRRa+JhxQkCmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030993; c=relaxed/simple;
	bh=LYAYjzbXcCCmTW7PL8BZudARwDf6uv4DLSXifWXmoS0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T3Qalts7vokwVkn6EK/KFWiukC58EJYVlyGrzobAsn9ZRVH2YCqYvesSFQd6mqdSrIRxIuGMYyPDj733Xd6yNR7RHebuLz3QcjAuwkqaELGqAC2paj7ZbB88LOpdzoJgNgZ43v+KvzBc9QKjk+M+xrKBNQtNytoIsM/nHzXQVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xHPqAV8s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37c/4Mt3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729030990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZ/LVyARVwZxDHEzpzW3H9mQtTsYHEOSXSa0cnWvdrw=;
	b=xHPqAV8s2YgATbkIUCU6kQ4yNk4cEOycW2vrTUihbjLGg7+KYUfLEf3BRx2prXRKz7YFSU
	+/2x7qiaGvIOjKhp+eT1fXDjPe6aZ4fD7y1d1zJfbO9yN0m8gwaxjYi1uRVyqOzYzAjHZ4
	juHTi4f41FARJuxCx+g3JJYIm62ULCn3AzF5MMV1klspqFKpfXLV6J/ZQOda6NM0DV5bPo
	BgygloyJaFlSR6g6I2VpHOYyrds2dBM2v7S/kmXCJIN5839n8PB8zl0mTP/7XDSQljBVgw
	qcTll3KPlfGszTHJ2h5UDbyoVzhj2xziMI5QHNxS/fBdshfUFp+nCEdjz0gX6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729030990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZ/LVyARVwZxDHEzpzW3H9mQtTsYHEOSXSa0cnWvdrw=;
	b=37c/4Mt3shBP/jw0a1KvRPalbqHpJHRywwerjtrKlGwa+wh7i46LPYT1ULO9Z6RAKMWw0H
	hFXeLaTiwO8VsjCw==
From: "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] drm: i915: Change fault type to unsigned long
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241014151340.1639555-2-vincenzo.frascino@arm.com>
References: <20241014151340.1639555-2-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903098946.1442.235442083227869360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     8fd236b00fc1bc40e2f9205d0121a2de5ea506d0
Gitweb:        https://git.kernel.org/tip/8fd236b00fc1bc40e2f9205d0121a2de5ea=
506d0
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Mon, 14 Oct 2024 16:13:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:13:04 +02:00

drm: i915: Change fault type to unsigned long

Fault is currently of type u32 and with the introduction of the
generalized vdso/page.h we trigger the error below:

drivers/gpu/drm/i915/gt/intel_gt_print.h:29:36: error: format =E2=80=98%lx=E2=
=80=99 expects
argument of type =E2=80=98long unsigned int=E2=80=99, but argument 6 has type=
 =E2=80=98u32=E2=80=99 {aka
=E2=80=98unsigned int=E2=80=99} [-Werror=3Dformat=3D]
   29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
      |                                    ^~~~~~~~
include/drm/drm_print.h:424:39: note: in definition of macro =E2=80=98drm_dev=
_dbg=E2=80=99
  424 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
      |                                       ^~~
include/drm/drm_print.h:524:33: note: in expansion of macro =E2=80=98drm_dbg_=
driver=E2=80=99
  524 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARGS_=
_)
      |                                 ^~~~~~~~~~~~~~
linux/drivers/gpu/drm/i915/gt/intel_gt_print.h:29:9: note: in expansion of ma=
cro
=E2=80=98drm_dbg=E2=80=99
   29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
      |         ^~~~~~~
drivers/gpu/drm/i915/gt/intel_gt.c:310:25: note: in expansion of macro =E2=80=
=98gt_dbg=E2=80=99
  310 |                         gt_dbg(gt, "Unexpected fault\n"
      |                         ^~~~~~

This happens because the type of PAGE_MASK depends on the architecture.

Prevent the compilation error changing the 'fault' type to unsigned
long.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/20241014151340.1639555-2-vincenzo.frascino@=
arm.com

---
 drivers/gpu/drm/i915/gt/intel_gt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/int=
el_gt.c
index a6c69a7..bb29f36 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -302,7 +302,7 @@ static void gen6_check_faults(struct intel_gt *gt)
 {
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
-	u32 fault;
+	unsigned long fault;
=20
 	for_each_engine(engine, gt, id) {
 		fault =3D GEN6_RING_FAULT_REG_READ(engine);
@@ -310,8 +310,8 @@ static void gen6_check_faults(struct intel_gt *gt)
 			gt_dbg(gt, "Unexpected fault\n"
 			       "\tAddr: 0x%08lx\n"
 			       "\tAddress space: %s\n"
-			       "\tSource ID: %d\n"
-			       "\tType: %d\n",
+			       "\tSource ID: %ld\n"
+			       "\tType: %ld\n",
 			       fault & PAGE_MASK,
 			       fault & RING_FAULT_GTTSEL_MASK ?
 			       "GGTT" : "PPGTT",

