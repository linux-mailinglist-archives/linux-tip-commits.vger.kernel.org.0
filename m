Return-Path: <linux-tip-commits+bounces-7144-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0687C28705
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4B4F12B2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470230AAD6;
	Sat,  1 Nov 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lv71U4Z5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QC/o3xFe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54A309DA1;
	Sat,  1 Nov 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026473; cv=none; b=ThfqDtXjOFx82IL5nUWMJeFrfPrzW+QkADnv/RSxi0Q2zdziw0gi8CrVa2OjD/o20S4QgEt1YX41CfcKegGQrR+178pwkWQk9dxf/elE9fT1mz15giOGjccHMgxbHZxTImwsByrNjsS/3JqJfs9IZpBePhCdosdfq5EgahokodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026473; c=relaxed/simple;
	bh=UDVJnCaQmcP/iNk1upyG2ocODsFyO6/MZ8Kluxn3DHg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P/iDoTV2LHL/m1HguSXb9PqNdvnWIFzW+8ou0PslFbTwfPuckgFBSbcZj9TwR8OV9lXyS49/XPDV5uyg5ZUGSiwmJH5zZDo6U0Kh+qELktT4mqDpKWEkowIx5oiL8945qrAIeh5I0ATqkfAICMuXvwA2fli3BJGNd0GGvB4/AFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lv71U4Z5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QC/o3xFe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtHN3Gu8gbfsNIPZUw/GxCfYvdpCOp0Dp4AJUt0ZRAw=;
	b=Lv71U4Z5tSxP9r6iPOL54RmKOtLhxmezntepcX+pHeq2vTNjxeMd4SN43PxAzsu/z6Bdek
	DqcjuaiWnYbWzV3nh+mGs0mH9CRBS7iobK3FjUKjk42c4RZREj8cKPsCQDUmZluJ3SKRV2
	X/Bx9Ujf4USs5YfZmzuXA0A7R3G1uEbXKYqor2HviuAfabMHliv2rkSP5omh4EL/0Ki17k
	5cmoKi0WSWlZmXLgWoAyOQP4Av5Aslh8L/vkbQSvdpA0KdvpXbU2W2hQVeqARsOIFMyWKw
	eIfy0VUwdtynlxZJA01bjrm7g+x2NREDpDTlVA6ES+4tXSwlCxC7K0RNon3+kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtHN3Gu8gbfsNIPZUw/GxCfYvdpCOp0Dp4AJUt0ZRAw=;
	b=QC/o3xFeQ11ZQliC6NB3wKlm2FtDze8TJhP3XHJvgsglP1efQqaIRrCBrJDSQEVaQzMPh2
	A94xsHqxQ3MvI5CA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso/datastore: Drop inclusion of linux/mmap_lock.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-22-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-22-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202646917.2601451.3212898496174733533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     8ebb65c38828760ed028f637850d4b4c62655993
Gitweb:        https://git.kernel.org/tip/8ebb65c38828760ed028f637850d4b4c626=
55993
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:06 +01:00

vdso/datastore: Drop inclusion of linux/mmap_lock.h

This header is unnecessary and together with some upcoming changes would
introduce compiler warnings.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/lkml/20250916-mm-rcuwait-v1-1-39a3beea6ec3@linu=
tronix.de/
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-22-e0607bf4=
9dea@linutronix.de
---
 lib/vdso/datastore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 2cca4e8..7377fcb 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
=20
 #include <linux/linkage.h>
-#include <linux/mmap_lock.h>
 #include <linux/mm.h>
 #include <linux/time_namespace.h>
 #include <linux/types.h>

