Return-Path: <linux-tip-commits+bounces-6452-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA1B4373E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128A37A9FF0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D992FC88C;
	Thu,  4 Sep 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABcOGIU0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pql1dti3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC02FC027;
	Thu,  4 Sep 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978349; cv=none; b=VajcGRQS0ygH7v7zjKyMvp+kQWUJeUHuMt+RfAWLT0MP+68Kwvp8PR/9rIxjTWyDtnoRW82dYY7ihIrE53jdOA+f2TjhT+aRI1s31rY759LBEy/261wcR1Qu3ClEFgk1prFnBMDYHW5otejpE2W2GVkAEsDzeeq7M5OMCAp+vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978349; c=relaxed/simple;
	bh=iWaxHgE1EK/RG4QaTr6cx5vvpnFzJxSCZWsiyIzIH14=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fjQSONQJpcdAqAPjEqHFjobhMpiX4YLP+CT1v0oqcYBZ+4S4GXDkSggSW17VYmB6FAyzLzXPx4Tvx8c2KiVhQSf0PENcb+EBs2/HtvFEgCCMVeF1HaN1APtqrg1QAyEiUXunYSwX1KpfD1wJf0CBMJGaTRGQaVRe4iD2tzlcyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ABcOGIU0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pql1dti3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvBqsCpQHvVJE9vxlqKs3ep88LF+kr98rn6pzWZcprs=;
	b=ABcOGIU0a32XQPN4slPV9n7l0rg2qJ6thHhuSw80NN7Xnu7W/GF+sJz9wjUDVNNrS2F57b
	56q1oR8sMhxJjyYetTiuXdOuUX5K4P27A22eQVkPRqGT5RTj1fnR0R2MHEN1+vZUo9DFq4
	f0Zlgw93YEubfey3bxbPuOlX12yFZcczeQ4jKSYsQOr357SR3dfsSDnMwTlrkYU5bEP0+p
	x8ed9wr5qvo+1aDn2VfHMXgNYtCr11BJUMXNYibNiAXSoHsXbto7FtAFFb4cnCaY2l12/J
	s2TxAj6gm83dg4PRIDy4BmBCPtUwGCWANVoWaB8/5qzjm7YvZUCLxASswVZYWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvBqsCpQHvVJE9vxlqKs3ep88LF+kr98rn6pzWZcprs=;
	b=Pql1dti3ZVmX/IPFzmsCCyxxIBr2gCNhGm9fxs64TuiDClSoa4XQDBHrDhKwGCWe2Tcg/M
	5XhPjYQvnSZ375CA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datastore: Gate time data behind
 CONFIG_GENERIC_GETTIMEOFDAY
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-1-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-1-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697834531.1920.17519023914521515930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7c0c01a216e6d9e1d169c0f6f3b5522e6da708ed
Gitweb:        https://git.kernel.org/tip/7c0c01a216e6d9e1d169c0f6f3b5522e6da=
708ed
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:49 +02:00

vdso/datastore: Gate time data behind CONFIG_GENERIC_GETTIMEOFDAY

When the generic vDSO does not provide time functions, as for example on
riscv32, then the time data store is not necessary.

Avoid allocating these time data pages when not used.

Fixes: df7fcbefa710 ("vdso: Add generic time data storage")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-1-d9b65750e49f@li=
nutronix.de

---
 lib/vdso/datastore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 3693c6c..a565c30 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -11,14 +11,14 @@
 /*
  * The vDSO data page.
  */
-#ifdef CONFIG_HAVE_GENERIC_VDSO
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static union {
 	struct vdso_time_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_time_data_store __page_aligned_data;
 struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
-#endif /* CONFIG_HAVE_GENERIC_VDSO */
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
=20
 #ifdef CONFIG_VDSO_GETRANDOM
 static union {
@@ -46,7 +46,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mappin=
g *sm,
=20
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
-		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
+		if (!IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
 			return VM_FAULT_SIGBUS;
 		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
 		if (timens_page) {

